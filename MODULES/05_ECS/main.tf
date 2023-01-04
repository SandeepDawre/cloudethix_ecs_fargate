resource "aws_ecs_cluster" "this_ecs_cluster" {
  name = var.ecs_name

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}


resource "aws_ecs_task_definition" "this_ecs_task_def" {
  family                   = var.task_def_name
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.this_ecs_task_role.arn
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_mem
  container_definitions    = jsonencode(var.container_definitions)
}


resource "aws_iam_role" "this_ecs_task_role" {
  name               = var.ecs_iam_role_name
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}


resource "aws_ecs_service" "this_ecs_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.this_ecs_cluster.id
  task_definition = aws_ecs_task_definition.this_ecs_task_def.arn
  desired_count   = 1
  //iam_role        = aws_iam_role.this_ecs_task_role.arn
  depends_on      = [aws_iam_role.this_ecs_task_role]

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
  network_configuration {
    subnets          = var.private_subnets
    security_groups  = var.service_security_groups
    assign_public_ip = false
  }
}







