locals {
  max_permission_set_size = 3000

  permissions_to_import = toset(flatten([for name, role in data.google_iam_role.import_role : try(role.included_permissions, [])]))
  permissions = setunion(var.permissions, local.permissions_to_import)
  permissions_sets = chunklist(local.permissions, local.max_permission_set_size)

  create_organization_custom_role = var.module_enabled && var.org_id != null
}

data "google_iam_role" "import_role" {
  for_each = var.permissions_from_roles

  name = each.key
}

resource "google_organization_iam_custom_role" "role" {
  count = local.create_organization_custom_role ? length(local.permissions_sets) : 0

  depends_on = [var.module_depends_on]

  stage       = var.stage
  role_id     = var.role_id
  title       = "${var.title}-${count.index}"
  description = var.description
  permissions = local.permissions_sets[count.index]

  org_id = var.org_id
}

locals {
  projects_with_permissions_sets = [for pair in setproduct(var.projects, local.permissions_sets) : {
    project = pair[0].key
    permission_set_key = pair[1].key
    permissions = pair[1].value
  }]
}

resource "google_project_iam_custom_role" "roles" {
  for_each = var.module_enabled ? local.projects_with_permissions_sets : []

  depends_on = [var.module_depends_on]

  stage       = var.stage
  role_id     = var.role_id
  title       = "${var.title}-${each.value.permission_set_key}"
  description = var.description
  permissions = each.value.permissions

  project = each.value.project
}
