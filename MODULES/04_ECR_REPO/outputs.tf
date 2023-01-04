output "ecr_name" {
  value = aws_ecr_repository.this_ecr_repo.name
}

output "image_uri" {
  value = format("%s:%s", aws_ecr_repository.this_ecr_repo.repository_url, "latest")
}