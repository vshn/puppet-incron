# @api private
# This class handles incron services. Avoid modifying private classes.
class incron::service {

  service { 'incron':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => false,
  }

}