# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- 'ensure => file' where applicable.

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
