variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "eu-north-1"
}

variable "key_path" {
  description = "Path to SSH file"
  default = "/home/pityu/.ssh/pityu_test.pem"
}

variable "profile" {
  description = "AWS credentials you wish to uses"
}