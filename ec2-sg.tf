resource "aws_security_group" "wordpress-sg" {
  name        = "wordpress-sg"
  description = "SG for Wordpress Application"
  vpc_id      = aws_vpc.wordpress_vpc.id

   
    dynamic "ingress" {
        for_each = var.ports
        content {
            description      = "TLS from VPC"
            from_port        = ingress.value
            to_port          = ingress.value
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
  }  
} 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "wordpress-sg"
  }
  depends_on = [aws_vpc.wordpress_vpc]
}

resource "aws_instance" "wordpress-ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "nanoec2"
  subnet_id     = aws_subnet.subnet[0].id
  associate_public_ip_address = true 
  vpc_security_group_ids = [aws_security_group.wordpress-sg.id]
  user_data = file("user-data.sh")

  tags = {
    Name = "wordpress-ec2"
  }
}