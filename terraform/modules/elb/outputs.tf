output "elb" {
  value = aws_lb.elb
}

output "ecs_target_group" {
  value = aws_lb_target_group.rails
}

output "sidekiq-elb" {
  value = aws_lb.sidekiq-elb
}

output "sidekiq_target_group" {
  value = aws_lb_target_group.sidekiq
}

output "blockchain-elb" {
  value = aws_lb.blockchain-elb
}

output "blockchain_target_group" {
  value = aws_lb_target_group.blockchain
}