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
    var check = 0
    var index : IndexPath?
    @IBOutlet weak var spin: UIActivityIndicatorView!
    var hospitals: [Hospital] = []
    var userLoc: CLLocation?
    var lat: Double!
    var lon: Double!
    let locationManager = CLLocationManager()
    var resultsArray:[Dictionary<String, AnyObject>] = Array()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitals.count
    }
    
    @IBAction func sortType(_ sender: Any) {
        check=check+1
        if check%2 == 0 {
            self.hospitals.sort(by: { $0.distance <= $1.distance })
        }
        else {
            self.hospitals.sort(by: { $0.rating >= $1.rating })
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell: HospitalTableViewCell = tableView.dequeueReusableCell(withIdentifier: "theCell", for: indexPath) as! HospitalTableViewCell 
        myCell.name?.text = (hospitals[indexPath.row].name)
        myCell.address?.text = getCity(address: hospitals[indexPath.row].vicin)
        let x = hospitals[indexPath.row].rating
        myCell.rating?.text = String(Double(round(100*x)/100)) + "/5"
        myCell.namePlace = hospitals[indexPath.row].name
        myCell.xCoor = Double(hospitals[indexPath.row].xCoord)
        myCell.yCoor = Double(hospitals[indexPath.row].yCoord)
        return myCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HospitalTableViewCell
        cell.go(xCoor: Double(hospitals[indexPath.row].xCoord), yCoor: Double(hospitals[indexPath.row].yCoord), name: hospitals[indexPath.row].name)
        index = indexPath
    }
    func findPlace (place: String) {
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
                            self.hospitals.removeAll()
                            for dct in results {
                                self.resultsArray.append(dct)
                                let coor = (((dct["geometry"]!["location"]!)!)) as? AnyObject
                                let meX = Double((self.userLoc?.coordinate.latitude)!)
                                let xCoor = Double((coor!["lat"]!) as! Double)
                                let meY = Double((self.userLoc?.coordinate.longitude)!)
                                let yCoor = Double((coor!["lng"]!) as! Double)
                                print (yCoor, xCoor, meX, meY)
                                let dist = sqrt(((meX-xCoor)*(meX-xCoor))+((meY-yCoor)*(meY-yCoor)))
                                if dct["rating"] == nil {
                                    self.hospitals.append(Hospital(name: (dct["name"] as! String), yCoord: (coor!["lng"]! as! Double), xCoord: (coor!["lat"]! as! Double), rating: 0.0, vicin: dct["vicinity"] as! String, distance: dist))
                                }
                                else {
                                    self.hospitals.append(Hospital(name: (dct["name"] as! String), yCoord: (coor!["lng"]! as! Double), xCoord: (coor!["lat"]! as! Double), rating: (dct["rating"] as! Double), vicin: dct["vicinity"] as! String, distance: dist))
                                }
                            }
                            dump(self.hospitals)
                            DispatchQueue.main.async {
                                self.hospitals.sorted(by: { $0.distance < $1.distance })
                                self.tableView.reloadData()
                                self.spin.stopAnimating()
                                self.spin.hidesWhenStopped = true
                            }
                        }
                    }
                }
            }else {
                print("Error Connecting")
            }
        }
        function.resume()
        dump(self.hospitals)
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
        spin.color = UIColor.white
        spin.startAnimating()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 132
        tableView.backgroundColor = view.backgroundColor
    }

    func getCity(address: String) -> String{
         var address2 = address
        for item in address{
            if (item != ","){
                address2.remove(at: address2.index(of: item)!)
            } else{
                break
            }
        }
        address2.removeFirst()
        return address2
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        // Dispose of any resources that can be recreated.
    }
}
