###############################################################################
# Variables - Environment
###############################################################################
variable "eks_version" {
  type        = string
  description = "kubernetes version"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

#################################################################################
# data Variables
#################################################################################

variable "stage" {
  type = string
}

variable "instanceTypes" {
  type = list(string)
}

variable "minWorkers" {
  type = string
}

variable "maxWorkers" {
  type = string
}

variable "ec2_keypair_public_key" {
  description = "EC2 key pair for EKS ssh"
}

variable "retention-logs" {
  type        = number
  description = "retention period of cloudwatch logs"
  default     = 30
}

variable "cluster-logging-types" {
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  description = "enabled Logging Type for Cluster"
}

variable "aws_auth_role_arn" {
  type = string
}