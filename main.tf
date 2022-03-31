locals {
  permissions_to_import = toset(flatten([for name, role in data.google_iam_role.import_role : try(role.included_permissions, [])]))

  permissions = setunion(var.permissions, local.permissions_to_import)
}

data "google_iam_role" "import_role" {
  for_each = var.permissions_from_roles

  name = each.key
}

resource "google_organization_iam_custom_role" "role" {
  count = var.module_enabled && var.org_id != null ? 1 : 0

  depends_on = [var.module_depends_on]

  stage       = var.stage
  role_id     = var.role_id
  title       = var.title
  description = var.description
  permissions = local.permissions

  org_id = var.org_id
}

resource "google_project_iam_custom_role" "roles" {
  for_each = var.module_enabled ? var.projects : []

  depends_on = [var.module_depends_on]

  stage       = var.stage
  role_id     = var.role_id
  title       = var.title
  description = var.description
  permissions = local.permissions

  project = each.value
}
