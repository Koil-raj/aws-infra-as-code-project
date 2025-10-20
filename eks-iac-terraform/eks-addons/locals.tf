# local variables which will be used inside the cluster 

locals {
  vpc_id = data.aws_vpc.landing_zone_vpc.id
}