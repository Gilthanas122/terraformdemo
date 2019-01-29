resource "aws_instance" "example" {
  ami = "ami-6d27a913"
  instance_type = "t2.micro"

  connection {
    user = "root"
    type = "ssh"
    public_key = "${file(AWS_ACCESS_KEY_ID)}"
    private_key = "${file(AWS_SECRET_ACCESS_KEY)}"
    timeout = "2m"
  }
}



