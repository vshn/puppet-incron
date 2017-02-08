# @api private
# This class handles incron configuration files. Avoid modifying private classes.
class incron::config {

  file { [ '/etc/incron.allow', '/etc/incron.deny' ]:
    ensure  => $::incron::ensure,
    content => '',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }

  file { '/etc/incron.conf':
    ensure  => $::incron::ensure,
    content => '',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  if $::incron::ensure == present {
    $dir_ensure = directory
  } else {
    $dir_ensure = $::incron::ensure
  }

  file { '/etc/incron.d':
    ensure  => $dir_ensure,
    recurse => true,
    purge   => true,
    force   => true,
    owner   => 'root',
    group   => 'root',
    mode    => $::incron::dir_mode,
  }

}