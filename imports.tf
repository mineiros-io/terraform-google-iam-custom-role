
data "google_iam_role" "role" {
  for_each = var.permissions_from_roles

  name = each.key
}

locals {
  permissions_from_roles = toset(flatten([for k, v in data.google_iam_role.role : v.included_permissions]))
}
