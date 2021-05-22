# dotfiles

## Primary User
curl -#L "https://github.com/ecleya/dotfiles/tarball/master" | tar -xzv -C /tmp/ --strip-components 1 && cd /tmp && source /tmp/bootstrap.sh

## Secondary User
curl -#L "https://github.com/ecleya/dotfiles/tarball/master" | tar -xzv -C /tmp/ --strip-components 1 && cd /tmp && source /tmp/bootstrap.sh secondary
