
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
