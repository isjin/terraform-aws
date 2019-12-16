#subnet group
resource "aws_db_subnet_group" "jtp_subnet_group" {
  name       = "jtp_subnet_group"
  subnet_ids = aws_subnet.rds_private_subnets.*.id
  tags = {
    Name = "jtp_subnet_group"
  }
}

#parameter group
resource "aws_db_parameter_group" "jtp_parameter_group" {
  name   = "jtp-parameter-group"
  family = "mariadb10.2"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

#option group
resource "aws_db_option_group" "jtp_option_group" {
  name                     = "jtp-option-group"
  option_group_description = "jtp_option_group"
  engine_name              = "mariadb"
  major_engine_version     = "10.2"
}

#DB instance
resource "aws_db_instance" "jtp_mariadb" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.2.21"
  instance_class       = "db.t2.micro"
  identifier = "jtptraining"
  name                 = "jtptraining"
  username             = "jtp"
  password             = "password"
  port             = 3306
  parameter_group_name = aws_db_parameter_group.jtp_parameter_group.name
  db_subnet_group_name = aws_db_subnet_group.jtp_subnet_group.name
  option_group_name = aws_db_option_group.jtp_option_group.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  depends_on = [aws_db_subnet_group.jtp_subnet_group,aws_db_parameter_group.jtp_parameter_group,aws_db_option_group.jtp_option_group]
}

#DB snapshot
//resource "aws_db_snapshot" "jtp_mariadb_snapshot" {
//  db_instance_identifier = aws_db_instance.jtp_mariadb.id
//  db_snapshot_identifier = "jtptraining"
//}