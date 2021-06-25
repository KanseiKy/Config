#!/usr/bin/env bash

if [[ -f "$HOME/.profile" ]] ; then
    source ~/.profile
    return

elif [[ -f "$HOME/.bashrc" ]] ; then
    source ~/.bashrc
    return

fi
