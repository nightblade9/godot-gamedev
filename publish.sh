#!/bin/sh
rm -rf docs
pelican content -s publishconf.py
mv output docs
