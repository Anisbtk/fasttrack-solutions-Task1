resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb_sg"
  }
}

resource "aws_lb" "app_lb" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_ids
}

resource "aws_autoscaling_group" "app_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  vpc_zone_identifier  = var.private_subnet_ids
  target_group_arns    = [aws_lb_target_group.app_tg.arn]
  launch_configuration = aws_launch_configuration.app_launch_config.id
  tags = [{
    key                 = "Name"
    value               = "app_asg"
    propagate_at_launch = true
  }]
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_launch_configuration" "app_launch_config" {
  image_id        = "ami-0c55b159cbfafe1f0"  
  instance_type   = var.instance_type
  security_groups = [aws_security_group.app_sg.id]
  user_data       = file("user_data.sh")
}

output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}
