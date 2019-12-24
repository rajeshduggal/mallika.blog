#!/bin/sh

# aws s3 cp TheFile.mp3 s3://static.mallika.blog/media/ --acl public-read
#
# A domain is tied to only one specific repo in a github account. (accountname.githhub.io).
# git init
# git remote add origin git@github.com:rajeshduggal/mallika.blog.git
# git commit --allow-empty -m "Start the public branch"
# git push -u origin gh-pages
# git checkout --orphan gh-pages
# curl -L -s -o .gitignore https://www.gitignore.io/api/visualstudiocode%2Cvim%2Chugo
# git add .gitignore
# git commit -m "Start to fill the memory"
# git push origin gh-pages
# Confirm that /public/ is in the .gitignore file.
# rm -rf public
# git worktree add -B gh-pages public origin/gh-pages
# git checkout gh-pages
# ../bin/hugo new site . --force
# git add config.toml archetypes/default.md
# git commit -m "Add fresh empty site"
# git push origin gh-pages
# git submodule add https://github.com/MunifTanjim/minimo themes/minimo
# git submodule init
# git submodule update
# cp themes/minimo/exampleSite/config.toml .
# Modify the config.toml configuration file to fit your site.
# Test the site ../bin/hugo server -D
# cp themes/minimo/archetypes/default.md archetypes/default.md
# ../bin/hugo new post/first-post.md
# chmod u+x publish_to_gh-pages.sh
# git add * 
# git commit -m "Add the first post"
# git push origin gh-pages
# Run the script to publish your site
# ./publish_to_gh-pages.sh
# 
# ------
# secured custom domain name:
# https://help.github.com/articles/setting-up-an-apex-domain/#configuring-a-records-with-your-dns-provider
# Add the "A" and "CNAME" nameserver entries.
# Then create a cloudflare account. "Free Website" plan.
# Github automatically adds and commits to your repository gh-pages branch one file named CNAME.
# This file content is your domain name. Add this file to your local copy of gh-pages
# cd public
# git fetch --all
# git rebase origin/gh-pages
# git push origin gh-pages
# cd ..
# Copy the CNAME file to the static folder to have it deployed on each website generation
# cp public/CNAME static/CNAME
# git add static/CNAME
# git commit -m "Add CNAME file in static folder"
# git push origin gh-pages
# Publish your site ./publish_to_gh-pages.sh
# A good configuration redirects a non secured connection to a secured one. Cloudflare covers us on that.
# Go to your site page on your Cloudlare account and select the Page Rules tab. Create a new page rule
# Create a page rule for domain.com
# http://*domain.com/* Then the settings are "Always use https".

if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting old publication"
rm -rf public
git worktree prune
rm -rf .git/worktrees/public/
mkdir public

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public origin/gh-pages

echo "Removing existing files"
rm -rf public/*

echo "Generating site"
hugo

echo "Updating gh-pages branch"
cd public && git add --all && git commit -m "Publish to gh-pages (publish.sh)" && git push
