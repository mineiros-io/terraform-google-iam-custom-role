locals {
  permissions = setunion(var.permissions, local.permissions_from_roles)

  permissions_chunks = chunklist(local.permissions, var.permissions_chunk_size)

  number_of_chunks = length(local.permissions_chunks)
}

resource "google_organization_iam_custom_role" "roles" {
  count = var.module_enabled && var.org_id != null ? local.number_of_chunks : 0

  org_id = var.org_id

  stage       = var.stage
  role_id     = local.number_of_chunks == 1 ? var.role_id : "${var.role_id}${count.index + 1}of${local.number_of_chunks}"
  title       = var.title
  description = var.description
  permissions = local.permissions_chunks[count.index]

  depends_on = [var.module_depends_on]
}

resource "google_project_iam_custom_role" "roles" {
  count = var.module_enabled && var.org_id == null ? local.number_of_chunks : 0

  project = var.project

  stage       = var.stage
  role_id     = local.number_of_chunks == 1 ? var.role_id : "${var.role_id}${count.index + 1}of${local.number_of_chunks}"
  title       = var.title
  description = var.description
  permissions = local.permissions_chunks[count.index]

  depends_on = [var.module_depends_on]
}

moved {
  from = google_organization_iam_custom_role.role
  to   = google_organization_iam_custom_role.roles
}
