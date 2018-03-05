# This class handles incron configuration files.
#
# @api private
class incron::config {

  if !empty($::incron::allowed_users) and !empty($::incron::denied_users) {
    fail('Either allowed or denied incron users must be specified, not both.')
  }

  if !empty($::incron::denied_users) {
    $ensure_allow = absent
    $ensure_deny = file
  } else {
    $ensure_allow = file
    $ensure_deny = absent
  }

  file { '/etc/incron.deny':
    ensure  => $ensure_deny,
    force   => true,
    content => join(suffix($::incron::denied_users, "\n")),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }

  file { '/etc/incron.allow':
    ensure  => $ensure_allow,
    force   => true,
    content => join(suffix($::incron::allowed_users, "\n")),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }

  file { '/etc/incron.conf':
    ensure  => file,
    force   => true,
    content => '',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }

}
