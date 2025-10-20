###############################################################################
# Environment Variables
###############################################################################
eks_version            = "1.33"
region                 = "eu-central-1"
stage                  = "Dev"


#####################################################################
# EKS Variables
#####################################################################
instanceTypes        = ["t3.medium"]
minWorkers           = "1"
maxWorkers           = "2"
#ec2_keypair_public_key = "Add this in github action secrets and will call it as environment variable"


##########################################################################################
# admin access to cluster for this role
###########################################################################################
#aws_auth_role_arn = "Add this in github action secrets and will call it as environment variable"


