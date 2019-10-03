//
//  MKPoint.swift
//  FinalProject2
//
//  Created by Yak Fishman on 12/2/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import Foundation
import MapKit

class Point: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
