+++
tags = [
]
date = "2016-12-18T13:49:57-06:00"
title = "Setting up Python development environment on mac OS X"
description = ""
author = ""

+++

## Intro

Python is an interpreted, interactive, object-oriented, open-source programming language.

In this article, I'm assuming, there was no prior Python development done on your computer and you know how to use a terminal.

We will go through the following steps:

1. Installing/updating Python to the newest (or required) version
    - locally 💻
    - using Docker 🐳 (my preferred option)
2. Install pip (the Python package manager)
3. Setting up development environment
    - code editor
4. Running your first program

## Installing/updating Python

OS X 10.11 comes with Python preinstalled. On my 10.11.6 it's `Python 2.7.10 (default, Oct 23 2015, 19:19:21)`. As of the time of writing this article, the newest, stable version of Python is 3.5.2 (from 27 June 2016). For the purpose of this article, we will want to use the newest version of Python.

To check the version of Python (or if it's already installed) run `python --version` in your terminal.

Version 3 has introduced many improvements over the previous version, but also brought many incompatibilities (which is often a source of many jokes). For details see here: https://wiki.python.org/moin/Python2orPython3.

Unless you are working on a project that specifically requires Python version 2 - I  suggest to use the newest version, as all of the new aspects of Python 3 are the future of the language.

### Installing/updating Python locally

There are several option to install Python on OS X. My preferred way is to use Homebrew, the most popular package manager for OSX. If you ar not yet using Homebrew (nor any other package managers for OSX), install it followin the one step guide: http://brew.sh/#install

Once installed, use Homebrew to install Python.

- `brew install python` - to install version 2.7
- `brew install python3` - to install the newest 3.x version

To run Python CLI, type `python` or `python3` depending on the version you have installed and need.

### Creating your development environment with Docker

Since it happens, that I have to work on multiple projects at the same time (sometimes I have to use two different versions of the same programming language), I need to be able to switch between versions easily. That is one of the reasons I like to keep all my developments environments in Docker images.

Docker lets you have multiple operating systems/environments enclosed in separate images that are easy to build and manage.

There are other ways to separate your environments (like virtualenv and Pyenv) - but I found Docker to be the easiest and universal (works for any programming language/environment).

NOTE: Docker is a powerfull tool, I will not explain all the details here. If you want to learn more about Docker, head to https://docs.docker.com/engine/tutorials/. Just remember - it's easier than it seems.

To install Docker, head to: https://docs.docker.com/docker-for-mac/. After you install and run Docker, you will be able to use `docker` command from the terminal.

First we will create an image with an operating system and required version of Python preinstalled. To do that, create an empty `Dockerfile` - that will store the configuration (definition) of our image.

First we need to choose the base Docker image we will use for our own (Docker images are composed from layers and use a base image). We colud use our favorite Linux distribution as a base image and install Python on top of that, but I would rather look for an official, popular Python image.

Head to https://store.docker.com/ and search for 'python'. Perfect, there is a Docker Official Image for Python. It has a number of available tags, each tag is an image version with different Python version installed on different operating system (there are images using i.e. Windows, Ubuntu, etc.).

For my development purposes, I will go for a smallest image possible with Python 3. I have good experience with Apline Linux, so my choice is "3.6.0b2-alpine, 3.6-alpine" tag. I click it and copy the Dockerfile content to my Docker file.

We have the Dockerfile ready, now it's time to build the image from that file.

`docker build -t jkulak/python-dev .` - I'm tagging the image that is being built with my nickname and the name. There is a `.` at the end of the command which means - the `Dockerfile` is in the current directory.

If it finished without errors, you should be able to see you image on the list by running

`docker images | grep python`.

Now, we have a Docker image with an operating system and Python installed.

#### Using docker image for Python development

To use the Docker image, we need to create a container (it is like a virtual machine on our system) from the image and connect to it.

It is important to know that Docker image exits (stops) as soon as the process they were runnin exits/stops.

1. To "go inside" the container and use the command line, run

`docker run -ti --rm jkulak/python-dev sh`

I am using the `--rm` option, so that the container is removed as soon as I finish what I was doing. Otherwise it will be created, will do what I wanted and then it will be stopped and will be available to be run again. It will be listed when you run `docker ps -a` - that shows all the containers created and available in your system.

NOTE: Other option would be to tag (name) the container you are creating and then use the same one using commands `exec` and `start` and using the tag name you have created.

1. To run Python CLI from using our image use

`docker run -ti --rm jkulak/python-dev python3`

This command creates a container from our image, runs it, and runs Python inside. Did it take 0.5s, or less? Isn't that truly amazing? 😳

2. To run single .py file from your local machine use

`docker run -i --rm jkulak/python-dev python < hello.py`

3. To run a project with multiple files using Python from the container we need to mount our project directory inside the container when running the container.

Assuming our code is in `/Users/jdoe/code`, run

`docker run -it --rm -v /Users/jdoe/code:/src/ jkulak/python-dev python /src/hello.py`

The `-v` command mounts the local directory in r/w mode. Deleting things from inside th container form a mounted directory will, of coruse, remove it from your local directory.

## Code editor

My code editor of choice of programming in Python is Atom by Github.com



## Using Docker

...

## Where to learn Python programming

A list of recommended resources for starting and advancing your Python programming skills:

- https://www.codecademy.com/learn/python

## Keep an eye on
- https://github.com/vinta/awesome-python - a curated list of awesome Python frameworks, libraries, software and resources http://awesome-python.com/
