resource "aws_db_instance" "mysql_db" {
  allocated_storage = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "${var.DB_name}"
  username             = "${var.MYSQL_USERNAME}"
  password             = "${var.MYSQL_PASSWORD}"
  parameter_group_name = "default.mysql5.7"
  availability_zone = "us-east-1b"
  skip_final_snapshot       = true

  tags = {
    Name = "MYSQL-instance"
  }
}