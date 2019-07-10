# locals
  
locals {
  name = "${var.stage}-${var.name}"

  full_name = "${var.city}-${var.stage}-${var.name}"

  upper_name = upper(local.full_name)

  lower_name = lower(local.full_name)

  az_names = data.aws_availability_zones.azs.names

  az_length = length(local.az_names[0])

  preshared_key_provided     = length(var.tunnel1_preshared_key) > 0 && length(var.tunnel2_preshared_key) > 0
  preshared_key_not_provided = false == local.preshared_key_provided

  internal_cidr_provided     = length(var.tunnel1_inside_cidr) > 0 && length(var.tunnel2_inside_cidr) > 0
  internal_cidr_not_provided = false == local.internal_cidr_provided

  tunnel_details_not_specified = local.internal_cidr_not_provided && local.preshared_key_not_provided
  tunnel_details_specified     = local.internal_cidr_provided && local.preshared_key_provided

  create_tunner_with_internal_cidr_only = local.internal_cidr_provided && local.preshared_key_not_provided
  create_tunner_with_preshared_key_only = local.internal_cidr_not_provided && local.preshared_key_provided
}
