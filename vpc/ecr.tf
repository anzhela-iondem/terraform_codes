# Create an ECR repository
resource "aws_ecr_repository" "app_image" {
  name                 = "flask-nginx-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}