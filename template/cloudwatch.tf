data "aws_instances" "all_ec2" {
  filter {
    name   = "vpc-id"
    values = aws_vpc.vpcs.*.id
  }
  instance_state_names = ["running", "stopped"]
}

#alarm
resource "aws_cloudwatch_metric_alarm" "all_ec2_CPUUtilization" {
  count = length(data.aws_instances.all_ec2.ids)

  alarm_name                = format("ec2_%s_CPUUtilization",data.aws_instances.all_ec2.ids[count.index])
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  dimensions = {
        InstanceId = data.aws_instances.all_ec2.ids[count.index]
  }
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "60"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
  alarm_actions = []
  ok_actions = []
  depends_on = [data.aws_instances.all_ec2]
}
resource "aws_cloudwatch_metric_alarm" "all_ec2_StatusCheckFailed_Instance" {
  count = length(data.aws_instances.all_ec2.ids)
  alarm_name                = format("ec2_%s_StatusCheckFailed_Instance",data.aws_instances.all_ec2.ids[count.index])
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "StatusCheckFailed_Instance"
  namespace                 = "AWS/EC2"
  dimensions = {
        InstanceId = data.aws_instances.all_ec2.ids[count.index]
  }
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "0"
  alarm_description         = "This metric monitors ec2 StatusCheckFailed_Instance"
  insufficient_data_actions = []
  alarm_actions = []
  ok_actions = []
  depends_on = [data.aws_instances.all_ec2]
}

#dashboard
//resource "aws_cloudwatch_dashboard" "jtp_infra" {
//  dashboard_name = "jtp_infra"
//
//  dashboard_body = <<EOF
// {
//   "widgets": [
//       {
//          "type":"metric",
//          "x":0,
//          "y":0,
//          "width":12,
//          "height":6,
//          "properties":{
//             "metrics":[
//                [
//                   "AWS/EC2",
//                   "CPUUtilization",
//                   "InstanceId",
//                   "i-02c16d70a751e3720"
//                ]
//             ],
//             "period":300,
//             "stat":"Average",
//             "region":"cn-northwest-1",
//             "title":"EC2 Instance CPU"
//          }
//       },
//       {
//          "type":"text",
//          "x":0,
//          "y":7,
//          "width":3,
//          "height":3,
//          "properties":{
//             "markdown":"Hello world"
//          }
//       }
//   ]
// }
// EOF
//}

#logs
//resource "aws_cloudwatch_log_group" "jtp_training" {
//  name = "jtp_training"
//}

#events
