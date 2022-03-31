header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-google-iam-custom-role"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-google-iam-custom-role/workflows/Tests/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-google-iam-custom-role/actions"
    text  = "Build Status"
  }

  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-iam-custom-role.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-google-iam-custom-role/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

  badge "tf-gcp-provider" {
    image = "https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform"
    url   = "https://github.com/terraform-providers/terraform-provider-google/releases"
    text  = "Google Provider Version"
  }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://mineiros.io/slack"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-google-iam-custom-role"
  toc     = true
  content = <<-END
    A [Terraform][terraform] module to create [Google Project IAM custom role][google-project-iam-custom-roles] and [Google Organization IAM custom role][google-organization-iam-custom-role] on [Google Cloud Services (GCP)][gcp].

    **_This module supports Terraform version 1 and is compatible with the Terraform Google Provider version 4._**

    This module is part of our Infrastructure as Code (IaC) framework that enables our users and customers to easily deploy and manage reusable secure, and production-grade cloud infrastructure.
  END

  section {
    title   = "Module Features"
    content = <<-END
      This module allows the management of customized Cloud IAM project and organization roles through the following Terraform resources:

      - `google_organization_iam_custom_role`
      - `google_project_iam_custom_role`

      Creating an organizational custom role is mutual exclusive with creating a project custom role.
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
      Most common usage of the module:

      ```hcl
      module "terraform-google-iam-custom-role" {
        source      = "github.com/mineiros-io/terraform-google-iam-custom-role?ref=v0.0.2"

        role_id     = "myCustomRole"
        title       = "My Custom Role"
        description = "A description"
        permissions = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]

        org_id = "1234567"
      }
      ```
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See [variables.tf] and [examples/] for details and use-cases.
    END

    section {
      title = "Main Resource Configuration"

      variable "role_id" {
        description = <<-EOF
          The camelCaseRoleId to use for this role.
          Cannot contain `-` characters.
          If the total number of `permissions` and imported permissions via `permissions_from` is larger than 3000
          the module will split the role into multiple roles and append a `{num}of{max}` suffix to the `role_id`.
          This can happen when roles with a large number of permissions is imported (e.g. `roles/editor`).
        EOF
        type        = string
        required    = true
      }

      variable "title" {
        description = "A human-readable title for the role."
        type        = string
        required    = true
      }

      variable "org_id" {
        description = "The numeric ID of the organization in which you want to create a custom role. Conflicts with `var.project`."
        type        = string
        default     = null
      }

      variable "project" {
        type        = string
        description = <<-EOF
          The project that the service account will be created in.
          Ignored if `org_id` is set.
          Defaults to the provider project configuration.
        EOF
        default     = null
      }

      variable "description" {
        description = "A human-readable description for the role."
        type        = string
      }

      variable "permissions" {
        description = <<-EOD
          The names of the permissions this role grants when bound in an IAM policy.
          will be merged with permission returned by `permissions_from_roles`.
          in total at least one permission must be specified.
        EOD
        type     = set(string)
        required = true
      }

      variable "stage" {
        description = <<-EOF
          The current launch stage of the role.

          The possible values are:

          - `ALPHA`: The user has indicated this role is currently in an Alpha phase. If this launch stage is selected, the stage field will not be included when requesting the definition for a given role.
          - `BETA`: The user has indicated this role is currently in a Beta phase.
          - `GA`: The user has indicated this role is generally available.
          - `DEPRECATED`: The user has indicated this role is being deprecated.
          - `DISABLED`: This role is disabled and will not contribute permissions to any principals it is granted to in policies.
          - `EAP`: The user has indicated this role is currently in an EAP phase.
        EOF
        type        = string
        default     = "GA"
      }
    }

    section {
      title = "Extended Resource Configuration"

      variable "permissions_from_roles" {
        description = "A set of role names of existing roles to have the permissions cloned from."
        type        = set(string)
        default     = []
      }
    }

    section {
      title = "Module Configuration"

      variable "module_enabled" {
        type        = bool
        default     = true
        description = <<-END
          Specifies whether resources in the module will be created.
        END
      }

      variable "module_depends_on" {
        type           = list(dependency)
        description    = <<-END
          A list of dependencies.
          Any object can be _assigned_ to this list to define a hidden external dependency.
        END
        default        = []
        readme_example = <<-END
          module_depends_on = [
            null_resource.name
          ]
        END
      }
    }
  }

  section {
    title   = "Module Outputs"
    content = "The following attributes are exported in the outputs of the module:"

    output "google_project_iam_custom_roles" {
      type        = list(google_project_iam_custom_role)
      description = "A map of outputs of the created google_project_iam_custom_role resources."
    }

    output "google_organization_iam_custom_role" {
      type        = object(google_organization_iam_custom_role)
      description = "A map of outputs of the created google_organization_iam_custom_role resource."
    }

    output "module_enabled" {
      type        = bool
      description = "Whether this module is enabled."
    }
  }

  section {
    title = "External Documentation"

    section {
      title   = "Google Cloud Documentation:"
      content = <<-END
        - IAM Custom Roles: https://cloud.google.com/iam/docs/understanding-custom-roles
        - IAM API: https://cloud.google.com/iam/docs/reference/rest/v1/projects.roles
      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      [Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
      that solves development, automation and security challenges in cloud infrastructure.

      Our vision is to massively reduce time and overhead for teams to manage and
      deploy production-grade and secure cloud infrastructure.

      We offer commercial support for all of our modules and encourage you to reach out
      if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
      [Community Slack channel][slack].
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]

      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-google-iam-custom-role"
  }
  ref "hello@mineiros.io" {
    value = " mailto:hello@mineiros.io"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://mineiros.io/slack"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-google-iam-custom-role/blob/main/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-google-iam-custom-role/blob/main/examples"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-google-iam-custom-role/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-google-iam-custom-role/blob/main/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-google-iam-custom-role/blob/main/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-google-iam-custom-role/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-google-iam-custom-role/blob/main/CONTRIBUTING.md"
  }
  ref "google-project-iam-custom-roles" {
    value = "https://cloud.google.com/iam/docs/understanding-custom-roles"
  }
  ref "google-organization-iam-custom-role" {
    value = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_organization_iam_custom_role"
  }
  ref "gcp" {
    value = "https://cloud.google.com/"
  }
}
