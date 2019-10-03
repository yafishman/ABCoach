//
//  AED.swift
//  FinalProject2
//
//  Created by Yak Fishman on 12/2/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import Foundation
import UIKit

class AED: Decodable {
    var building: String
    var xCoord: Double!
    var yCoord: Double!
    var floor: Int!
    
    init(building: String, yCoord: Double, xCoord: Double, floor: Int) {
        self.building = building
        self.xCoord = xCoord
        self.yCoord = yCoord
        self.floor = floor
    }
    
}
