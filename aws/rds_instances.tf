resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  tags = {
    Name = "main-db-subnet-group"
  }
}

locals {
  db_instances = {
    main_target    = { db_name = "pg-drift-db-main" }
    diff_target    = { db_name = "pg-drift-db-diff" }
    replica_target = { db_name = "replica" }
  }
}

resource "aws_db_instance" "target" {
  for_each = local.db_instances

  db_name         = each.value.db_name
  instance_class  = "db.t3.micro"
  snapshot_identifier = data.aws_db_snapshot.source.id

  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.postgresql_sg.id]
  publicly_accessible = true
  multi_az = false

  allocated_storage     = 50
  max_allocated_storage = 200

  deletion_protection = false
  skip_final_snapshot  = true
  apply_immediately    = true

  tags = {
    Name = "${each.key}"
  }
}