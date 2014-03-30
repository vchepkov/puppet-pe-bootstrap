#!/bin/bash

# This script bootstraps puppet environment

set -e

environment=$(puppet config print environment)
modulepath=$(puppet config print modulepath)

puppet apply --modulepath=../..:${modulepath} bootstrap.pp $*
