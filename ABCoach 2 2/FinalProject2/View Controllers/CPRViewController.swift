//
//  CPRViewController.swift
//  FinalProject2
//
//  Created by Alan Makedon on 11/20/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit
import CoreLocation


class CPRViewController: UIViewController, CLLocationManagerDelegate  {
    
    @IBOutlet weak var firstAED: UILabel!
    @IBOutlet weak var secondAED: UILabel!
    @IBOutlet weak var thirdAED: UILabel!
    @IBOutlet weak var bigHeart: UIImageView!
    @IBOutlet weak var smallHeart: UIImageView!
    let locationManager = CLLocationManager()
    var theTick: SystemSoundID = 0
    var timer = Timer()
    var bigHeartHere: Bool = true
    var tickOn: Bool = false
    var closeAEDS: [AED] = []
    var closeBuildings: [Building] = []
    var userLoc: CLLocation?
    var currentLoc: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSound()
        playBPM()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        firstAED.text = "\(closeAEDS[0].building) Floor \(closeAEDS[0].floor!)"
        secondAED.text = "\(closeAEDS[1].building) Floor \(closeAEDS[1].floor!)"
        thirdAED.text = "\(closeAEDS[2].building) Floor \(closeAEDS[2].floor!)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
        toggleTorch(on: false)
    }
    func playBPM(){
        if (tickOn == false){
            tickOn = true
            timer = Timer.scheduledTimer(withTimeInterval: 0.254, repeats: true) { timer in
                if(self.bigHeart.isHidden == false) {
                    self.bigHeart.isHidden = true
                    AudioServicesPlaySystemSound(self.theTick)
                    self.toggleTorch(on: false)
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                }
                else {
                    self.bigHeart.isHidden = false
                    self.toggleTorch(on: true)
                }
            }
            
        } else {
            timer.invalidate()
            tickOn = false
        }
    }
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        }
    }
    @IBAction func callEST(_ sender: Any) {
        alerting()
    }
    func createSound() {
        let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "song" as CFString, "mp3" as CFString, nil)
        AudioServicesCreateSystemSoundID(soundURL! , &theTick)
    }
    func alerting() {
        let alert = UIAlertController(title: "Call EST", message: "Press CALL to call EST", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("CALL", comment: "Default action"), style: .default, handler: { _ in
            if let phoneCallURL = URL(string: "tel://+13149357140") { //this is Prof Sproull's office number which we added so graders wouldn't be accidentally calling EST. ESTs phone number is +13149355555
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

    
}
