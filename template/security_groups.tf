# bastion
resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "bastion"
  vpc_id      = aws_vpc.vpcs.*.id[0]
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
//    security_groups = "sg-123456"
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "bastion"
  }
}

//resource "aws_security_group_rule" "bastion_3389" {
//  type            = "ingress"
//  from_port       = 3389
//  to_port         = 3389
//  protocol        = "tcp"
//  # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
//  cidr_blocks = ["0.0.0.0/0"]
//  security_group_id = aws_security_group.bastion.id
//}

# ecs_cluster
resource "aws_security_group" "ecs_cluster" {
  name        = "ecs_cluster"
  description = "ecs_cluster"
  vpc_id      = aws_vpc.vpcs.*.id[0]
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
//    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.bastion.id]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "ecs_cluster"
  }
}


#alb
resource "aws_security_group" "alb" {
  name        = "alb"
  description = "alb"
  vpc_id      = aws_vpc.vpcs.*.id[0]
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
//    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.bastion.id,aws_security_group.ecs_cluster.id]
  }
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
//    security_groups = [aws_security_group.bastion.id,aws_security_group.ecs_cluster.id]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "alb"
  }
}

#rds
resource "aws_security_group" "rds" {
  name        = "rds"
  description = "rds"
  vpc_id      = aws_vpc.vpcs.*.id[0]
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion.id,aws_security_group.ecs_cluster.id]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "rds"
  }
}

#ecs_cluster rule
resource "aws_security_group_rule" "ecs_cluster_all" {
  type            = "ingress"
  from_port       = 0
  to_port         = 65535
  protocol        = "-1"
  # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
  source_security_group_id=aws_security_group.alb.id
  security_group_id = aws_security_group.ecs_cluster.id
  depends_on = [aws_security_group.alb]
}




