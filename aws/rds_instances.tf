resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  tags = {
    Name = "main-db-subnet-group"
  }
}

locals {
  db_instances = [
    "pg-drift-db-main",
    "pg-drift-db-replica"
  ]
}

resource "aws_db_instance" "target" {
  for_each = toset(local.db_instances)

  identifier = each.value
  instance_class  = "db.t3.micro"
  snapshot_identifier = data.aws_db_snapshot.source.id

  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.postgresql_sg.id]
  publicly_accessible = true

  apply_immediately = true
  skip_final_snapshot = true

  depends_on = [ aws_internet_gateway.main ]
}

resource "aws_db_instance" "diff_target" {
  identifier = "pg-drift-db-diff"
  instance_class  = "db.t3.micro"
  snapshot_identifier = data.aws_db_snapshot.source.id

  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.postgresql_sg.id]
  publicly_accessible = true

  apply_immediately = true
  skip_final_snapshot = true

  depends_on = [ aws_internet_gateway.main ]
}