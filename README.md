# 301-cookbook

Installs/configures the [301 HTTP redirect server](https://www.npmjs.com/package/301)

## Supported Platforms
- ubuntu-14.04

## Attributes

- ['301']['user'] - user service will run as
- ['301']['version'] - version of 301 to run
- ['301']['port'] - 301's listening  port (default 8080)
- ['301']['domain'] - domain to redirect to
- ['301']['proto'] - http or https (default http)

default['301']['service_name']  = 'three_oh_one'


## Usage

### 301::default

Include `301` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[301::default]"
  ]
}
```

### 301::upstart

Create an upstart service to manage your 301 server

```json
{
  "run_list": [
    "recipe[301::default]"
    "recipe[301::upstart]"
  ]
}
```

## Contributing

Happy to accept PRs for other init script types.
