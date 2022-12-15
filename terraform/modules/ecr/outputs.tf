output "ecr_repository" {
  value = aws_ecr_repository.crash
}

output "sidekiq_ecr_repository" {
  value = aws_ecr_repository.sidekiq
}

output "blockchain_ecr_repository" {
  value = aws_ecr_repository.blockchain
}