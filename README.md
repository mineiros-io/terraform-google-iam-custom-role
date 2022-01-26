[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-google-iam-custom-role)

[![Build Status](https://github.com/mineiros-io/terraform-google-iam-custom-role/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-google-iam-custom-role/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-google-iam-custom-role.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-google-iam-custom-role/releases)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Google Provider Version](https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-google/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-google-iam-custom-role

A [Terraform][terraform] module to create [Google Project IAM custom role][google-project-iam-custom-roles] and [Google Organization IAM custom role][google-organization-iam-custom-role] on [Google Cloud Services (GCP)][gcp].

**_This module supports Terraform version 1 and is compatible with the Terraform Google Provider version 4._**

This module is part of our Infrastructure as Code (IaC) framework that enables our users and customers to easily deploy and manage reusable secure, and production-grade cloud infrastructure.


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Main Resource Configuration](#main-resource-configuration)
  - [Module Configuration](#module-configuration)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [Google Cloud Documentation:](#google-cloud-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module allows the management of customized Cloud IAM project and organization roles through the following Terraform resources:

- `google_organization_iam_custom_role`
- `google_project_iam_custom_role`

## Getting Started

Most common usage of the module:

```hcl
module "terraform-google-iam-custom-role" {
  source      = "git@github.com:mineiros-io/terraform-google-iam-custom-role.git?ref=v0.0.1"

  role_id     = "myCustomRole"
  title       = "My Custom Role"
  description = "A description"
  permissions = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]

  org_id = "1234567"
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Main Resource Configuration

- [**`role_id`**](#var-role_id): *(**Required** `string`)*<a name="var-role_id"></a>

  The camelCaseRoleId to use for this role. Cannot contain `-` characters.

- [**`title`**](#var-title): *(**Required** `string`)*<a name="var-title"></a>

  A human-readable title for the role.

- [**`permissions`**](#var-permissions): *(**Required** `set(string)`)*<a name="var-permissions"></a>

  The names of the permissions this role grants when bound in an IAM policy. At least one permission must be specified.

- [**`org_id`**](#var-org_id): *(Optional `string`)*<a name="var-org_id"></a>

  The numeric ID of the organization in which you want to create a custom role.

- [**`stage`**](#var-stage): *(Optional `string`)*<a name="var-stage"></a>

  The current launch stage of the role.

  The possible values are:

   - `ALPHA`: The user has indicated this role is currently in an Alpha phase. If this launch stage is selected, the stage field will not be included when requesting the definition for a given role.
   - `BETA`: The user has indicated this role is currently in a Beta phase.
   - `GA`: The user has indicated this role is generally available.
   - `DEPRECATED`: The user has indicated this role is being deprecated.
   - `DISABLED`: This role is disabled and will not contribute permissions to any principals it is granted to in policies.
   - `EAP`: The user has indicated this role is currently in an EAP phase.

  Default is `"GA"`.

- [**`description`**](#var-description): *(Optional `string`)*<a name="var-description"></a>

  A human-readable description for the role.

- [**`projects`**](#var-projects): *(Optional `set(string)`)*<a name="var-projects"></a>

  A set of projects that the custom role will be created in.

### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies.
  Any object can be _assigned_ to this list to define a hidden external dependency.

  Default is `[]`.

  Example:

  ```hcl
  module_depends_on = [
    null_resource.name
  ]
  ```

## Module Outputs

The following attributes are exported in the outputs of the module:

- [**`google_project_iam_custom_roles`**](#output-google_project_iam_custom_roles): *(`list(google_project_iam_custom_role)`)*<a name="output-google_project_iam_custom_roles"></a>

  A map of outputs of the created google_project_iam_custom_role resources.

- [**`google_organization_iam_custom_role`**](#output-google_organization_iam_custom_role): *(`object(google_organization_iam_custom_role)`)*<a name="output-google_organization_iam_custom_role"></a>

  A map of outputs of the created google_organization_iam_custom_role resource.

- [**`module_enabled`**](#output-module_enabled): *(`bool`)*<a name="output-module_enabled"></a>

  Whether this module is enabled.

## External Documentation

### Google Cloud Documentation:

- IAM Custom Roles: https://cloud.google.com/iam/docs/understanding-custom-roles
- IAM API: https://cloud.google.com/iam/docs/reference/rest/v1/projects.roles

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-google-iam-custom-role
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-google-iam-custom-role/blob/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-google-iam-custom-role/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-google-iam-custom-role/issues
[license]: https://github.com/mineiros-io/terraform-google-iam-custom-role/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-iam-custom-role/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-iam-custom-role/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-iam-custom-role/blob/main/CONTRIBUTING.md
[google-project-iam-custom-roles]: https://cloud.google.com/iam/docs/understanding-custom-roles
[google-organization-iam-custom-role]: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_organization_iam_custom_role
[gcp]: https://cloud.google.com/
