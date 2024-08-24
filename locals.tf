locals {
  ebainttrue                  = "${var.enable_binary_authorization == true ? 1 : ""}"
  ebaintfalse                 = "${var.enable_binary_authorization == false ? 0 : ""}"
  binaryauthorizationcount    = coalesce(local.ebainttrue,local.ebaintfalse)
}