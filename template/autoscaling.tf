# launch configuration
resource "aws_launch_configuration" "auto_scaling_launche_ecs_cluster_jtp" {
  name          = "jtp_ecs_cluster"
  image_id      = var.ami_ecs_cluster
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ecs_instance_role.name
  key_name = aws_key_pair.bastion.key_name
  security_groups = [aws_security_group.ecs_cluster.id]
  user_data = file("files/ecs_userdata.sh")
  associate_public_ip_address = false
  depends_on = [aws_security_group.ecs_cluster,aws_iam_role.ecs_instance_role]
}
# auto scaling groups
resource "aws_autoscaling_group" "asg_ecs_cluster_jtp" {
  name = "asg_ecs_cluster_jtp"
  min_size = 0
  max_size = 5
  desired_capacity = 0
  health_check_type = "ELB"
  launch_configuration = aws_launch_configuration.auto_scaling_launche_ecs_cluster_jtp.name
  vpc_zone_identifier = aws_subnet.private_subnets.*.id
  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  target_group_arns = [aws_lb_target_group.tg_ecs_cluster.arn]
  tags=[
    {
      key                 = "Name"
      value               = "ECS_EC2"
      propagate_at_launch = true
    },
    {
      key                 = "terraform"
      value               = "yes"
      propagate_at_launch = true
    }
  ]
  depends_on = [aws_lb_target_group.tg_ecs_cluster,aws_subnet.private_subnets,aws_launch_configuration.auto_scaling_launche_ecs_cluster_jtp]
}