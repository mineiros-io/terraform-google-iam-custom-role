# ----------------------------------------------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ----------------------------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ----------------------------------------------------------------------------------------------------------------------
output "google_project_iam_custom_roles" {
  description = "The list of google_project_iam_custom_role resources."
  value       = google_project_iam_custom_role.roles
}

output "google_organization_iam_custom_roles" {
  value       = google_organization_iam_custom_role.roles
  description = "The list of google_organization_iam_custom_role resources."
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
