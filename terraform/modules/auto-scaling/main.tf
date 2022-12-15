resource "aws_appautoscaling_target" "crash_target" {
  max_capacity = 5
  min_capacity = 1
  resource_id = "service/${var.ecs_cluster.name}/${var.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_target" "sidekiq_target" {
  max_capacity = 5
  min_capacity = 1
  resource_id = "service/${var.ecs_cluster.name}/${var.sidekiq_ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_target" "blockchain_target" {
  max_capacity = 5
  min_capacity = 1
  resource_id = "service/${var.ecs_cluster.name}/${var.blockchain_ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "crash_memory" {
  name               = "crash-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.crash_target.resource_id
  scalable_dimension = aws_appautoscaling_target.crash_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.crash_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = 80
  }
}

resource "aws_appautoscaling_policy" "sidekiq_memory" {
  name               = "sidekiq-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.sidekiq_target.resource_id
  scalable_dimension = aws_appautoscaling_target.sidekiq_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.sidekiq_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = 80
  }
}

resource "aws_appautoscaling_policy" "blockchain_memory" {
  name               = "blockchain-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.blockchain_target.resource_id
  scalable_dimension = aws_appautoscaling_target.blockchain_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.blockchain_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = 80
  }
}

resource "aws_appautoscaling_policy" "crash_cpu" {
  name = "crash-cpu"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.crash_target.resource_id
  scalable_dimension = aws_appautoscaling_target.crash_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.crash_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 60
  }
}

resource "aws_appautoscaling_policy" "sidekiq_cpu" {
  name = "sidekiq-cpu"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.sidekiq_target.resource_id
  scalable_dimension = aws_appautoscaling_target.sidekiq_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.sidekiq_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 60
  }
}

resource "aws_appautoscaling_policy" "blockchain_cpu" {
  name = "blockchain-cpu"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.blockchain_target.resource_id
  scalable_dimension = aws_appautoscaling_target.blockchain_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.blockchain_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 60
  }
}