resource "aws_security_group_rule" "database_security_rule" {
  type              = "ingress"
  from_port         = 0
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr_block]
  ipv6_cidr_blocks  = [var.vpc_ipv6_cidr_block]
  security_group_id = "sg-123456"
}

