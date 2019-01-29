resource "aws_instance" "example" {
  ami = "ami-6d27a913"
  instance_type = "t2.micro"

}

variable text{
type = "string"
 default= "Hello pityu"
 }

output "address" {
  value = "${var.text}"
}


