resource "aws_elasticache_subnet_group" "default" {
  name       = "elasticache-subnet"
  subnet_ids = [
    var.ecs_subnet_a.id,
    var.ecs_subnet_b.id,
    var.ecs_subnet_c.id
  ]
}

resource "aws_elasticache_replication_group" "elasticache-cluster" {
  availability_zones = ["us-east-1a", "us-east-1b"]
  replication_group_id = "crash-cluster"
  replication_group_description = "replication group"
  node_type = "cache.t3.small"
  number_cache_clusters = "2"
  parameter_group_name = aws_elasticache_parameter_group.default.name
  port = 6379
  security_group_ids = [var.elasticache_sg.id]
  subnet_group_name = aws_elasticache_subnet_group.default.name
}

resource "aws_elasticache_cluster" "crash-multiplier-instance" {
  cluster_id           = "crash-multiplier-instance"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.default.name
  port                 = 6379
  security_group_ids = [var.elasticache_sg.id]
  subnet_group_name = aws_elasticache_subnet_group.default.name
}

resource "aws_elasticache_parameter_group" "default" {
  name   = "cache-params"
  family = "redis7"
}