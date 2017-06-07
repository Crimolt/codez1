#!/bin/bash

set -e

DEPLOY_REPO="https://${DEPLOY_BLOG_TOKEN}@github.com/Crimolt/codez1.git"

function main {
	clean
	get_current_site
	build_site
	deploy
}

function clean {
	echo "cleaning _site folder"
	if [ -d "_site" ]; then rm -Rf _site; fi
}

function get_current_site {
	echo "getting latest site"
	git clone --depth 1 $DEPLOY_REPO _site
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

	cd _site
	git init
	git config --global user.name "Crimolt"
    git config --global user.email leviplj@gmail.com
	git remote add cdz $DEPLOY_REPO
	git add .
	git status
	git commit -m "Lastest site built on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to github"
	git push $DEPLOY_REPO master:gh-pages
}

main