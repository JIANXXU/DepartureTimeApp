//
//  Annotation.swift
//  DepartureTime
//
//  Created by Xu, Steven (Jian) on 10/26/14.
//  Copyright (c) 2014 Xu, Steven (Jian). All rights reserved.
//

import Foundation
import MapKit

//
// This is the annotation class used to show Departure Time on the Map
//
class Annotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
