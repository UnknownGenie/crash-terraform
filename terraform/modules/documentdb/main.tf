resource "aws_docdb_subnet_group" "crash-docudb" {
  name       = "crash-docudb"
  subnet_ids = [
    var.ecs_subnet_a.id,
    var.ecs_subnet_b.id,
    var.ecs_subnet_c.id
  ]

  tags = {
    Name = "crash"
  }
}

resource "aws_docdb_cluster" "docudb-cluster" {
  cluster_identifier      = "crash-docudb"
  engine                  = "docdb"
  master_username         = "crashdb"
  master_password         = var.docudb_password
  vpc_security_group_ids = [var.docudb_sg.id]
  db_subnet_group_name = aws_docdb_subnet_group.crash-docudb.name
  skip_final_snapshot = true
}

resource "aws_docdb_cluster_instance" "docudb-instances" {
count              = 1
identifier         = "crash-docudb-${count.index}"
cluster_identifier = aws_docdb_cluster.docudb-cluster.id
instance_class     = "db.t3.medium"
}