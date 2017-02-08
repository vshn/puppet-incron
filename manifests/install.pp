# @api private
# This class handles incron packages. Avoid modifying private classes.
class incron::install {

  include ::incron

  package { 'incron':
    ensure => $::incron::ensure,
  }

}