## site.pp ##

# Workaround for annoying feature

if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}

# This includes all of our node definitions
import 'nodes/*.pp'
