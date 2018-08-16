# Reference
<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Classes

### Public Classes

* [`incron`](#incron): Main entry point for incron class which must be included in order to start managing all incron-related resources.

### Private Classes

* `incron::config`: This class handles incron configuration files.
* `incron::install`: This class handles incron package.
* `incron::purge`: Purge `/etc/incron.d` directory.
* `incron::remove`: This class handles removal of all incron-related resources.
* `incron::service`: This class handles incron service.

## Defined types

* [`incron::job`](#incronjob): Primary incron resource used to create incron jobs.
* [`incron::whitelist`](#incronwhitelist): Use this to whitelist any system incron jobs you don't want to touch. This will make sure that `/etc/incron.d/${title}` won't get deleted nor

## Classes

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

##### `package_version`

Data type: `String[1]`

Provide custom `incron` package version here.

Default value: installed

##### `allowed_users`

Data type: `Array[String[1]]`

List of users allowed to use `incrontab(1)`. By default, only root can.

Default value: [ ]

##### `denied_users`

Data type: `Array[String[1]]`

List of users specifically denied to use `incrontab(1)`.
Note: When this is not empty, all users except ones specified here will be able to use `incrontab`.

Default value: [ ]

##### `service_manage`

Data type: `Boolean`

Whether to manage incron service at all.

Default value: `true`

##### `service_ensure`

Data type: `Enum[running, stopped]`

Incron service's 'ensure' parameter.

Default value: running

##### `service_enable`

Data type: `Boolean`

Incron service's 'enable' parameter.

Default value: `true`

##### `purge_noop`

Data type: `Boolean`

Run purging in `noop` mode.

Default value: `false`

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
This will make sure that `/etc/incron.d/${title}` won't get deleted
nor modified.

#### Examples

##### Using incron::whitelist resource

```puppet
incron::whitelist { 'uploader': }
```
