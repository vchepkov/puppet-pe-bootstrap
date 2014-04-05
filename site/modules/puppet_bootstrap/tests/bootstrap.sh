#!/bin/bash

# This script bootstraps puppet environment

set -e

environment=$(puppet config print environment)
modulepath=$(puppet config print modulepath)

# Would like to know if below is possible from a manifest file, 
# r10k will manage modules thereafter, but we have to start somehow
puppet module install --target-dir /opt/puppet/share/puppet/modules zack-r10k

puppet apply --modulepath=../..:${modulepath} bootstrap.pp $*
