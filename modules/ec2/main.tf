## EC2 ##

resource "aws_instance" "web" {
  count = length(var.parameters)
  ami           ="ami-06d4b7182ac3480fa"
  instance_type = "t2.micro"
  subnet_id = var.parameters[count.index].SubId
  vpc_security_group_ids = [var.ec2_security_group_id]
  user_data = templatefile("modules/ec2/init.sh",{
    host_env = var.db_endpoint
    dbname_env = var.db_name
    user_env = var.db_username
    password_env = var.db_password
  }
  )

  tags = {
    Name = var.parameters[count.index].name
  }
}

