provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "ec2public" {
  ami                     = var.ami_linux
  instance_type           = var.aws_instance_type
  associate_public_ip_address = "true"
  key_name = "ansible"
  root_block_device {
    volume_size = 9
  }
  user_data = <<-EOF
#! /bin/bash
sudo apt-get update -y
sudo apt install apache2 -y
echo " <html> <body> Hi Guvi- "This is terraform Task " </body> </html> " > /var/www/html/index.html
EOF


   tags = {
    Name = "MyEC2Instance"
  }
}

output "instance_ip_addr" {
  value       = aws_instance.ec2public.public_ip
}

