# @api private
# This class handles removal of all incron-related resources.
# Avoid modifying and using private classes directly.
class incron::remove {

  if versioncmp($facts['os']['release']['full'], '15.04') >= 0 {
    service { 'incron':
      ensure   => stopped,
      provider => systemd,
    }
  }

  package { 'incron':
    ensure => purged,
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
