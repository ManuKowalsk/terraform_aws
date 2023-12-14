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
  
  tags = {
    Name = "default-DB"
  }
}


