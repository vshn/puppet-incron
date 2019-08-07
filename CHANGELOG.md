# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- #6 Update `stdlib` version requirements in `metadata.json`.
- Update `REFERENCE.md` with data type since Puppet strings started supporting these.
- PDK update.

## [0.5.0] - 2019-04-09
### Added
- GH-4: Ability to specify user name for `incron::job` resource.
- New dependency: `puppetlabs/concat`.
- Puppet 6 support (no production code changes).

### Changed
- GH-4: `incron::job` now manages jobs through `/var/spool/incron/${user}` instead of `/etc/incron.d/${title}`.
- Validation, Unit, and Acceptance stages now all include Puppet 6.
- Run acceptance tests using new puppet and module install helpers.

### Removed
- GH-4: `$mode` parameter for `incron::job` has now been dropped since it is no longer applicable.

## [0.4.0] - 2018-08-17
### Added
- The module is now PDK-compliant.

### Changed
- Moved reference to a standalone strings-generated `REFERENCE.md`.
- `rspec-puppet-facts` started supporting Ubuntu 18.04, so we can use it now. Sweet!

### Fixed
- `puppetlabs_spec_helper`'s `mock_with` deprecation warning.
- Acceptance tests with latest beaker.

## [0.3.0] - 2018-03-14
### Added
- `$incron::purge_noop` parameter to run purging in `noop` mode.
- Manage allowed or denied users using `$incron::allowed_users` and `$incron::denied_users`.
- Manage package version through `$incron::package_version` parameter.
- The following parameters are now available to configure the incron service management:
  - `$incron::service_manage`
  - `$incron::service_ensure`
  - `$incron::service_enable`
- Acceptance tests for:
  - `incron::whitelist`
  - `$incron::allowed_users`

### Changed
- Split up purging into a separate `incron::purge` manifest.
- 'ensure => file' where applicable.

### Fixed
- `/etc/incron.*` configs now have `mode => '0644'`.

### Removed
- `$incron::dir_mode` parameter.

## [0.2.0] - 2018-03-04
### Added
- Support for lots more inotify events.
- Ability to specify an array of events for `incron::job`.
- Acceptance tests.
- This CHANGELOG.

### Changed
- Purge package @ `incron::remove`.
- Manage service on systemd-based systems (Ubuntu 16.04, 18.04) @ `incron::remove`.

## [0.1.0] - 2017-12-15
### Added
- Initial release.
