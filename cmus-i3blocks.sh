#!/bin/bash
artist=$(cmus-remote -Q | grep ' artist ' | cut -d ' ' -f3-)
song=$(cmus-remote -Q | grep title | cut -d ' ' -f3-)
echo " $artist $song  $line"
