data "aws_db_snapshot" "source" {
  db_snapshot_identifier = var.rds_snapshot_identifier
}