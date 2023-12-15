output "db_name"{
   value = aws_db_instance.defaultDB.db_name
}

output "db_username"{
   value = aws_db_instance.defaultDB.username
}

output "db_password"{
   value = aws_db_instance.defaultDB.password
}

output "db_endpoint"{
   value = aws_db_instance.defaultDB.endpoint
}