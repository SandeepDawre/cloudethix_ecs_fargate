resource "aws_lb" "this_alb" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_type
  security_groups    = var.alb_security_groups
  subnets            = var.alb_subnets
  tags = {
    name = var.alb_name
  }
}

resource "aws_lb_listener" "this_alb_listener" {
  load_balancer_arn = aws_lb.this_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this_alb_tg.arn
  }
}

resource "aws_lb_target_group" "this_alb_tg" {
  name        = var.alb_tg_name
  port        = "80"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.this_alb_tg.arn
  target_id        = aws_lb.this_alb.arn
  depends_on       = [aws_lb_target_group.this_alb_tg]
}



