resource "aws_db_subnet_group" "crash" {
  name       = "crash"
  subnet_ids = [
    var.ecs_subnet_a.id,
    var.ecs_subnet_b.id,
    var.ecs_subnet_c.id
  ]

  tags = {
    Name = "crash"
  }
}

resource "aws_db_instance" "crash" {
  identifier             = "crash"
  instance_class         = "db.t3.medium"
  allocated_storage      = 5
  max_allocated_storage  = 100
  engine                 = "postgres"
  engine_version         = "14.3"
  username               = "crashdb"
  password               = var.rds_password
  db_subnet_group_name   = aws_db_subnet_group.crash.name
  vpc_security_group_ids = [var.rds_sg.id]
  parameter_group_name   = aws_db_parameter_group.crash.name
  publicly_accessible    = false
  skip_final_snapshot    = true
}

resource "aws_db_parameter_group" "crash" {
  name   = "crash"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}