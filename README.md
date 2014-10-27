DepartureTimeApp
================

About Me
________
I'm an engineer and enjoying learning and programming.  I have a proven history of solving highly scalable and high performance system and love to solve challenging problems.

Introduction
____________
This is the iOS application designed to solve Departure Time.  This application will give real time traffic information to travelers in San Francisco.  Due to limited time, the location is for now defaulted to San Francisco, and traffic information is only given to BART in SF.

Technical choices
_________________
* Swift is chosen for the programming language.  (Experience < 1 Month)
* Objective C is also needed to understand tutorials and sample codes written in Objective C.
* MapKit, CoreLocation has been used.
* Unit Test for the iOS app is omitted due to time constraints.
* Limited UI support

Key Classes
__________
* ViewController.swift - is responsible for Location / MapKit integration, and displaying departure time as map annotations.
* DepartureTimeApplication.swift - is the core class to make service call to get real time departure information.  The service call is made asynchronously.
