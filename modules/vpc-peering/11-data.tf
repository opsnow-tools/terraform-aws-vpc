# data
  
data "aws_caller_identity" "peer" {
  provider = "aws.peer"
}

data "aws_region" "peer" {
  provider = "aws.peer"
}
