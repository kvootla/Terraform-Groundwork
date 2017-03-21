# this approach is not working just yet
output "arn" {
  value = "${coalesce(var.alb_loging.arn, var.alb_nologing.arn) }"

  /*value = "${var.alb_loging.arn}"*/
}

output "dns_name" {
  value = "${var.alb_loging.dns_name}"

  /*value = "${coalesce(list("var.alb_loging.dns_name", "var.alb_nologing.dns_name")) }"*/
}

output "id" {
  value = "${var.alb_loging.id}"

  /*value = "${coalesce(list("var.alb_loging.dns_name", "var.alb_nologing.dns_name")) }"*/
}

output "zone_id" {
  value = "${var.alb_loging.zone_id}"

  /*value = "${coalesce(list("var.alb_loging.dns_name", "var.alb_nologing.dns_name")) }"*/
}
