+++
date = "2017-02-02T12:45:36+01:00"
tags = ["docker", "tools", "development"]
title = "Add Docker autocompletion in your shell"
description = "How to install auto completion for your shell and speed up interactions with Docker"
author = ""

+++

> *Disclaimer*: I am assuming that you are using macOS with bash, and Homebrew package manager.

I am a big fan of Docker 🐳, I use it for all my projects at the moment; for experiments with a single container as well as for more complex architectures for production systems.

Working with many Docker images and containers during the set-up phase, often requires typing many Docker commands. To speed this process up, you can use code completion!

## Bash-completion

To use completion scripts, you need `bash-completion` installed on your system. To install it, I suggest using `Homebrew` (get [Homebrew](http://brew.sh/)).

```bash
brew install bash-completion
```

Bash-completion is a programmable tool that comes with autocompletion configured for many popular tools (`ls -la /usr/local/etc/bash_completion.d` to see the list). After the installation it is crucial to do what Homebrew told you to do, add

`
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
`

to your `${HOME}/.bash_profile` file (this will initiate the bash-completion script when you log-in).

## Autocompletion scripts for Docker

Now, add the completion script for `docker`

```bash
curl -XGET https://raw.githubusercontent.com/docker/docker/master/contrib/completion/bash/docker > `brew --prefix`/etc/bash_completion.d/docker
```

It will put the scripts in bash-completion scripts directory.

## Autocompletion script for docker-compose

Do the same for `docker-compose`

```bash
 sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docke-compose -o `brew --prefix`/etc/bash_completion.d/docker-compose
```

*Remember*: you need logout and login to the shell again, before the scripts start working.

## Autocompletion script for docker-machine

Do the same for `docker-machine`

```bash
files=(docker-machine docker-machine-wrapper docker-machine-prompt)
for f in "${files[@]}"; do
  curl -L https://raw.githubusercontent.com/docker/machine/v$(docker-machine --version | tr -ds ',' ' ' | awk 'NR==1{print $(3)}')/contrib/completion/bash/$f.bash > `brew --prefix`/etc/bash_completion.d/$f
done
```

## Autocompletion

Autocompletion works for `docker`, `docker-compose`, `docker-machine` commands as well as existing image names, network and container names, which in the end saves you lots of time!
