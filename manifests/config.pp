# @api private
# This class handles incron configuration files. Avoid modifying private classes.
class incron::config {

  file { [ '/etc/incron.allow', '/etc/incron.deny' ]:
    ensure  => present,
    content => '',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }

  file { '/etc/incron.conf':
    ensure  => present,
    content => '',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/incron.d':
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    owner   => 'root',
    group   => 'root',
    mode    => $::incron::dir_mode,
  }

}