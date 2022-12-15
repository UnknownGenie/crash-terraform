resource "aws_ecr_repository" "crash" {
  name = "crash" 
}

resource "aws_ecr_repository" "sidekiq" {
  name = "sidekiq" 
}

resource "aws_ecr_repository" "blockchain" {
  name = "blockchain" 
}