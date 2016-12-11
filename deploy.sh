#!/bin/bash

hugo
git add -A
msg="Build content `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push
git subtree push --prefix=public git@github.com:spencerlyon2/hugo_gh_blog.git gh-pages
