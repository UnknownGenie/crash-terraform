output "log_group" {
  value = aws_cloudwatch_log_group.rails
}

output "sidekiq_log_group" {
  value = aws_cloudwatch_log_group.sidekiq
}

output "blockchain_log_group" {
  value = aws_cloudwatch_log_group.blockchain
}
