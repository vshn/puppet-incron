# @api private
# This class handles incron packages. Avoid modifying private classes.
class incron::install {

  package { 'incron':
    ensure => present,
  }

}