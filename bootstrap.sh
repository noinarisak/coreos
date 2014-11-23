#!/usr/bin/env bash

function install() {
	echo 'installing...'
	#cd $(pwd)
	mkdir -p tools/bin
	docker run --rm jpetazzo/nsenter cat /nsenter > tools/bin/nsenter
	curl -L https://raw.githubusercontent.com/jpetazzo/nsenter/master/docker-enter > tools/bin/docker-enter
	curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > tools/bin/fig
	chmod +x tools/bin/*
}

function configure() {
	echo 'configuring...'
	mv ~/.bashrc ~/.bashrc-original
	mv ~/.bash_profile ~/.bash_profile-original
	sudo curl -L https://raw.githubusercontent.com/noinarisak/coreos/master/bashrc > ~/.bashrc
	sudo ln -s ~/.bashrc ~/.bash_profile
	#source ~/.bashrc
}

function help() {
	echo 'you are here: `$(pwd)`'
}

# Run
install && configure
#help

# Source
#sudo source ~/.bash_profile