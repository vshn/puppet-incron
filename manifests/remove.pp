# @api private
# This class handles removing all incron-related resources.
# Avoid modifying and using private classes directly.
class incron::remove {

  package { 'incron':
    ensure => absent,
  }

  file { [
    '/etc/incron.d',
    '/etc/incron.conf',
    '/etc/incron.allow',
    '/etc/incron.deny',
  ]:
    ensure => absent,
    force  => true,
  }

}
