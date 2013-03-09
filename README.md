# Todado - your's todays todo list

This is an app I've developed for my talk on [BarCamp Stockholm](http://barcampstockholm.com/).

The talk was "Develop one app on five platforms in 15min".

Basically, it's a HTML5 app package for OSX, Windows, iPhone, Android and well the web on [todado.com](http://todado.com).

## Using:

[node-webkit  v0.4.2](https://github.com/rogerwang/node-webkit)

[PhoneGap 2.5.0](http://phonegap.com/)


### Build & Install

Compile coffee and stylus, package for OSX/Win and also copy output to iOS and Android PhoneGap

    ./build.sh
    
Android

    cd mobile/android/
    ant debug install
    
iOS

    cd mobile/ios/
    open Todado.xcodeproj
    > build in Xcode


