provider "aws" {
    region = "us-east-1"
}

provider "tls" {
  proxy {
    from_env = true
  }
}

module "wordpress" {
    source = "../"
    subnets_cidr = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24","10.0.3.0/24", "10.0.4.0/24","10.0.5.0/24"]
    vpc_cidr = "10.0.0.0/16"
    vpc_name = "wordpress_vpc"
    cidr_blocks = ["10.0.0.0/16"]
    ports = [22, 80, 8080]
    key_name = "wordpress_key"
    ami_id = "ami-0f9fc25dd2506cf6d"
    instance_type = "t2.micro"
    username = "admin"
    password = "adminadmin"
}