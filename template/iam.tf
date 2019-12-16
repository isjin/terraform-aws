# user
resource "aws_iam_user" "jtp_users" {
  count = length(var.jtp_users)
  name = var.jtp_users[count.index]
}

#group
resource "aws_iam_group" "jtp_groups" {
  count = length(var.jtp_groups)
  name = var.jtp_groups[count.index]
}

#role
resource "aws_iam_role" "jtp_role" {
  name = "jtp_role"
  assume_role_policy =file("files/roles/role_ec2.json")
}
resource "aws_iam_role" "ecs_instance_role" {
  name = "ecsInstanceRole"
  assume_role_policy =file("files/roles/role_ec2.json")
}

#create policy
resource "aws_iam_policy" "jtp_policy" {
  name = "jtp_policy"
  policy = file("files/policies/jtp_policy.json")
}

# instance profile
resource "aws_iam_instance_profile" "jtp_profile" {
  name = "jtp_profile"
  role = aws_iam_role.jtp_role.name
}
resource "aws_iam_instance_profile" "ecs_instance_role" {
  name = "ecsInstanceRole"
  role = aws_iam_role.ecs_instance_role.name
}

#add user to group
resource "aws_iam_user_group_membership" "jtp" {
  count = length(var.jtp_users)
  user = aws_iam_user.jtp_users.*.name[count.index]
//  groups = [aws_iam_group.jtp_groups.*.name[count.index]]
  groups = [aws_iam_group.jtp_groups.*.name[0]]
}

#attach policy to user
resource "aws_iam_user_policy_attachment" "jtp_user_attach" {
  user = aws_iam_user.jtp_users.*.name[0]
  policy_arn = var.jtp_user_policy_arn
}

#attach policy to group
resource "aws_iam_group_policy_attachment" "jtp_group_attach" {
  group      = aws_iam_group.jtp_groups.*.name[0]
  policy_arn = var.jtp_group_policy_arn
}

#attach policy to role
resource "aws_iam_role_policy_attachment" "jtp_role_attach" {
  count = length(var.jtp_role_policy_arn)
  role       = aws_iam_role.jtp_role.name
  policy_arn = var.jtp_role_policy_arn[count.index]
  depends_on = [aws_iam_role.jtp_role]
}
resource "aws_iam_role_policy_attachment" "ecs_instance_role_AmazonEC2ContainerServiceforEC2Role" {
  count = length(var.ecs_instance_role_policy_arn)
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = var.ecs_instance_role_policy_arn[count.index]
  depends_on = [aws_iam_role.ecs_instance_role,aws_iam_instance_profile.ecs_instance_role]
}

# attach policy to roles,users,groups
resource "aws_iam_policy_attachment" "jtp_policy_attach" {
  name       = "jtp_policy_attach"
  users      = [aws_iam_user.jtp_users.*.name[0]]
  roles      = [aws_iam_role.jtp_role.name]
  groups     = [aws_iam_group.jtp_groups.*.name[1]]
  policy_arn = aws_iam_policy.jtp_policy.arn
}
