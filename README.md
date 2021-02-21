#  Trafficlight Stats

## Overview

Ok, I know it is a confusing name.  This has nothing to do with Traffic Lights in a city.  I choose the name because it is showing stats in a green/yellow/red format.  

The general usage is to show any stats broken down into three groups, think high, medium, low, or good, maintenance, stable.  The original idea came from working on OpenKilda (http://www.open-kilda.org/) and the desire to show some simple stats on the number of Flows, ISL's and Switches that were in various stats.  Rather than be specific to OpenKilda I created a REST payload that can represent anything.

## Installation

Get it from the App Store or build in XCode from this repository.

## Server

In order to use you will need a server that returns JSON in the following format:

'''
"stats": [
        {
            "timestamp": UNIX_TIMESTAMP,
            "type": String,
            "greenCount": Int,
            "yellowCount": Int,
            "redCount": Int,
            "description": String
        }
'''

There is a non-production version of a sample in the "Server" folder.

Good luck and please provide constructive feedback.

