#sns topic
resource "aws_sns_topic" "jtp_alarm" {
  name = "jtp_alarm"
}

#subscription not support email
//resource "aws_sns_topic_subscription" "notification_email" {
//  count = length(var.notification_email)
//  topic_arn = aws_sns_topic.jtp_alarm.arn
//  protocol  = "Email"
//  endpoint  = var.notification_email[count.index]
//  endpoint_auto_confirms = true
//}