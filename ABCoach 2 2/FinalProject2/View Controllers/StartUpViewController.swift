//
//  StartUpViewController.swift
//  FinalProject2
//
//  Created by Alan Makedon on 11/21/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import UIKit
import MessageUI
import CoreLocation


class StartUpViewController: UIViewController,UIAlertViewDelegate,CLLocationManagerDelegate,MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var notsureButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    var alert = CallESTController()
    @IBOutlet weak var callEST: UIButton!
    var userLoc: CLLocation?
    var firstAED = String?.self
    let locationManager = CLLocationManager()
    var buildings: [Building] = []
    var closestBuildings: [Building] = []
    var aeds: [AED] = []
    var closestAEDS: [AED] = []
    
    override func viewDidLoad() {
        makeAED()
        makeBuildings()
        UserDefaults.standard.set(["","","","","","","",""], forKey: "Abdominal Pain")
        UserDefaults.standard.set(["", "", "", ""], forKey: "Burn")
        UserDefaults.standard.set(["","","","",""], forKey: "Bleeding")
        UserDefaults.standard.set(["","", "", "", "", "", "", "","", "", "", "", "", ""], forKey: "Chest Pain")
        UserDefaults.standard.set(["","", "", "", "", ""], forKey: "Difficulty Breathing")
        UserDefaults.standard.set(["","", "", "", "", "", ""], forKey: "Feel Like Fainting")
        UserDefaults.standard.set(["","", "", "", ""], forKey: "Injured Limb")
        UserDefaults.standard.set(["","", "", "", "", "","", "", "","", "", "", ""], forKey: "Intoxication")
        UserDefaults.standard.set(["","", ""], forKey: "Panic Attack")
        UserDefaults.standard.set(["","", "", "", "", "", ""], forKey: "Stroke")
        UserDefaults.standard.set(["","", "", "", "", ""], forKey: "Seizure")
        UserDefaults.standard.set(["","", "", "", "", "", "", ""], forKey: "Demographics")
        super.viewDidLoad()
        yesButton.layer.cornerRadius = 5
        noButton.layer.cornerRadius = 5
        notsureButton.layer.cornerRadius = 5
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func callESTPressed(_ sender: Any) {
        alerting()
    }

    @IBAction func sendLocation(_ sender: Any) {
        let alert = UIAlertController(title: "Send Location", message: "Press Send to send location to EST", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Send", comment: "Default action"), style: .default, handler: { _ in
            self.sendMessage()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            NSLog("The \"Cancel\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            dismiss(animated: true, completion: nil)
        }
    }
    func sendMessage() {
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "I need help with a medical emergency. Here are my coordinates: (\((userLoc?.coordinate.latitude)!), \((userLoc?.coordinate.longitude)!)). And I am near these buildings: \(closestBuildings[0].name), \(closestBuildings[1].name), \(closestBuildings[2].name)";
        messageVC.recipients = ["3149357140"] //This is Prof Sproull's office number to avoid accidentally calling EST during testing. EST's number is 3149355555
        messageVC.messageComposeDelegate = self
        self.present(messageVC, animated: true, completion: nil)
    }
    
    @IBAction func findAED(_ sender: Any) {
        let alert = UIAlertController(title: "Nearest AED", message: "Nearest AED is in \(closestAEDS[0].building) Floor \(closestAEDS[0].floor!)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func alerting() {
        let alert = UIAlertController(title: "Call EST", message: "Press CALL to call EST", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("CALL", comment: "Default action"), style: .default, handler: { _ in
            if let phoneCallURL = URL(string: "tel://+13149357140") { //This is Prof Sproull's number to avoid accidentally calling EST during testing. EST's number is 3149355555
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
            NSLog("The \"OK\" alert occured.")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            NSLog("The \"Cancel\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func distance(xOne: Double, xTwo: Double, yOne: Double, yTwo: Double) -> Double{
        return ((xOne-xTwo)*(xOne-xTwo)+(yOne-yTwo)*(yOne-yTwo))
    }
    
    func closestBuilding(location : CLLocation){
        closestBuildings.removeAll()
        var first = buildings[0]
        var firstDistance : Double = 10.0
        var second = buildings[0]
        var secondDistance : Double = 10.0
        var third = buildings[0]
        var thirdDistance : Double = 10.0
        var newDistance: Double
        for building in buildings {
            newDistance = distance(xOne: location.coordinate.longitude, xTwo: building.xCoord, yOne: location.coordinate.latitude, yTwo: building.yCoord)
            if newDistance < thirdDistance {
                if newDistance > secondDistance {
                    thirdDistance = newDistance
                    third = building
                } else {
                    if newDistance > firstDistance {
                        thirdDistance = secondDistance
                        third = second
                        secondDistance=newDistance
                        second = building
                    } else {
                        thirdDistance = secondDistance
                        third = second
                        secondDistance=firstDistance
                        second = first
                        firstDistance=newDistance
                        first = building
                    }
                }
            }
        }
        closestBuildings.append(first)
        closestBuildings.append(second)
        closestBuildings.append(third)
    }
    
    func closestAED(location : CLLocation){
        closestAEDS.removeAll()
        var first = aeds[0]
        var firstDistance : Double = 10.0
        var second = aeds[0]
        var secondDistance : Double = 10.0
        var third = aeds[0]
        var thirdDistance : Double = 10.0
        var newDistance: Double
        for aed in aeds {
            newDistance = distance(xOne: location.coordinate.latitude, xTwo: aed.xCoord, yOne: location.coordinate.longitude, yTwo: aed.yCoord)
            if newDistance <= thirdDistance {
                if newDistance >= secondDistance {
                    thirdDistance = newDistance
                    third = aed
                } else {
                    if newDistance >= firstDistance {
                        thirdDistance = secondDistance
                        third = second
                        secondDistance=newDistance
                        second = aed
                    } else {
                        thirdDistance = secondDistance
                        third = second
                        secondDistance=firstDistance
                        second = first
                        firstDistance=newDistance
                        first = aed
                    }
                }
            }
        }
        closestAEDS.append(first)
        closestAEDS.append(second)
        closestAEDS.append(third)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "cprsegue"){
            let destination = segue.destination as! CPRViewController
            destination.closeAEDS = closestAEDS
            destination.closeBuildings = closestBuildings
            destination.currentLoc = "(\((userLoc?.coordinate.latitude)!), \((userLoc?.coordinate.longitude)!)"
        } else{
            let destination = segue.destination as! HHLOCViewController
            destination.AEDLocation = closestAEDS[0]
            destination.closeBuildings = closestBuildings
            destination.currentLoc = "(\((userLoc?.coordinate.latitude)!), \((userLoc?.coordinate.longitude)!))"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let someLocation = locations[locations.count-1]
        userLoc = someLocation
        locationManager.stopUpdatingLocation()
        closestAED(location: userLoc!)
        closestBuilding(location: userLoc!)
    }
    
    func makeAED () {
        aeds.append(AED(building: "Village House", yCoord: -90.314104, xCoord: 38.650629, floor: 1))
        aeds.append(AED(building: "Alumni House", yCoord: -90.31204493, xCoord: 38.64583896, floor: 1))
        aeds.append(AED(building: "Knight Center", yCoord: -90.31125852, xCoord: 38.64971973, floor: 2))
        aeds.append(AED(building: "Brauer Hall", yCoord: -90.310769, xCoord: 38.649831, floor: 2))
        aeds.append(AED(building: "Millbrook Building", yCoord: -90.309691, xCoord: 38.650402, floor: 1))
        aeds.append(AED(building: "276 Skinker Blvd", yCoord: -90.30039914, xCoord: 38.649674689, floor: 3))
        aeds.append(AED(building: "560 Music Center", yCoord: -90.310753, xCoord: 38.655737, floor: 1))
        aeds.append(AED(building: "Kemper Art Museum", yCoord: -90.30281242, xCoord: 38.64706643, floor: 1))
        aeds.append(AED(building: "Brookings Hall", yCoord: -90.305081, xCoord: 38.64812, floor: 1))
        aeds.append(AED(building: "Ridgley Hall", yCoord: -90.306245, xCoord: 38.648138, floor: 1))
        aeds.append(AED(building: "Olin Library", yCoord: -90.30771507, xCoord: 38.64837742, floor: 1))
        aeds.append(AED(building: "Graham Chapel", yCoord: -90.30884, xCoord: 38.64825, floor: 1))
        aeds.append(AED(building: "Mallinckrodt Center", yCoord: -90.309449, xCoord: 38.647494, floor: 1))
        aeds.append(AED(building: "Danforth University Center (DUC)", yCoord: -90.310467, xCoord: 38.647821, floor: 1))
        aeds.append(AED(building: "Simon Hall", yCoord: -90.31127279, xCoord: 38.64792696, floor: 1))
        aeds.append(AED(building: "Sumers Recreation Center", yCoord: -90.314924, xCoord: 38.649018, floor: 1))
        aeds.append(AED(building: "Sumers Recreation Center", yCoord: -90.315092, xCoord: 38.648995, floor: 2))
        aeds.append(AED(building: "Sumers Recreation Center", yCoord: -90.314979, xCoord: 38.648814, floor: 2))
        aeds.append(AED(building: "Sumers Recreation Center", yCoord: -90.314935, xCoord: 38.64876, floor: 3))
        aeds.append(AED(building: "Dardick House", yCoord: -90.315393, xCoord: 38.645742, floor: -1))
        aeds.append(AED(building: "Lien House", yCoord: -90.313469, xCoord: 38.645662, floor: -1))
        aeds.append(AED(building: "South 40 House", yCoord: -90.313479, xCoord: 38.644562, floor: -1))
    }
    func makeBuildings() {
        //Main Campus
        buildings.append(Building(name: "Athletic Center", yCoord: 38.649167, xCoord: -90.314825))
        buildings.append(Building(name: "Francis Field", yCoord: 38.647897, xCoord: -90.313847))
        buildings.append(Building(name: "Seigle Hall", yCoord: 38.648984, xCoord: -90.312493))
        buildings.append(Building(name: "The Underpass", yCoord: 38.647063, xCoord: -90.312271))
        buildings.append(Building(name: "Green Hall", yCoord: 38.648811, xCoord: -90.301445))
        buildings.append(Building(name: "Simon Hall", yCoord: 38.648153, xCoord: -90.311516))
        buildings.append(Building(name: "Anheuser-Busch Hall", yCoord: 38.649693, xCoord: -90.312088))
        buildings.append(Building(name: "Knight Center", yCoord: 38.649672, xCoord: -90.311334))
        buildings.append(Building(name: "Knight Hall", yCoord: 38.649796, xCoord: -90.310606))
        buildings.append(Building(name: "Bauer Hall", yCoord: 38.649444, xCoord: -90.310606))
        buildings.append(Building(name: "McMillan Hall", yCoord: 38.649570, xCoord: -90.309884))
        buildings.append(Building(name: "Laboratory Sciences Building", yCoord: 38.649530, xCoord: -90.308965))
        buildings.append(Building(name: "Women's Building", yCoord: 38.649331, xCoord: -90.308453))
        buildings.append(Building(name: "Louderman Hall", yCoord: 38.649243, xCoord: -90.307764))
        buildings.append(Building(name: "McMillen Laboratory", yCoord: 38.649624, xCoord: -90.307689))
        buildings.append(Building(name: "Bryan Hall", yCoord: 38.649494, xCoord: -90.307001))
        buildings.append(Building(name: "Jolley Hall", yCoord: 38.649455, xCoord: -90.306591))
        buildings.append(Building(name: "Cupples II Hall", yCoord: 38.649167, xCoord: -90.306803))
        buildings.append(Building(name: "Lopata Hall", yCoord: 38.649088, xCoord: -90.306189))
        buildings.append(Building(name: "Urbauer Hall", yCoord: 38.649378, xCoord: -90.306015))
        buildings.append(Building(name: "Sever Hall", yCoord: 38.648828, xCoord: -90.306374))
        buildings.append(Building(name: "Duncker Hall", yCoord: 38.648519, xCoord: -90.306184))
        buildings.append(Building(name: "Cupples I Hall", yCoord: 38.648639, xCoord: -90.305532))
        buildings.append(Building(name: "Crow Hall", yCoord: 38.649036, xCoord: -90.305277))
        buildings.append(Building(name: "Compton Hall", yCoord: 38.649469, xCoord: -90.305210))
        buildings.append(Building(name: "Rudolph Hall", yCoord: 38.649107, xCoord: -90.304564))
        buildings.append(Building(name: "Whitaker Hall", yCoord: 38.649138, xCoord: -90.303115))
        buildings.append(Building(name: "Brauer Hall", yCoord: 38.649007, xCoord: -90.302190))
        buildings.append(Building(name: "Brookings Hall", yCoord: 38.648025, xCoord: -90.305079))
        buildings.append(Building(name: "Brookings Quad", yCoord: 38.648093, xCoord: -90.305615))
        buildings.append(Building(name: "Busch Hall", yCoord: 38.647501, xCoord: -90.305714))
        buildings.append(Building(name: "January Hall", yCoord: 38.647736, xCoord: -90.306338))
        buildings.append(Building(name: "Ridgley Hall", yCoord: 38.648127, xCoord: -90.306164))
        buildings.append(Building(name: "Eads Hall", yCoord: 38.648197, xCoord: -90.306837))
        buildings.append(Building(name: "Olin Library", yCoord: 38.648501, xCoord: -90.307695))
        buildings.append(Building(name: "Graham Chapel", yCoord: 38.648222, xCoord: -90.308847))
        buildings.append(Building(name: "Mudd Field", yCoord: 38.648827, xCoord: -90.310799))
        buildings.append(Building(name: "Danforth University Center", yCoord: 38.647812, xCoord: -90.310421))
        buildings.append(Building(name: "Umrath Hall", yCoord: 38.648016, xCoord: -90.309480))
        buildings.append(Building(name: "Malinckrodt Center", yCoord: 38.647582, xCoord: -90.309312))
        buildings.append(Building(name: "Busch Laboratory", yCoord: 38.647715, xCoord: -90.308588))
        buildings.append(Building(name: "Rebstock Hall", yCoord: 38.647636, xCoord: -90.307971))
        buildings.append(Building(name: "Life Sciences Building", yCoord: 38.647444, xCoord: -90.308566))
        buildings.append(Building(name: "Monsanto Laboratory", yCoord: 38.647437, xCoord: -90.307490))
        buildings.append(Building(name: "Psychology Building", yCoord: 38.647044, xCoord: -90.307509))
        buildings.append(Building(name: "Wilson Hall", yCoord: 38.647562, xCoord: -90.306916))
        buildings.append(Building(name: "McDonnell Hall", yCoord: 38.647180, xCoord: -90.306613))
        buildings.append(Building(name: "Brown Hall", yCoord: 38.647163, xCoord: -90.305653))
        buildings.append(Building(name: "Goldfarb Hall", yCoord: 38.646889, xCoord: -90.305915))
        buildings.append(Building(name: "Hillman Hall", yCoord: 38.646823, xCoord: -90.304684))
        buildings.append(Building(name: "Givens Hall", yCoord: 38.646686, xCoord: -90.303478))
        buildings.append(Building(name: "Steinberg Hall", yCoord: 38.646578, xCoord: -90.302775))
        buildings.append(Building(name: "Bixby Hall", yCoord: 38.646527, xCoord: -90.302048))
        buildings.append(Building(name: "Walker Hall", yCoord: 38.646846, xCoord: -90.301882))
        buildings.append(Building(name: "Kemper Art Museum", yCoord: 38.647113, xCoord: -90.302678))
        buildings.append(Building(name: "Green Hall", yCoord: 38.648811, xCoord: -90.301445))
        buildings.append(Building(name: "Green Hall", yCoord: 38.648811, xCoord: -90.301445))
        buildings.append(Building(name: "Green Hall", yCoord: 38.648811, xCoord: -90.301445))
        buildings.append(Building(name: "Green Hall", yCoord: 38.648811, xCoord: -90.301445))
        buildings.append(Building(name: "Green Hall", yCoord: 38.648811, xCoord: -90.301445))
        //Frats
        buildings.append(Building(name: "House 1 (Alpha Delta Phi)", yCoord: 38.649688, xCoord: -90.312634))
        buildings.append(Building(name: "House 2 (Sigma Nu)", yCoord: 38.649712, xCoord: -90.312887))
        buildings.append(Building(name: "House 3 (Sigma Chi)", yCoord: 38.649770, xCoord: -90.313151))
        buildings.append(Building(name: "House 4 (Theta Xi)", yCoord: 38.649790, xCoord: -90.313431))
        buildings.append(Building(name: "House 5", yCoord: 38.649788, xCoord: -90.313691))
        buildings.append(Building(name: "House 6 (Sigma Epsilon Phi)", yCoord: 38.649562, xCoord: -90.314078))
        buildings.append(Building(name: "House 7 (Kappa Sigma)", yCoord: 38.649813, xCoord: -90.314027))
        buildings.append(Building(name: "House 8 (Beta Theta Pi)", yCoord: 38.651110, xCoord: -90.313578))
        buildings.append(Building(name: "House 9 (Alpha Epsilon Pi)", yCoord: 38.651115, xCoord: -90.313801))
        buildings.append(Building(name: "House 10 (Tau Kappa Epsilon)", yCoord: 38.650687, xCoord: -90.314726))
        buildings.append(Building(name: "House 11 (Sigma Phi Epsilon)", yCoord: 38.650583, xCoord: -90.314781))
        //Village
        buildings.append(Building(name: "Village House", yCoord: 38.650588, xCoord: -90.313965))
        buildings.append(Building(name: "Lopata House", yCoord: 38.651172, xCoord: -90.314538))
        buildings.append(Building(name: "Village East", yCoord: 38.650684, xCoord: -90.311705))
        buildings.append(Building(name: "Millbroke Apartment One", yCoord: 38.650383, xCoord: -90.312822))
        buildings.append(Building(name: "Millbroke Apartment Two", yCoord: 38.650786, xCoord:-90.312204))
        buildings.append(Building(name: "Millbroke Apartment Three", yCoord: 38.650895, xCoord: -90.313298))
        buildings.append(Building(name: "Millbroke Apartment Four", yCoord: 38.650881, xCoord: -90.312766))
        //South 40
        buildings.append(Building(name: "Gregg House",yCoord: 38.645973, xCoord: -90.312497))
        buildings.append(Building(name: "Alumni House",yCoord: 38.645750, xCoord: -90.311935))
        buildings.append(Building(name: "Lien House",yCoord: 38.645567, xCoord: -90.313208))
        buildings.append(Building(name: "Nemerov House",yCoord: 38.645675, xCoord: -90.314373))
        buildings.append(Building(name: "Dardick House",yCoord: 38.645762, xCoord: -90.315421))
        buildings.append(Building(name: "Dauten House", yCoord: 38.645272, xCoord: -90.315496))
        buildings.append(Building(name: "Lee House" ,yCoord: 38.645329, xCoord: -90.314706))
        buildings.append(Building(name: "Shanedling House", yCoord: 38.644997, xCoord: -90.315763))
        buildings.append(Building(name: "Rutledge House", yCoord: 38.645054, xCoord: -90.315160))
        buildings.append(Building(name: "Danforth House", yCoord: 38.644678, xCoord: -90.315456))
        buildings.append(Building(name: "Beaumont House", yCoord: 38.644876, xCoord: -90.314553))
        buildings.append(Building(name: "Shepley House", yCoord: 38.644307, xCoord: -90.315882))
        buildings.append(Building(name: "Wheeler House", yCoord: 38.643770, xCoord: -90.315658))
        buildings.append(Building(name: "Park House", yCoord: 38.643623, xCoord: -90.314902))
        buildings.append(Building(name: "Mudd House", yCoord: 38.643492, xCoord: -90.314010))
        buildings.append(Building(name: "Myers House", yCoord: 38.643499, xCoord: -90.313333))
        buildings.append(Building(name: "Hurd House", yCoord: 38.643364, xCoord: -90.312940))
        buildings.append(Building(name: "Eliot A House", yCoord: 38.643982, xCoord: -90.313251))
        buildings.append(Building(name: "Eliot B House", yCoord: 38.644419, xCoord: -90.312949))
        buildings.append(Building(name: "South 40 House", yCoord: 38.644833, xCoord: -90.313136))
        buildings.append(Building(name: "Umrath House", yCoord: 38.645115, xCoord: -90.313526))
        buildings.append(Building(name: "Hitzeman House", yCoord: 38.643434, xCoord: -90.312523))
        buildings.append(Building(name: "Liggett House", yCoord: 38.644586, xCoord: -90.312031))
        buildings.append(Building(name: "Koenig House", yCoord: 38.644912, xCoord: -90.311783))
        buildings.append(Building(name: "Butterfly Garden", yCoord: 38.646493, xCoord: -90.310555))
        buildings.append(Building(name: "The Swamp", yCoord: 38.644281, xCoord: -90.314456))
    }
}
