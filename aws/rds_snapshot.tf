data "aws_db_snapshot" "source" {
  db_snapshot_identifier = var.rds_snapshot_identifier
}

data "aws_db_snapshot" "diff_source" {
  db_snapshot_identifier = var.rds_diff_snapshot_identifier
}