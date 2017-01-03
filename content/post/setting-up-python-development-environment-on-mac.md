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
2. Install pip
3. Setting up development environment
    - code editor
4. Running your first program

## Installing/updating Python

OS X 10.11 comes with Python preinstalled. On my 10.11.6 it's `Python 2.7.10 (default, Oct 23 2015, 19:19:21)`. As of the time of writing this article, the newest, stable version of Python is 3.5.2 (from 27 June 2016). For the purpose of this article, we will want to use the newest version of Python.

To check the version of Python (or if it's already installed) run `python --version` in your terminal.

Version 3 has introduced many improvements over the previous version, but also brought many incompatibilities (see: https://wiki.python.org/moin/Python2orPython3).

Unless you are working on a project that specifically requires Python version 2 - I would suggest to use the newest version, as all of the new aspects of Python 3 are the future of the language.

### Installing/updating Python locally

There are several option to install Python on OS X.

### Creating your development environment with Docker

Since it happens, that I have to work on multiple projects at the same time (sometimes I have to use two different versions of the same programming language), I need to be able to switch between versions easily. That is one of the reasons I like to keep all my developments environments separate by using Docker.

Docker lets you have multiple operating systems/environments enclosed in separate images.

There are other ways to have that separation (like virtualenv and Pyenv) - but I found Docker to be the easiest and universal.

To install Docker, head to: https://docs.docker.com/docker-for-mac/. After you install and run Docker, you will be able to use `docker` command from the terminal.

If you want to learn more about Docker, head to https://docs.docker.com/engine/tutorials/.

First we will create an image with an operating system and required version of Python preinstalled. To do that, create a `Dockerfile`.

`docker`

To see what other versions are available head to: https://store.docker.com/images/1ae86987-df14-4741-9433-d9602a4da995?tab=description

## Code editor

My code editor of choice of programming in Python is Atom by Github.com



## Using Docker

...

## Where to learn Python programming

A list of recommended resources for starting and advancing your Python programming skills:

- https://www.codecademy.com/learn/python

## Keep an eye on
- https://github.com/vinta/awesome-python - a curated list of awesome Python frameworks, libraries, software and resources http://awesome-python.com/
