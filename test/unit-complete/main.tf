# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# COMPLETE FEATURES UNIT TEST
# This module tests a complete set of most/all non-exclusive features
# The purpose is to activate everything the module offers, but trying to keep execution time and costs minimal.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# DO NOT RENAME MODULE NAME
#project ignored if org_id set
module "test" {
  source = "../.."

  module_enabled = true

  role_id                = "myCustomRole"
  title                  = "My Custom Role"
  description            = "A description"
  permissions            = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]
  permissions_from_roles = ["roles/editor"]
  permissions_chunk_size = 4000
  exclude_permissions    = ["iam.roles.get"]

  stage = "GA"

  org_id = "1234567"
}

#project instead of org_id
module "test2" {
  source = "../.."

  module_enabled = true

  role_id     = "myCustomRole"
  title       = "My Custom Role"
  description = "A description"
  permissions = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]

  project = "unit-complete-${local.random_suffix}"
}

#check if org_id overrides project
module "test3" {
  source = "../.."

  module_enabled = true

  role_id     = "myCustomRole"
  title       = "My Custom Role"
  description = "A description"
  permissions = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]

  project = "unit-complete-${local.random_suffix}"
  org_id  = "1234567"
}
