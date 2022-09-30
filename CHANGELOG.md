# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Add unit tests

### Changed

- BREAKING CHANGE: output `google_project_iam_custom_role` -> `google_project_iam_custom_roles`
- BREAKING CHANGE: output `google_organization_iam_custom_role` -> `google_organization_iam_custom_roles` and returns list of resources instead of the first object.

## [0.0.2]

### Added

- Add support for importing permissions from roles via `var.permissions_from_roles`.
- Add support for chunking permissions when length of `permissions` and `permissions_from_roles` is over 3000.
  Chunked roles will be suffixed by `{n}of{max}`.

### Changed

- BREAKING CHANGE: creating an organization custom role by providing `org_id` will disable creating a project custom role.

### Removed

- BREAKING CHANGE: Remove support for adding a role for multiple projects at once.

## [0.0.1]

### Added

- Add support for `google_organization_iam_custom_role` Terraform resource
- Add support for `google_project_iam_custom_role` Terraform resource

[unreleased]: https://github.com/mineiros-io/terraform-google-iam-custom-role/compare/v0.0.2...HEAD
[0.0.2]: https://github.com/mineiros-io/terraform-google-iam-custom-role/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/mineiros-io/terraform-google-iam-custom-role/releases/tag/v0.0.1
