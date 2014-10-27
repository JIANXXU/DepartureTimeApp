//
//  DepartureTimeApplication.swift
//  DepartureTime
//
//  Created by Xu, Steven (Jian) on 10/26/14.
//  Copyright (c) 2014 Xu, Steven (Jian). All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

//
// This is the application class, which contains the main application logics:
// 1. make service call
// 2. notify calling controller when results are received
//
class DepartureTimeApplication {
    
    var delegate: DepartureTimeApplicationProtocol
    
    init(delegate: DepartureTimeApplicationProtocol) {
        self.delegate = delegate
    }

    func getDepartureTimesAsync(location : CLLocationCoordinate2D) {
        // TODO we should enhance the service to get departure times only near to the user
        let urlPath = "http://still-beyond-8245.herokuapp.com/departuretime/" +
            "?u1=\(location.latitude)&u2=\(location.longitude)"
        get(urlPath)
    }
    
    func get(path: String) {
        let url = NSURL(string: path)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            if let err = error {
                NSLog("\(err.localizedDescription)")
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
            
            if (err != nil) {
                NSLog("Json error \(err!.localizedDescription)")
            }
            
            let results: NSArray = jsonResult
            self.delegate.didReceiveDepartureTime(results)
            
        })
        // start the task
        task.resume()
    }
}

protocol DepartureTimeApplicationProtocol {
    func didReceiveDepartureTime(results: NSArray)
}