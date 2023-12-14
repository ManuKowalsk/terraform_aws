
output "vpc_id"{
  value = aws_vpc.main_vpc.id
}


output "vpc_cidr_block"{
  value = aws_vpc.main_vpc.cidr_block
}

output "vpc_ipv6_cidr_block"{
  value = aws_vpc.main_vpc.ipv6_cidr_block
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

