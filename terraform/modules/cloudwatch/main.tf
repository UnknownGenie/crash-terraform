resource "aws_cloudwatch_log_group" "rails" {
  name = "rails"

  tags = {
    Name = "crash"
    Project = "crash"
  }
}

resource "aws_cloudwatch_log_group" "sidekiq" {
  name = "sidekiq"

  tags = {
    Name = "crash"
    Project = "crash"
  }
}

resource "aws_cloudwatch_log_group" "blockchain" {
  name = "blockchain"

  tags = {
    Name = "crash"
    Project = "crash"
  }
}