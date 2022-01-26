resource "google_organization_iam_custom_role" "role" {
  count = var.module_enabled && var.org_id != null ? 1 : 0

  depends_on = [var.module_depends_on]

  stage       = var.stage
  role_id     = var.role_id
  title       = var.title
  description = var.description
  permissions = var.permissions

  org_id = var.org_id
}

resource "google_project_iam_custom_role" "roles" {
  for_each = var.module_enabled ? var.projects : []

  depends_on = [var.module_depends_on]

  stage       = var.stage
  role_id     = var.role_id
  title       = var.title
  description = var.description
  permissions = var.permissions

  project = each.value
}
