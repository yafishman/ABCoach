//
//  Building.swift
//  FinalProject2
//
//  Created by Yak Fishman on 12/2/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import Foundation
import UIKit
class Building: Decodable {
    var name: String
    var xCoord: Double!
    var yCoord: Double!
    
    init(name: String, yCoord: Double, xCoord: Double) {
        self.name = name
        self.xCoord = xCoord
        self.yCoord = yCoord
    }
}
