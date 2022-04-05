
data "google_iam_role" "role" {
  for_each = var.permissions_from_roles

  name = each.key
}

locals {
  permissions_from_roles = setsubtract(flatten([for k, v in data.google_iam_role.role : v.included_permissions]), var.exclude_permissions)
}
