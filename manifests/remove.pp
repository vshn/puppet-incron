# This class handles removal of all incron-related resources.
#
# @api private
class incron::remove {

  if $facts['service_provider'] == 'systemd' {
    service { 'incron':
      ensure   => stopped,
      provider => systemd,
    }
  }

  package { 'incron':
    ensure => purged,
  }

  file {
    [
      '/etc/incron.d',
      '/etc/incron.conf',
      '/etc/incron.allow',
      '/etc/incron.deny',
      '/var/spool/incron',
    ]:
      ensure => absent,
      force  => true,
  }

}
