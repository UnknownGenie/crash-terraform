output "ecs_cluster" {
  value = aws_ecs_cluster.crash
}

output "ecs_service" {
  value = aws_ecs_service.crash
}

output "sidekiq_ecs_service" {
  value = aws_ecs_service.sidekiq
}

output "blockchain_ecs_service" {
  value = aws_ecs_service.blockchain
}