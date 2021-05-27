provider "aws" {
    profile = "terraform"
    region = "us-east-2"
}

resource "aws_instance" "web" {
     ami = "ami-00399ec92321828f5"
     instance_type = "t2.micro"
     #user_data= "${file("install_apache.sh")}"
     vpc_security_group_ids = [aws_security_group.web_server.id]
     user_data = file("install_apache.sh")

    
}

resource "aws_key_pair" "terra2" {
  key_name   = "terra2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdqKeiDNcvOO4kFdyv/34U3hcr6MIceo1A7dqSeYEjzIrS7aFUH++U8B+oOZenZ4itLaxR2zFmsetmj4n5r3aXA2ZtFaOjC3JhnsWIviyRLgPIRJG4OI9bbgof7AVUIyR28nQzGntw2VRI7a1d7w+r1CuqzhbCaKeuLmdUAQfvTi5iWe9WlwHUNzd23gTH6KQGorUb0Pwr/NJved4hQlluLvOcKqfs7OpCiRrS4pg/XnZKgfdWkBHbZXF6a7cikQ+n1qrH2hqXZ8jsY5xrM1mRl1Axy0bVP998OB9l5pIlMB57/PJJa6E3P9VZdWGA8Ybjsssg+RBJbcj7E0D5dT8v2P6evt7sRJ/BABW241jAAVRQt7uJYIFxPYFF+Buirt5w4NB5GaGztdty4UxqsC5FtxTPg6elU6wfgmh4URXbDk0cXfhxIjudhTKnoSL7q5c959ryZefTErAegXSq40v4W6qgFlCmwh8WplCPgYRK/dbsc4Mr4JbfOTKB6deZOA8="

}

resource "aws_security_group" "web_server" {
  name        = "webserver"
  description = "First Web server"
  
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}
    
