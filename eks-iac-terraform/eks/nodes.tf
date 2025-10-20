#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "eks-node" {
  name = "${local.cluster_name}-NodeGroup"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
POLICY
}

# This policy now includes AssumeRoleForPodIdentity for the Pod Identity Agent

resource "aws_iam_role_policy_attachment" "eks-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node.name
}

resource "aws_iam_role_policy_attachment" "eks-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node.name
}

resource "aws_iam_role_policy_attachment" "eks-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node.name
}

resource "aws_iam_role_policy_attachment" "eks-node-ebs-csi" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.eks-node.name
}


resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "${local.cluster_name}-ssh-keypair"
  public_key = var.ec2_keypair_public_key
}

################################
# Node group 1: creating with custom launch template configurations 
################################

resource "aws_launch_template" "eks_nodes" {
  name = "${local.cluster_name}-nodeGroup-lt"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 50
      volume_type = "gp3"
      #iops                  = 3000
      #throughput            = 125
      encrypted             = true
      delete_on_termination = true
    }
  }


  #Incase if we need to use custom image id then we can use this option and remove ami-type from nodegroup resource
  #image_id = "ami-test"
  instance_type = var.instanceTypes[0]

  key_name = aws_key_pair.ec2_key_pair.key_name

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
  }


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${local.cluster_name}-node"
    }
  }

  # If we have to initialize the node with custom script then we can use user_data.
  # note: in case we use the custom userdata then we should have node to cluster attaching configuration script within it, only then the nodes will get attached to the node group 
  # user_data = filebase64("${path.module}/example.sh")
}

resource "aws_eks_node_group" "eks-node" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  version         = var.eks_version
  node_group_name = "${local.cluster_name}-nodeGroup"
  node_role_arn   = aws_iam_role.eks-node.arn
  subnet_ids      = [data.aws_subnet.subnet_public_1.id, data.aws_subnet.subnet_private_2.id]
  ami_type        = "AL2023_x86_64_STANDARD"


  scaling_config {
    desired_size = var.minWorkers
    max_size     = var.maxWorkers
    min_size     = var.minWorkers
  }


  launch_template {
    id = aws_launch_template.eks_nodes.id
    #version = "$latest"
    # using static launch configuration version to avoid unintended rolling updates for chnages to the configuration 
    # if in case we change the instance configurations, once done update this to latest configuration number.
    version = "2"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.eks-node-ebs-csi
  ]

  tags = {
    stage = "${var.stage}"
  }

  labels = {
    k8s_labels = "test"
  }

  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [
      scaling_config
    ]
  }
}

#####################################
# End of custom launch template configuration for node group 1 
#####################################

resource "aws_cloudwatch_log_group" "ekscontrolplaneloggroup" {
  name              = "/aws/eks/${local.cluster_name}-${var.stage}/cluster"
  retention_in_days = var.retention-logs
}


