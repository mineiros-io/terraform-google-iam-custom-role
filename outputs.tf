# ----------------------------------------------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ----------------------------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ----------------------------------------------------------------------------------------------------------------------
output "google_project_iam_custom_role" {
  description = "A map of outputs of the created google_project_iam_custom_role resources."
  value       = google_project_iam_custom_role.roles
}

output "google_organization_iam_custom_role" {
  value       = try(google_organization_iam_custom_role.role[0], {})
  description = "A map of outputs of the created google_organization_iam_custom_role resource."
}

# ----------------------------------------------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ----------------------------------------------------------------------------------------------------------------------

output "module_enabled" {
  description = "Whether or not the module is enabled."
  value       = var.module_enabled
}

# output "module_tags" {
#   description = "A map of tags that will be applied to all created resources that accept tags."
#   value       = var.module_tags
# }
