#puppet-bootstrap

##Overview

Bootstrap puppet configuration to support multiple environments

## Setup

* Download bootstrap code
```
git clone https://github.com/vchepkov/puppet-bootstrap.git
cd puppet-bootstrap/site/modules/puppet-bootstrap/tests
```

* Modify bootstrap.pp to point to your puppet repository

```
grep r10k_repo bootstrap.pp 
  r10k_repo => 'git@github.com:vchepkov/puppet-bootstrap.git', 
```

* Push bootstrap code in your repository (optional)

* Deploy puppet configuration
```
bash bootstrap.sh
r10k deploy environment
```
