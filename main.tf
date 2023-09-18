
resource "aws_db_subnet_group" "db_subnet_group" {
    name                = "my_database"
    description         = "My Private data Subnet Group"
    subnet_ids          = var.private_data_subnet_ids
  
}

resource "aws_db_instance" "my_db" {
  identifier           = "my-database"
  allocated_storage    = var.db_allocated_storage
  storage_type         = var.db_storage_type
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = var.skip_final_snapshot
  backup_retention_period = 7
  multi_az             = var.multi_az  # Enable Multi-AZ deployment for high availability
  
  vpc_security_group_ids = [aws_security_group.db_sg.id]  # Security group IDs
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  
  tags = merge(
    var.resource_tags,
    {
      Name = "${var.aws_region}-${var.resource_tags["Project"]}-database"
    }
  )
}

#Security group for the load balancer
resource "aws_security_group" "db_sg" {
    name = "database-security group"
    description = "Security group for the database"
    vpc_id = var.vpc_id
    tags        = merge(
    var.resource_tags,
    {
      Name = "${var.aws_region}-${var.resource_tags["Project"]}-db-sg"
    }
  )

  #  Allow inbound traffic from private application IPs
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.private_application_subnet_cidrs
  }

  # Allow outbound traffic from your RDS instance to reach the AWS RDS service endpoints
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}