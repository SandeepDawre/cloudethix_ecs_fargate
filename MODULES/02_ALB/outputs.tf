output "alb_name" {
  value = aws_lb.this_alb.name
}

output "alb_arn" {
  value = aws_lb.this_alb.arn
}

output "alb_id" {
  value = aws_lb.this_alb.id
}

output "target_group_arn" {
  value = aws_lb_target_group.this_alb_tg.arn
}