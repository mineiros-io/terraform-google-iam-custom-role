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
