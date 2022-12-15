resource "aws_ecs_cluster" "crash" {
  name = "crash"
  capacity_providers = [
    "FARGATE"]
  setting {
    name = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "crash"
    Project = "crash"
    Billing = "crash"
  }
}


# rails
resource "aws_ecs_task_definition" "crash" {
  family = "crash"
  container_definitions = <<TASK_DEFINITION
  [
  {
    "portMappings": [
      {
        "hostPort": 8080,
        "protocol": "tcp",
        "containerPort": 8080
      }
    ],
    "cpu": 2048,
    "memory": 4096,
    "image": "${var.ecr_repository.repository_url}:latest",
    "essential": true,
    "name": "crash",
    "logConfiguration": {
      "logDriver": "awslogs",
      "secretOptions": null,
      "options": {
        "awslogs-group": "${var.log_group.name}",
        "awslogs-region": "${var.region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
TASK_DEFINITION

  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"]
  cpu = "2048"
  memory = "4096"
  execution_role_arn = var.ecs_role.arn
  task_role_arn = var.ecs_role.arn

  tags = {
    Name = "crash"
    Project = "crash"
    Billing = "crash"
  }
}

resource "aws_ecs_service" "crash" {
  name = "crash"
  enable_execute_command = true
  force_new_deployment = true
  cluster = aws_ecs_cluster.crash.id
  task_definition = aws_ecs_task_definition.crash.arn
  desired_count = 1
  launch_type = "FARGATE"
  platform_version = "LATEST"

  lifecycle {
    ignore_changes = [
      desired_count]
  }

  network_configuration {
    subnets = [
      var.ecs_subnet_a.id,
      var.ecs_subnet_b.id,
      var.ecs_subnet_c.id]
    security_groups = [
      var.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.ecs_target_group.arn
    container_name = "crash"
    container_port = 8080
  }
}

# sidekiq
resource "aws_ecs_task_definition" "sidekiq" {
  family = "sidekiq"
  container_definitions = <<TASK_DEFINITION
  [
  {
    "portMappings": [
      {
        "hostPort": 7433,
        "protocol": "tcp",
        "containerPort": 7433
      }
    ],
    "cpu": 2048,
    "memory": 4096,
    "image": "${var.sidekiq_ecr_repository.repository_url}:latest",
    "essential": true,
    "name": "sidekiq",
    "logConfiguration": {
      "logDriver": "awslogs",
      "secretOptions": null,
      "options": {
        "awslogs-group": "${var.sidekiq_log_group.name}",
        "awslogs-region": "${var.region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
TASK_DEFINITION

  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"]
  memory = "4096"
  cpu = "2048"
  execution_role_arn = var.ecs_role.arn
  task_role_arn = var.ecs_role.arn

  tags = {
    Name = "crash"
    Project = "crash"
    Billing = "crash"
  }
}

resource "aws_ecs_service" "sidekiq" {
  name = "sidekiq"
  enable_execute_command = true
  force_new_deployment = true
  cluster = aws_ecs_cluster.crash.id
  task_definition = aws_ecs_task_definition.sidekiq.arn
  desired_count = 1
  launch_type = "FARGATE"
  platform_version = "LATEST"

  lifecycle {
    ignore_changes = [
      desired_count]
  }

  network_configuration {
    subnets = [
      var.ecs_subnet_a.id,
      var.ecs_subnet_b.id,
      var.ecs_subnet_c.id]
    security_groups = [
      var.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.sidekiq_target_group.arn
    container_name = "sidekiq"
    container_port = 7433
  }
}

# blockchain
resource "aws_ecs_task_definition" "blockchain" {
  family = "blockchain"
  container_definitions = <<TASK_DEFINITION
  [
  {
    "portMappings": [
      {
        "hostPort": 3000,
        "protocol": "tcp",
        "containerPort": 3000
      }
    ],
    "cpu": 1024,
    "memory": 2048,
    "image": "${var.blockchain_ecr_repository.repository_url}:latest",
    "essential": true,
    "name": "blockchain",
    "logConfiguration": {
      "logDriver": "awslogs",
      "secretOptions": null,
      "options": {
        "awslogs-group": "${var.blockchain_log_group.name}",
        "awslogs-region": "${var.region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
TASK_DEFINITION

  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"]
  memory = "2048"
  cpu = "1024"
  execution_role_arn = var.ecs_role.arn
  task_role_arn = var.ecs_role.arn

  tags = {
    Name = "crash"
    Project = "crash"
    Billing = "crash"
  }
}

resource "aws_ecs_service" "blockchain" {
  name = "blockchain"
  enable_execute_command = true
  force_new_deployment = true
  cluster = aws_ecs_cluster.crash.id
  task_definition = aws_ecs_task_definition.blockchain.arn
  desired_count = 1
  launch_type = "FARGATE"
  platform_version = "LATEST"

  lifecycle {
    ignore_changes = [
      desired_count]
  }

  network_configuration {
    subnets = [
      var.ecs_subnet_a.id,
      var.ecs_subnet_b.id,
      var.ecs_subnet_c.id]
    security_groups = [
      var.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.blockchain_target_group.arn
    container_name = "blockchain"
    container_port = 3000
  }
}