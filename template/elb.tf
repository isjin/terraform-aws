#alb
resource "aws_lb" "jtp_training_alb" {
  name               = "jtp-training-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public_subnets.*.id
  enable_deletion_protection = false
//  access_logs {
//    bucket  = "${aws_s3_bucket.lb_logs.bucket}"
//    prefix  = "test-lb"
//    enabled = true
//  }
  tags = {
    Environment = "jtp_training"
  }
}

#target group
resource "aws_lb_target_group" "tg_ecs_cluster" {
  name     = "tg-ecs-cluster"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpcs.*.id[0]
}

#regoster instance


#listener
resource "aws_lb_listener" "jtp_training_alb_8081" {
  load_balancer_arn = aws_lb.jtp_training_alb.arn
  port              = "8081"
  protocol          = "HTTP"
//  ssl_policy        = "ELBSecurityPolicy-2016-08"
//  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_ecs_cluster.arn
  }
  depends_on = [aws_lb_target_group.tg_ecs_cluster]
}