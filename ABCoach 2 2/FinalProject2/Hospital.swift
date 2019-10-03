//
//  Hospital.swift
//  testForFinalProject
//
//  Created by Steven Schlau on 12/2/18.
//  Copyright © 2018 Steven's Original Apps. All rights reserved.
//

import Foundation
import UIKit

class Hospital {
    var name: String
    var xCoord: Double
    var yCoord: Double
    var rating: Double
    var vicin: String
    var distance: Double
    
    init(name: String, yCoord: Double, xCoord: Double, rating: Double, vicin: String, distance: Double) {
        self.name = name
        self.xCoord = xCoord
        self.yCoord = yCoord
        self.rating = rating
        self.vicin = vicin
        self.distance = distance
    }
}
