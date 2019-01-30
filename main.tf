provider "aws" {
 profile = "${var.profile}"
  shared_credentials_file = "~/.aws/credentials"
  region = "${var.aws_region}"
}

resource "aws_security_group" "instance" {
  name = "terraform_example_instance"

  # SSH access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web-server" {
  ami = "ami-6d27a913"
  instance_type = "t3.micro"
  security_groups = [
  "terraform_example_instance"
  ]
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    type="ssh"
    user = "ec2-user"
    # The path to your keyfile
    private_key = "${file("/home/pityu/.ssh/pityu_test.pem")}"
  }
  key_name = "pityu_test"

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install docker -y",
      "sudo service docker start",
      "sudo sysctl -w vm.max_map_count=262144",
      "sudo sysctl -w fs.file-max=65536",
      "sudo docker run -p 5601:5601 -p 9200:9200 -p 5044:5044 -it --name nagios --ulimit nofile=65536:65536 -d jasonrivers/nagios",
    ]
  }

  # Our Security group to allow HTTP and SSH access
}
