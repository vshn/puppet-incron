# Puppet module to manage incron jobs

[![Build Status](https://travis-ci.org/pegasd/puppet-incron.svg?branch=master)](https://travis-ci.org/pegasd/puppet-incron)
[![Puppet Forge](https://img.shields.io/puppetforge/v/pegas/incron.svg)](https://forge.puppetlabs.com/pegas/incron)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/pegas/incron.svg)](https://forge.puppetlabs.com/pegas/incron)


## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with cron](#setup)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module is an interface for incron jobs with the main idea to be tidy. That means that any jobs that are not managed should not
exist on the host.

Once you `include incron`, simply removing an `incron::job` from your manifests is sufficient for it to be cleaned up on your next
agent run. No need to `ensure => absent` anymore. Enjoy!

## Setup

### Beginning with incron

To start out with incron:

```puppet
include incron
```
This will install the required package, enable incron service and start managing `/etc/incron.d` directory.

Warning: all unmanaged files in `/etc/incron.d` will be removed at this point. Be careful!

## Usage

All interactions with incron jobs should be done using `incron::job` resource.

It works with at least 3 parameters:

```puppet
incron::job { 'upload_file':
  path    => '/watched_directory',
  event   => 'IN_CLOSE_WRITE',
  command => '/usr/local/bin/upload_file $#',
}
```

## Reference

### Public Classes
* [`incron`](#incron): Main entry point for incron class which must be included in order to start managing all incron-related resources.
### Private Classes
* `incron::config`: This class handles incron configuration files.
* `incron::install`: This class handles incron package.
* `incron::remove`: This class handles removal of all incron-related resources.
* `incron::service`: This class handles incron service.
### Defined types
* [`incron::job`](#incronjob): Primary incron resource used to create incron jobs.
* [`incron::whitelist`](#incronwhitelist): Use this to whitelist any system incron jobs you don't want to touch.
  This will make sure that `/etc/incron.d/${title}` won't get deleted nor modified.

### Classes

### incron

Main entry point for incron class which must be included
in order to start managing all incron-related resources.

#### Examples
##### Installing incron
```puppet
include incron
```

##### Uninstalling incron and all related resources
```puppet
class { 'incron':
  ensure => absent,
}
```


#### Parameters

The following parameters are available in the `incron` class.

##### `ensure`

Data type: `Enum[present, absent]`

Whether to enable or disable incron on the system.

Default value: present

##### `dir_mode`

Data type: `Pattern[/^07[057]{2}$/]`

Permissions for /etc/incron.d directory.

Default value: '0755'


## Defined types

### incron::job

Primary incron resource used to create incron jobs.

#### Examples
##### Using incron::job resource
```puppet
incron::job { 'process_file':
  path    => '/upload',
  event   => 'IN_CLOSE_WRITE',
  command => '/usr/bin/process_file $#',
}
```


#### Parameters

The following parameters are available in the `incron::job` defined type.

##### `command`

Data type: `String`

Command to execute on triggered event

##### `event`

Data type: `Variant[Incron::Event,
    Array[Incron::Event, 2]]`

inotify event (or an array of events)

##### `path`

Data type: `Stdlib::Unixpath`

Path to watched directory

##### `mode`

Data type: `Pattern[/^0[46][046]{2}$/]`

Incron job file permissions, which is located at `/etc/incron.d/${name}`

Default value: '0644'


### incron::whitelist

Use this to whitelist any system incron jobs you don't want to touch.
This will make sure that `/etc/incron.d/${title}` won't get deleted nor modified.

#### Examples
##### Using incron::whitelist resource
```puppet
incron::whitelist { 'uploader': }
```

## Limitations

This module has only been used and tested on the following Ubuntu versions:

- 14.04
- 16.04
- 18.04 (currently tested in Docker containers)

## Development

I'll be happy to know you're using this for one reason or the other. And if you want to
contribute - even better. Feel free to submit an issue / PR.
