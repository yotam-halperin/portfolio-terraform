
output "subnets" {
  value = aws_subnet.my_subnets.*.id
}

output "vpc_id" {
  value = aws_vpc.yh-tf.id
}

output "region" {
  value = var.region
}

output "vpc_name" {
  value = var.vpc_name
}