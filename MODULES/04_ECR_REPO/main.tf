resource "aws_ecr_repository" "this_ecr_repo" {
  name         = var.ecr_name
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "this_null" {
  depends_on = [aws_ecr_repository.this_ecr_repo]
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "docker images && docker build -t ${aws_ecr_repository.this_ecr_repo.repository_url}:latest ${path.module}/../../DOCKER/docker-sample-nginx/ && docker images && docker login --username AWS --password `aws ecr get-login-password --region us-east-1` 182263511292.dkr.ecr.us-east-1.amazonaws.com && docker push ${aws_ecr_repository.this_ecr_repo.repository_url}:latest"
  }
}

