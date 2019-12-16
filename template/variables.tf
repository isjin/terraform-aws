variable "region" {}
variable "az_1" {}
variable "az_2" {}
variable "az_3" {}
variable "availible_zone" {
	type = list
	default = ["cn-northwest-1a","cn-northwest-1b","cn-northwest-1c"]
}
variable "vpcs" {
	type = list
	default = []
}
variable "vpcs_tags" {
	type = list
	default = []
}
//variable "vpc_test" {
//	type = map
//}
variable "public_subnets" {
	type = list
	default = []
}
variable "public_subnets_tags" {
	type = list
	default = []
}
variable "private_subnets" {
	type = list
	default = []
}
variable "private_subnets_tags" {
	type = list
	default = []
}
variable "rds_private_subnets" {
	type = list
	default = []
}
variable "rds_private_subnets_tags" {
	type = list
	default = []
}
variable "internet_gateways_tags" {
	type = list
	default = []
}
variable "eip_nat_gateways_tags" {
	type = list
	default = []
}
variable "nat_gateways_tags" {
	type = list
	default = []
}
variable "public_route_tables_tags" {
	type = list
	default = []
}
variable "private_route_tables_tags" {
	type = list
	default = []
}
variable "rds_private_route_tables_tags" {
	type = list
	default = []
}
variable "ami_ecs_cluster" {
	default = "ami-0e75a6ccc99b4c15c"
}
variable "jtp_users" {
	type = list
}
variable "jtp_groups" {
	type = list
}
variable "jtp_user_policy_arn" {}
variable "jtp_group_policy_arn" {}
variable "jtp_role_policy_arn" {
	type = list
}
variable "ecs_instance_role_policy_arn" {
	type = list
}
variable "notification_email" {
	type = list
}