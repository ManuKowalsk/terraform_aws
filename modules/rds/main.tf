resource "aws_db_instance" "defaultDB" {
  allocated_storage    = 20
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "Test2727$"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az = false
  db_subnet_group_name = aws_db_subnet_group.dbSubnetGroup.name
  vpc_security_group_ids = [var.security_group_db_id]
  tags = {
    Name = "default-DB"
  }
}

resource "aws_db_subnet_group" "dbSubnetGroup" {
  name       = "main_subnet_group"
  subnet_ids = [var.subnet_private1_id, var.subnet_private2_id]

  tags = {
    Name = "My DB subnet group"
  }
}


