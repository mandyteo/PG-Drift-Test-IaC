resource "aws_security_group_rule" "allow_postgresql_access" {
  type              = "ingress"
  from_port        = 5432
  to_port          = 5432
  protocol         = "tcp"
  security_group_id = aws_security_group.postgresql_sg.id
  cidr_blocks      = ["0.0.0.0/0"]

  description = "Allow PostgreSQL access"
}

resource "aws_security_group" "postgresql_sg" {
  name        = "pg-drift-test-postgresql-sg"
  description = "Security group for PostgreSQL access"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "pg-drift-test-postgresql-sg"
  }
}