provider "aws" {
  region = "us-east-2"
}


resource "aws_instance" "my_webserver" {
  ami = "ami-00399ec92321828f5"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  key_name = "blablabla"
  user_data              = <<EOF
#!/bin/bash
sudo apt -y update
sudo apt -y install apache2
echo "<h2>WebServer</h2><br>Build by Qantas!"  >  /var/www/html/index.html
sudo systemctl start apache2
chkconfig apache2 on
sudo adduser test
sudo usermod -aG sudo test
EOF

  tags = {
    Name = "Web Server Build by Terraform"
    Owner = "Qantas"
  }
}


resource "aws_security_group" "my_webserver" {
  name = "WebServer Security Group"
  description = "My First SecurityGroup"
  

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web Server SecurityGroup"
    Owner = "Qantas"
}