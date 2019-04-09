# Purge `/etc/incron.d` and `/var/spool/incron` directories.
#
# @api private
class incron::purge {

  file { '/etc/incron.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    purge   => true,
    force   => true,
    noop    => if $::incron::purge_noop { true } else { undef },
  }

  file { '/var/spool/incron':
    ensure  => directory,
    owner   => 'root',
    group   => 'incron',
    mode    => '1731',
    recurse => true,
    purge   => true,
    force   => true,
    noop    => if $::incron::purge_noop { true } else { undef },
  }

}
