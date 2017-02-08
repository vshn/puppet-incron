# @api private
# This class handles incron packages.
# Avoid modifying and using private classes directly.
class incron::install {

  package { 'incron':
    ensure => present,
  }

}