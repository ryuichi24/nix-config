#! /bin/bash

find /Users/ryu/Library/Application\ Support/Code/User | while read -r path
    do
        echo $path
    done