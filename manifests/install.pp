# @api private
# This class handles incron package.
# Avoid modifying and using private classes directly.
class incron::install {

  package { 'incron':
    ensure => installed,
  }

}
