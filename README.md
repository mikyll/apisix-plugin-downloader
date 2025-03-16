<div align="center">

[![APISIX][apisix-shield]][apisix-url]
[![NGINX][nginx-shield]][nginx-url]
[![Lua][lua-shield]][lua-url]
[![Perl][perl-shield]][perl-url]
[![YAML][yaml-shield]][yaml-url]

# APISIX Custom Plugin Downloader

This plugin allows to download other plugins from remote repositories, via HTTP/HTTPS.

See [this comment](https://github.com/ledgetech/lua-resty-http/issues/42#issuecomment-359959429) to see how to set SSL certificates.

</div>

## Table of Contents

- [APISIX Custom Plugin Downloader](#apisix-custom-plugin-downloader)
  - [Table of Contents](#table-of-contents)
  - [Plugin Usage](#plugin-usage)
    - [Installation](#installation)
    - [Configuration](#configuration)
      - [Attributes](#attributes)
    - [Enable Plugin](#enable-plugin)
      - [Traditional](#traditional)
      - [Standalone](#standalone)
    - [Example Usage](#example-usage)
  - [Testing](#testing)
    - [CI](#ci)
  - [Examples](#examples)
    - [Standalone Example](#standalone-example)
  - [Learn More](#learn-more)

## Plugin Usage

### Installation

To install custom plugins in APISIX there are 2 methods:

- placing them alongside other built-in plugins, in `${APISIX_INSTALL_DIRECTORY}/apisix/plugins/` (by default `/usr/local/apisix/apisix/plugins/`);
- placing them in a custom directory and setting `apisix.extra_lua_path` to point that directory, in `config.yaml`.

The [example below](#examples) shows how to setup the plugin in a Standalone deployment, using the second method (`extra_lua_path`).

### Configuration

You can configure this plugin for [Routes](https://apisix.apache.org/docs/apisix/terminology/route/) or [Global Rules](https://apisix.apache.org/docs/apisix/terminology/global-rule/).

#### Attributes

| Name | Type | Required | Default | Valid values | Description |
| ---- | ---- | -------- | ------- | ------------ | ----------- |

TODO

### Enable Plugin

TODO

#### Traditional

TODO

#### Standalone

TODO

### Example Usage

TODO

[Back to TOC](#table-of-contents)

## Testing

### CI

TODO

The [`ci.yml`](.github/workflows/ci.yml) workflow runs the tests cases in the [`t/`](t/) folder and can be triggered by a **workflow_dispatch** event, from GitHub: [Actions | CI](https://github.com/mikyll/apisix-plugin-template/actions/workflows/ci.yml).

[Back to TOC](#table-of-contents)

## Examples

Folder [`examples/`](examples/) contains a simple example that shows how to setup APISIX locally on Docker, and load the plugin(s).

For more examples, have a look at [github.com/mikyll/apisix-examples](https://github.com/mikyll/apisix-examples).

### Standalone Example

TODO

[Back to TOC](#table-of-contents)

## Learn More

- [APISIX Source Code](https://github.com/apache/apisix)
- [APISIX Deployment Modes](https://apisix.apache.org/docs/apisix/deployment-modes/)
- [Developing custom APISIX plugins](https://apisix.apache.org/docs/apisix/plugin-develop)
- [APISIX testing framework](https://apisix.apache.org/docs/apisix/internal/testing-framework)
- [APISIX debug mode](https://apisix.apache.org/docs/apisix/debug-mode/)
- [NGiNX variables](https://nginx.org/en/docs/http/ngx_http_core_module.html#variables)
- [APISIX Examples](https://github.com/mikyll/apisix-examples)

<!-- GitHub Shields -->

[apisix-shield]: https://custom-icon-badges.demolab.com/badge/APISIX-grey.svg?logo=apisix_logo
[apisix-url]: https://apisix.apache.org/
[nginx-shield]: https://img.shields.io/badge/Nginx-%23009639.svg?logo=nginx
[nginx-url]: https://nginx.org/en/
[lua-shield]: https://img.shields.io/badge/Lua-%232C2D72.svg?logo=lua&logoColor=white
[lua-url]: https://www.lua.org/
[perl-shield]: https://img.shields.io/badge/Perl-%2339457E.svg?logo=perl&logoColor=white
[perl-url]: https://www.perl.org/
[yaml-shield]: https://img.shields.io/badge/YAML-%23ffffff.svg?logo=yaml&logoColor=151515
[yaml-url]: https://yaml.org/
[build-status-shield]: https://github.com/mikyll/apisix-plugin-downloader/actions/workflows/ci.yml/badge.svg
[build-status-url]: https://github.com/mikyll/apisix-plugin-downloader/actions
