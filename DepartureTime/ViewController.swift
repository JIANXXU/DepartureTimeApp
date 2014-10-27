//
//  ViewController.swift
//  DepartureTime
//
//  Created by Xu, Steven (Jian) on 10/26/14.
//  Copyright (c) 2014 Xu, Steven (Jian). All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate, DepartureTimeApplicationProtocol {
    
    @IBOutlet weak var myMapView: MKMapView!
    
    var seenError = false
    var locationFixAchieved = false
    var locationStatus : NSString = "Not Started"
    var locationManager: CLLocationManager!
    var useMyLocation = true
    var annotations : NSMutableArray!
    var userLocation = CLLocationCoordinate2D(latitude: 37.786996, longitude: -122.440100)
    
    lazy var applicationLogic : DepartureTimeApplication = DepartureTimeApplication(delegate: self)

    let THE_SPAN = 0.01

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        if let err = error {
            if (seenError == false) {
                seenError = true
                NSLog("Stop Location Manager for Error: \(err)")
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        
        if (!useMyLocation) {
            return
        }
        useMyLocation = false
        if let loc = newLocation {
            var center = CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
            var span = MKCoordinateSpan(latitudeDelta: THE_SPAN, longitudeDelta: THE_SPAN)
            var region = MKCoordinateRegion(center: center, span: span)
            myMapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        switch status {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access to location"
            case CLAuthorizationStatus.Denied:
                locationStatus = "User denied access to location"
            case CLAuthorizationStatus.NotDetermined:
                locationStatus = "Status not determined"
            default:
                locationStatus = "Allowed to location Access"
                shouldIAllow = true
        }
        NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
                // Start location services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
    }
    
    @IBAction func defaultLocationClicked(sender: AnyObject) {
        gotoDefaultLocation()
    }

    @IBAction func updateTimeClicked(sender: AnyObject) {
        updateTime()
    }
    
    func gotoDefaultLocation()
    {
        // start off by default in San Francisco
        var center = CLLocationCoordinate2D(latitude: 37.786996, longitude: -122.440100)
        var span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        var region = MKCoordinateRegion(center: center, span: span)

        myMapView.setRegion(region, animated: true)
    }
    
    func updateTime()
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        applicationLogic.getDepartureTimesAsync(userLocation)
    }
    
    func didReceiveDepartureTime(results: NSArray) {
        
        // Turn off network indicator
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        if (annotations != nil) {
            myMapView.removeAnnotations(annotations)
        }
        
        annotations = NSMutableArray()
        var stopCodeMap = [String: Annotation]()
        
        for dict in results as [NSDictionary] {
            let stopCode = dict["stopCode"] as String
            var depTime = String(dict["nextDepartureTime"] as Int) + " m for " + (dict["routeName"] as String)
            
            if let ann = stopCodeMap[stopCode] {
                ann.subtitle = ann.subtitle + ", " + depTime
            } else {
                let lat = dict["latitude"] as Double
                let long = dict["longitude"] as Double
                var location = CLLocationCoordinate2D(latitude: lat, longitude: long)
                var title = (dict["agencyName"] as String) + " @ " + (dict["stopName"] as String)
                var myAnn = Annotation(coordinate:location, title: title, subtitle: depTime)
                
                stopCodeMap[stopCode] = myAnn
            }
        }

        for finalAnn in stopCodeMap.values {
            annotations.addObject(finalAnn)
        }
        
        myMapView.addAnnotations(annotations)
    }

}

