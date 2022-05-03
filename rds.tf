resource "aws_db_subnet_group" "mysql" {
  name       = "mysql"
  subnet_ids = [aws_subnet.subnet[3].id, aws_subnet.subnet[4].id, aws_subnet.subnet[5].id]

  tags = {
    Name = "mysql-subnet-group"
  }
}

resource "aws_db_instance" "wordpress" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "wordpress"
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
}

resource "aws_security_group" "rds-sg" {
  name        = "rds-sg"
  description = "Open port 3306"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [aws_security_group.wordpress-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "rds-sg"
  }
  depends_on = [aws_security_group.wordpress-sg]
}