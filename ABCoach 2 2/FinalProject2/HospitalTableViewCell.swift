//
//  HospitalTableViewCell.swift
//  FinalProject2
//
//  Created by Steven Schlau on 12/2/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import UIKit
import MapKit

class HospitalTableViewCell: UITableViewCell {
    var xCoor: Double?
    var yCoor: Double?
    var namePlace: String?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var dist: UILabel!
    @IBAction func toMaps(_ sender: Any) {
      go(xCoor: xCoor!, yCoor: yCoor!, name: namePlace!)
    }
    func go (xCoor: Double, yCoor: Double, name: String) {
        let latitude: CLLocationDegrees = xCoor
        let longitude: CLLocationDegrees = yCoor
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
