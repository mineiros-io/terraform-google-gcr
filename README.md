[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-google-gcr)

[![Build Status](https://github.com/mineiros-io/terraform-google-gcr/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-google-gcr/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-google-gcr.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-google-gcr/releases)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Google Provider Version](https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-google/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-google-gcr

A [Terraform] module for deploying and managing a [Google Container Registry](https://cloud.google.com/container-registry) on [Google Cloud Platform (GCP)][gcp].
Container Registry is a single place for your team to manage Docker images,
perform vulnerability analysis, and decide who can access what with fine-grained access control.
Existing CI/CD integrations let you set up fully automated Docker pipelines to get fast feedback.

**_This module supports Terraform version 1
and is compatible with the Terraform Google Provider version 4._**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Module Configuration](#module-configuration)
    - [Main Resource Configuration](#main-resource-configuration)
    - [Extended Resource Configuration](#extended-resource-configuration)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [Google Documentation](#google-documentation)
  - [Terraform Google Provider Documentation](#terraform-google-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module implements the following Terraform resources:

- `google_container_registry`
- `google_storage_bucket_iam_member`

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-google-gcr" {
  source = "github.com/mineiros-io/terraform-google-gcr.git?ref=v0.0.2"

  location = "EU"
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Top-level Arguments

#### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

  Example:

  ```hcl
  module_depends_on = [
    google_network.network
  ]
  ```

#### Main Resource Configuration

- [**`project`**](#var-project): *(**Required** `string`)*<a name="var-project"></a>

  The ID of the project in which the resource belongs. If it is not provided, the provider project is used.

- [**`location`**](#var-location): *(Optional `string`)*<a name="var-location"></a>

  The location for the GCR. For a list of all supported locations, please see https://cloud.google.com/container-registry/docs/pushing-and-pulling#pushing_an_image_to_a_registry.

#### Extended Resource Configuration

- [**`pull_members`**](#var-pull_members): *(Optional `set(string)`)*<a name="var-pull_members"></a>

  A set of identities that will be able to pull images from GCR.

  Example:

  ```hcl
  pull_members = [
    "user:example@mineiros.io",
    "group:example@mineiros.io",
    "serviceAccount:example@mineiros-testing.iam.gserviceaccount.com",
  ]
  ```

- [**`push_members`**](#var-push_members): *(Optional `set(string)`)*<a name="var-push_members"></a>

  A set of identities that will be able to pull&push images from GCR.

  Example:

  ```hcl
  pull_members = [
    "user:example@mineiros.io",
    "group:example@mineiros.io",
    "serviceAccount:example@mineiros-testing.iam.gserviceaccount.com",
  ]
  ```

## Module Outputs

The following attributes are exported in the outputs of the module:

- [**`module_enabled`**](#output-module_enabled): *(`bool`)*<a name="output-module_enabled"></a>

  Whether this module is enabled.

- [**`module_inputs`**](#output-module_inputs): *(`object(module_inputs)`)*<a name="output-module_inputs"></a>

  A map of all module arguments. Omitted optional arguments will be
  represented with their actual defaults.

- [**`project`**](#output-project): *(`string`)*<a name="output-project"></a>

  The ID of the project in which the resources belong.

- [**`gcr`**](#output-gcr): *(`object(gcr)`)*<a name="output-gcr"></a>

  All outputs of the created GCR resource.

- [**`pull_iam_members`**](#output-pull_iam_members): *(`object(pull_iam_members)`)*<a name="output-pull_iam_members"></a>

  A map of outputs, keyed by the member id, of all iam_members allowed to
  pull images to GCR.

- [**`push_iam_members`**](#output-push_iam_members): *(`object(push_iam_members)`)*<a name="output-push_iam_members"></a>

  A map of outputs, keyed by the member id, of all iam_members allowed to
  push images to GCR.

## External Documentation

### Google Documentation

- Container Registry: https://cloud.google.com/container-registry

### Terraform Google Provider Documentation

- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_registry

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

[homepage]: https://mineiros.io/?ref=terraform-google-gcr
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-google-gcr/workflows/Tests/badge.svg
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-google-gcr.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[build-status]: https://github.com/mineiros-io/terraform-google-gcr/actions
[releases-github]: https://github.com/mineiros-io/terraform-google-gcr/releases
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[badge-tf-gcp]: https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform
[releases-google-provider]: https://github.com/terraform-providers/terraform-provider-google/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[gcp]: https://cloud.google.com/
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-google-gcr/blob/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-google-gcr/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-google-gcr/issues
[license]: https://github.com/mineiros-io/terraform-google-gcr/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-gcr/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-gcr/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-gcr/blob/main/CONTRIBUTING.md
