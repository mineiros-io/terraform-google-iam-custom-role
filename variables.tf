# ----------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be set when using this module.
# ----------------------------------------------------------------------------------------------------------------------

variable "role_id" {
  description = "(Required) The camel case role id to use for this role. Cannot contain - characters."
  type        = string
}

variable "title" {
  description = "(Required) A human-readable title for the role."
  type        = string
}

variable "permissions" {
  description = "(Required) The names of the permissions this role grants when bound in an IAM policy. At least one permission must be specified."
  type        = set(string)

  validation {
    condition     = length(var.permissions) >= 1
    error_message = "At least one 'permission' must be specified."
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------

variable "org_id" {
  description = "(Optional) The numeric ID of the organization in which you want to create a custom role."
  type        = string
  default     = null
}

variable "stage" {
  description = <<-EOF
    (Optional) The current launch stage of the role. Defaults to GA.

    The possible values are:

    - `ALPHA`: The user has indicated this role is currently in an Alpha phase. If this launch stage is selected, the stage field will not be included when requesting the definition for a given role.
    - `BETA`: The user has indicated this role is currently in a Beta phase.
    - `GA`: The user has indicated this role is generally available.
    - `DEPRECATED`:	The user has indicated this role is being deprecated.
    - `DISABLED`: This role is disabled and will not contribute permissions to any principals it is granted to in policies.
    - `EAP`: The user has indicated this role is currently in an EAP phase.
  EOF
  type        = string
  default     = "GA"
}
variable "description" {
  description = "(Optional) A human-readable description for the role."
  type        = string
  default     = null
}


variable "projects" {
  description = "(Optional) A set of projects that the custom role will be created in."
  type        = set(string)
  default     = []
}

# ----------------------------------------------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# ----------------------------------------------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether or not to create resources within the module."
  default     = true
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends on."
  default     = []
}
