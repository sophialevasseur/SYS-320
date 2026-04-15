#! /bin/bash

# THis is the link that we will scrape
link="10.0.17.6/Assignment.html"

# get the website with curl and tell curl not to give errors
fullPage=$(curl -sL "$link")


