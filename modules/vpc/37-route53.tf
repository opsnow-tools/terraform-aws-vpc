// route53 for bastion

data "aws_route53_zone" "default" {
  count = "${var.base_domain != "" ? 1 : 0}"
  name  = "${var.base_domain}"
}

resource "aws_route53_record" "bastion" {
  count   = "${var.base_domain != "" ? "${var.instance_type != "" ? 1 : 0}" : 0}"
  zone_id = "${data.aws_route53_zone.default.zone_id}"
  name    = "${var.city}-${var.stage}-${var.name}-BASTION.${data.aws_route53_zone.default.name}"
  type    = "A"
  ttl     = 300

  records = [
    "${aws_eip.bastion.public_ip}",
  ]
}