resource "aws_lb" "elb" {
  name               = "crash-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    var.load_balancer_sg.id]
  subnets            = [
    var.load_balancer_subnet_a.id,
    var.load_balancer_subnet_b.id,
    var.load_balancer_subnet_c.id]

  tags = {
    Name = "crash"
    Project = "crash"
    Billing = "crash"
  }
}

resource "aws_lb_target_group" "rails" {
  name     = "rails"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 60
    path                = "/health"
    timeout             = 30
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "crash"
    Project = "crash"
    Billing = "crash"
  }

  lifecycle {
      create_before_destroy = true
    }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rails.arn
  }
}

resource "aws_lb_listener" "internal_alb_https" {
  load_balancer_arn = aws_lb.elb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = "arn:aws:acm:us-east-1:022743489870:certificate/9761f449-5740-4763-840b-1c7236413749"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rails.arn
  }
}

#sidekiq
resource "aws_lb" "sidekiq-elb" {
  name               = "sidekiq-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    var.load_balancer_sg.id]
  subnets            = [
    var.load_balancer_subnet_a.id,
    var.load_balancer_subnet_b.id,
    var.load_balancer_subnet_c.id]

  tags = {
    Name = "crash"
    Project = "crash"
    Billing = "crash"
  }
}

resource "aws_lb_target_group" "sidekiq" {
  name     = "sidekiq"
  port     = 7433
  protocol = "HTTP"
  vpc_id   = var.vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 60
    path                = "/"
    timeout             = 30
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "crash"
    Project = "crash"
    Billing = "crash"
  }

  lifecycle {
      create_before_destroy = true
    }
}

resource "aws_lb_listener" "sidekiq-http" {
  load_balancer_arn = aws_lb.sidekiq-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sidekiq.arn
  }
}


#blockchain
resource "aws_lb" "blockchain-elb" {
  name               = "blockchain-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    var.load_balancer_sg.id]
  subnets            = [
    var.load_balancer_subnet_a.id,
    var.load_balancer_subnet_b.id,
    var.load_balancer_subnet_c.id]

  tags = {
    Name = "crash"
    Project = "crash"
    Billing = "crash"
  }
}

resource "aws_lb_target_group" "blockchain" {
  name     = "blockchain"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 60
    path                = "/health"
    timeout             = 30
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "crash"
    Project = "crash"
    Billing = "crash"
  }

  lifecycle {
      create_before_destroy = true
    }
}

resource "aws_lb_listener" "blockchain-http" {
  load_balancer_arn = aws_lb.blockchain-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blockchain.arn
  }
}


#chat
resource "aws_lb" "chat-elb" {
  name               = "chat-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    var.load_balancer_sg.id]
  subnets            = [
    var.load_balancer_subnet_a.id,
    var.load_balancer_subnet_b.id,
    var.load_balancer_subnet_c.id]

  tags = {
    Name = "crash"
    Project = "crash"
    Billing = "crash"
  }
}

resource "aws_lb_target_group" "chat" {
  name     = "chat"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 60
    path                = "/"
    timeout             = 30
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "crash"
    Project = "crash"
    Billing = "crash"
  }

  lifecycle {
      create_before_destroy = true
    }
}

resource "aws_lb_listener" "chat-http" {
  load_balancer_arn = aws_lb.chat-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.chat.arn
  }
}

