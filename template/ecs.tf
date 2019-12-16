#ecs cluster
resource "aws_ecs_cluster" "ecs_cluster_jtp" {
  name = "jtp_ecs_cluster"
}

#ecs task definition
resource "aws_ecs_task_definition" "jtp-training" {
  family                = "jtp-training"
  container_definitions = file("files/task_definition_jtp_training.json")
}

#ecs services
resource "aws_ecs_service" "friendlyhello" {
  name            = "friendlyhello"
  cluster         = aws_ecs_cluster.ecs_cluster_jtp.id
  task_definition = aws_ecs_task_definition.jtp-training.arn
  desired_count   = 2
  depends_on = [aws_ecs_cluster.ecs_cluster_jtp,aws_ecs_task_definition.jtp-training,aws_instance.bastion]
}