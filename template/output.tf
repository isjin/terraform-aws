//output "vpcs_ids" {
//  value = aws_vpc.vpcs.*.id
////  value = aws_vpc.vpcs[0].id
////  value = aws_vpc.vpcs
//}
//output "vpcs_names" {
//  value = aws_vpc.vpcs.*.tags.Name
//}
//output "public_subnets_ids" {
//  value = aws_subnet.public_subnets.*.id
//}
//output "public_subnets_tags" {
//  value = aws_subnet.public_subnets.*.tags.Name
//}
//output "private_subnets_ids" {
//  value = aws_subnet.private_subnets.*.id
//}
//output "private_subnets_tags" {
//  value = aws_subnet.private_subnets.*.tags.Name
//}
//output "internet_gateways_ids" {
//  value = aws_internet_gateway.internet_gateways.*.id
//}
//output "internet_gateways_tags" {
//  value = aws_internet_gateway.internet_gateways.*.tags.Name
//}
//output "eips_nat_gateway_allocation_ids" {
//  value = aws_eip.nat_gateways_eip.*.id
//}
//output "eips_nat_gateway_association_ids" {
//  value = aws_eip.nat_gateways_eip.*.association_id
//}
//output "eips_nat_gateway_tags" {
//  value = aws_eip.nat_gateways_eip.*.tags
//}
//output "rtb_public_ids" {
//  value = aws_route_table.public_route_tables.*.id
//}
//output "rtb_public_tags" {
//  value = aws_route_table.public_route_tables.*.tags.Name
//}
//output "rtb_private_ids" {
//  value = aws_route_table.private_route_tables.*.id
//}
//output "rtb_private_tags" {
//  value = aws_route_table.private_route_tables.*.tags.Name
//}
//output "security_group_bastion" {
//  value = aws_security_group.bastion.id
//}
//output "security_group_ecs_cluster" {
//  value = aws_security_group.ecs_cluster.id
//}
//output "security_group_alb" {
//  value = aws_security_group.alb.id
//}
//output "auto_scaling_configuration_ecs_cluster" {
//  value = aws_launch_configuration.auto_scaling_launche_ecs_cluster_jtp.id
//}