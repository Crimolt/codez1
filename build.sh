#!/bin/bash

set -e

DEPLOY_REPO="https://${DEPLOY_BLOG_TOKEN}@github.com/Crimolt/codez1.git"

function main {
	clean
	deploy
}

function clean {
	echo "cleaning _site folder"
	if [ -d "_site" ]; then rm -Rf _site; fi
}

function get_current_site {
	echo "getting latest site"
	git clone --depth 1 --branch gh-pages --single-branch $DEPLOY_REPO . || (git init && git remote add -t gh-pages origin $DEPLOY_REPO)
}

function build_site {
	echo "building site"
	bundle exec jekyll build
}

function deploy {
	echo "deploying changes"

	if [ -z "$TRAVIS_PULL_REQUEST" ]; then
	    echo "except don't publish site for pull requests"
	    exit 0
	fi

	if [ "$TRAVIS_BRANCH" != "master" ]; then
	    echo "except we should only publish the master branch. stopping here"
	    exit 0
	fi

	echo "Lastest site built on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to github"
	echo $DEPLOY_REPO

	echo "Checking out site"
	mkdir _site
	cd _site
	get_current_site
	rm -rf ./*

	echo "Building site"
	cd ..
	build_site

	echo "Adding changes"
	cd _site
	git config --global user.name "Travis CI"
    git config --global user.email leviplj@gmail.com

	git add -A .
	git status

	echo "Commiting changes"
	git commit -m "Lastest site built on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to github"
	git push $DEPLOY_REPO gh-pages:gh-pages
}

main