//
//  HealthFind.swift
//  testForFinalProject
//
//  Created by Steven Schlau on 11/27/18.
//  Copyright © 2018 Steven's Original Apps. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class HealthFind: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var hospitals: [Hospital] = []
    var userLoc: CLLocation?
    var lat: Double!
    var lon: Double!
    let locationManager = CLLocationManager()
    var resultsArray:[Dictionary<String, AnyObject>] = Array()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "theCell")! as UITableViewCell
        myCell.textLabel?.text = (hospitals[indexPath.row].name)
        return myCell
    }
    
    func findPlace (place: String) {
        print("Hello1")
        //print((userLoc?.coordinate.latitude)!)
        var link = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat!),\(lon!)&type=\(place)&radius=50000&key=AIzaSyBCOw7qMrkSlhX8h1Qr2c9JM_X2vcCVYzU"
        link = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(link)
        var urlRequest = URLRequest(url: URL(string: link)!)
        urlRequest.httpMethod = "GET"
        let function = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                if let responseData = data {
                    let jsonDict = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    if let dict = jsonDict as? Dictionary<String, AnyObject>{
                        if let results = dict["results"] as? [Dictionary<String,AnyObject>] {
                            for dct in results {
                                self.resultsArray.append(dct)
                                let coor = (((dct["geometry"]!["location"]!)!)) as? AnyObject
                                if dct["rating"] == nil {
                                    self.hospitals.append(Hospital(name: (dct["name"] as! String), yCoord: (coor!["lng"]! as! Double), xCoord: (coor!["lat"]! as! Double), rating: 0.0))
                                }
                                else {
                                self.hospitals.append(Hospital(name: (dct["name"] as! String), yCoord: (coor!["lng"]! as! Double), xCoord: (coor!["lat"]! as! Double), rating: (dct["rating"] as! Double)))
                                }
                            }
                        }
                    }
                }
            }else {
                print("Error Connecting")
            }
            dump(self.hospitals)
            self.update()
        }
        function.resume()
        print("HELLOOOOOO")
        dump(self.hospitals)
        tableView.reloadData()
    }
    
    func update() {
        tableView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let someLocation = locations[locations.count-1]
        userLoc = someLocation
        lat = (userLoc?.coordinate.latitude)!
        lon = (userLoc?.coordinate.longitude)!
        findPlace(place: "hospital")
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello")
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "theCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
