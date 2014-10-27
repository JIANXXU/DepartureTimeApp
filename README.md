DepartureTimeApp
================

About Me
--------
I'm an engineer and enjoying learning and programming and solving most challenging and difficult problems. [Resume](https://s3-us-west-1.amazonaws.com/jianxxu/JIAN+XU+Resume+2014.pdf)

Introduction
------------
This is the iOS application designed to solve Departure Time.  This application will give real time traffic information to travelers in San Francisco.  Due to limited time, the location is for now defaulted to San Francisco, and traffic information is only given to 2 BART stations in SF.

Technical choices
-----------------
* Swift is chosen for the programming language.  (Experience < 1 Month)
* Objective C is also needed to understand tutorials and sample codes written in Objective C.
* MapKit, CoreLocation has been used. (Exp < 1 Week)
* Unit Test for the iOS app is omitted due to time constraints.
* Limited UI support.

Key Classes
-----------
* ViewController.swift - is responsible for Location / MapKit integration, and displaying departure time as map annotations.
* DepartureTimeApplication.swift - is the core class to make service call to get real time departure information.  The service call is made asynchronously.

User Story
----------
* On start, the map will be centered on user's current location.
* Click Default Location button will take user to San Francisco.  Default Location is added for testing purpose.

![Default Location Clicked](https://s3-us-west-1.amazonaws.com/jianxxu/IMG_4207.PNG)
* Click Refresh button will refresh to get latest transportation departure information.
* Tap on the pin will show details.

![Pin tapped](https://s3-us-west-1.amazonaws.com/jianxxu/IMG_4208.PNG)
![Another pin tapped](https://s3-us-west-1.amazonaws.com/jianxxu/IMG_4209.PNG)
