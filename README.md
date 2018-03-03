# incron

[![Build Status](https://travis-ci.org/pegasd/puppet-incron.svg?branch=master)](https://travis-ci.org/pegasd/puppet-incron)

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with cron](#setup)
    * [What cron affects](#what-cron-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with cron](#beginning-with-cron)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module is an interface for incron jobs with the main idea to be tidy. That means that any jobs that are not managed should not
exist. Once you switch all incron jobs to this module, simply removing the definition is sufficient without worrying about setting
`ensure => disable` and waiting for changes to propagate.

## Setup

### Beginning with incron

To start out with incron:
```puppet
include incron
```
This will install the required package, enable incron service and start managing `/etc/incron.d` directory.

## Usage

All interactions with incron jobs should be done using `incron::job` resource.

## Reference

### Classes

#### Public classes

* [`incron`](#incron)

#### Private classes

* `incron::install`: Handles the packages.
* `incron::config`: Handles the configuration files.
* `incron::service`: Handles the service.
* `incron::remove`: Handles the removal of all incron-related resources.

### Resources

* [`incron::job`](#incron_job)
* [`incron::whitelist`](#incron_whitelist)

### Parameters

## Limitations

* although the `cron::job` type checks for Integer boundaries, you're on your own if you are using strings for specifying time intervals.
Those will be put into the template as-is.

## Development

I'll be happy to know you're using this for one reason or the other. And if you want to
contribute - even better. Feel free to submit a pull request.
