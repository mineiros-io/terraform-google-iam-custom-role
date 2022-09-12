# ----------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be set when using this module.
# ----------------------------------------------------------------------------------------------------------------------

variable "role_id" {
  type        = string
  description = "(Required) The camel case role id to use for this role. Can only contain alphanumeric characters."

  validation {
    condition     = can(regex("^[a-z](([a-z0-9]+[A-Z]?)*)$", var.role_id))
    error_message = "The id of the role can only contain alphanumeric characters, must start with a lowercase letter or number and be defined in camel case."
  }
}

variable "title" {
  type        = string
  description = "(Required) A human-readable title for the role."
}

# ----------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------

variable "org_id" {
  description = "(Optional) The numeric ID of the organization in which you want to create a custom role. Conflicts with `var.project`."
  type        = string
  default     = null
}

variable "project" {
  type        = string
  description = "(Optional) The project that the service account will be created in. Ignored if `var.org_id` is set. Defaults to the provider project configuration."
  default     = null
}

variable "stage" {
  type        = string
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
  default     = "GA"
}

variable "description" {
  type        = string
  description = "(Optional) A human-readable description for the role."
  default     = null
}

variable "permissions" {
  type        = set(string)
  description = "(Optional) The names of the permissions this role grants when bound in an IAM policy. At least one permission must be specified."
  default     = []
}

variable "permissions_from_roles" {
  type        = set(string)
  description = "(Optional) The names of the roles to have the permissions cloned from."
  default     = []
}

variable "permissions_chunk_size" {
  type        = number
  description = "(Optional) The maximum count of permissions chunk to split the cloned list with."
  default     = 3000
}

variable "exclude_permissions" {
  type        = set(string)
  description = "(Optional) The names of the permissions to be excluded from the cloned permissions."
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
