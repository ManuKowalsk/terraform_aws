
output "vpc_id"{
  value = aws_vpc.main_vpc.id
}

output "subnet_private1_id"{
  value = aws_subnet.subnet_private1.id
}


output "subnet_public1_id"{
  value = aws_subnet.subnet_public1.id
}

output "subnet_private2_id"{
  value = aws_subnet.subnet_private2.id
}


output "subnet_public2_id"{
  value = aws_subnet.subnet_public2.id
}