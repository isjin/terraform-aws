# region
region = "cn-northwest-1"

#availibity zone
az_1 = "cn-northwest-1a"
az_2 = "cn-northwest-1b"
az_3 = "cn-northwest-1c"

#vpc
vpcs = ["10.0.0.0/16",]
vpcs_tags=["vpc_jtp_1",]
//vpc_test = {
//  "cidr_block" = "10.2.0.0/16"
//  "Name" = "vpc_jtp_test"
//}

#subnet
public_subnets = ["10.0.0.0/24", "10.0.1.0/24","10.0.2.0/24"]
private_subnets = ["10.0.3.0/24","10.0.4.0/24","10.0.5.0/24"]
rds_private_subnets = ["10.0.6.0/24","10.0.7.0/24","10.0.8.0/24"]
public_subnets_tags = ["subnet_public_1a_vpc_jtp_1", "subnet_public_1b_vpc_jtp_1","subnet_public_1c_vpc_jtp_1"]
private_subnets_tags = ["subnet_private_1a_vpc_jtp_1","subnet_private_1b_vpc_jtp_1","subnet_private_1c_vpc_jtp_1"]
rds_private_subnets_tags = ["subnet_rds_private_1a_vpc_jtp_1","subnet_rds_private_1b_vpc_jtp_1","subnet_rds_private_1c_vpc_jtp_1"]


#internet gateway
internet_gateways_tags = ["igw_vpc_jtp_1",]

#nat gateway
nat_gateways_tags = ["ngw_vpc_jtp_1"]

#eip
eip_nat_gateways_tags = ["eip_ngw_1a_vpc_jtp_1"]

#route table
public_route_tables_tags = ["rtb_public_vpc_jtp_1"]
private_route_tables_tags = ["rtb_private_vpc_jtp_1"]
rds_private_route_tables_tags = ["rtb_rds_private_vpc_jtp_1"]

#jtp_users
jtp_users=["jtp_user1","jtp_user2"]

#jtp_groups
jtp_groups=["jtp_group1","jtp_group2"]

#jtp user policy arn
jtp_user_policy_arn="arn:aws-cn:iam::aws:policy/AmazonEC2FullAccess"

#jtp group policy arn
jtp_group_policy_arn="arn:aws-cn:iam::aws:policy/AmazonEC2FullAccess"

#jtp role policy arn
jtp_role_policy_arn = ["arn:aws-cn:iam::aws:policy/AmazonEC2FullAccess","arn:aws-cn:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"]

#ecs instance role policy arn
ecs_instance_role_policy_arn =["arn:aws-cn:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role","arn:aws-cn:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"]

#sns subscription notification email
notification_email=["isjin1@163.com"]