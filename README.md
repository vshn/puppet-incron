# Configure and manage incron jobs with focus on tidiness

[![Build Status](https://travis-ci.org/pegasd/puppet-incron.svg?branch=master)](https://travis-ci.org/pegasd/puppet-incron)
[![Puppet Forge](https://img.shields.io/puppetforge/v/pegas/incron.svg)](https://forge.puppetlabs.com/pegas/incron)
[![Puppet Forge - Downloads](https://img.shields.io/puppetforge/dt/pegas/incron.svg)](https://forge.puppetlabs.com/pegas/incron)
[![Puppet Forge - Score](https://img.shields.io/puppetforge/f/pegas/incron.svg)](https://forge.puppetlabs.com/pegas/incron)


## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with incron](#setup)
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

### Type Aliases

* `Incron::Event` - supported inotify events.

### Full reference

Check out [REFERENCE](REFERENCE.md) for up-to-date details.

## Limitations

* Made for and tested only on the following Ubuntu distributions:
    * 14.04
    * 16.04
    * 18.04

## Development

I'll be happy to know you're using this for one reason or the other. And if you want to
contribute - even better. Feel free to [submit an issue](https://github.com/pegasd/puppet-incron/issues) / [fire up a PR](https://github.com/pegasd/puppet-incron/pulls) / whatever.
