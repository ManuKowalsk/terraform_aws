resource "aws_lb" "loadbalancer" {
  name               = "loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.loadbalancer_security_group]
  subnets = var.subnet_id_list

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "target-group-lb" {
  name     = "target-group-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "group-attachment" {
  count = length(var.instances_id)

  target_group_arn = aws_lb_target_group.target-group-lb.arn
  target_id        = var.instances_id[count.index]
  port             = 80
}

resource "aws_lb_listener" "lb" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-lb.arn
  }
}