//
//  HHLOCViewController.swift
//  FinalProject2
//
//  Created by Alan Makedon on 11/26/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import UIKit
import MessageUI

class HHLOCViewController: UIViewController,UIAlertViewDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var LOCYes: UIButton!
    @IBOutlet weak var LOCIDK: UIButton!
    @IBOutlet weak var LOCNo: UIButton!
    
    @IBOutlet weak var HHNo: UIButton!
    @IBOutlet weak var HHIDK: UIButton!
    @IBOutlet weak var HHYes: UIButton!
    var AEDLocation: AED?
    var HH = Bool()
    var LOC = Bool()
    var HHPressed = Bool()
    var LOCPressed = Bool()
    var buttonArray: [UIButton?] = []
    var closeBuildings: [Building] = []
    var currentLoc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.isEnabled = false
        continueButton.alpha = 0
        HH = false // default no they haven't
        LOC = false //default no they haven't
        HHPressed = false
        LOCPressed = false
        buttonArray = [LOCYes, LOCIDK, LOCNo, HHYes, HHIDK, HHNo]
        for button in buttonArray{
            button?.layer.cornerRadius = 5
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LOCYes(_ sender: Any) {
        LOCPressed = true
        LOCIDK.alpha = 0.4
        LOCNo.alpha = 0.4
        LOCYes.alpha = 1
        canYouContinue()
    }
    @IBAction func LOCNotSure(_ sender: Any) {
        LOC = true
        LOCPressed = true
        LOCNo.alpha = 0.4
        LOCYes.alpha = 0.4
        LOCIDK.alpha = 1
        LOCAlert()
        canYouContinue()
        
    }
    
    @IBAction func LOCNo(_ sender: Any) {
        LOCAlert()
        LOCPressed = true
        LOCIDK.alpha = 0.4
        LOCYes.alpha = 0.4
        LOCNo.alpha = 1
        canYouContinue()
    }
    @IBAction func HHYes(_ sender: Any) {
        HHAlert()
        HHPressed = true
        HHNo.alpha = 0.4
        HHIDK.alpha = 0.4
        HHYes.alpha = 1
        canYouContinue()
    }
    @IBAction func HHNotSure(_ sender: Any) {
        HHAlert()
        HHPressed = true
        HHNo.alpha = 0.4
        HHYes.alpha = 0.4
        HHIDK.alpha = 1
        canYouContinue()
    }
    @IBAction func HHNo(_ sender: Any) {
        HHPressed = true
        HHYes.alpha = 0.4
        HHIDK.alpha = 0.4
        HHNo.alpha = 1
        canYouContinue()
    }
    func HHAlert() {
        let alert = UIAlertController(title: "Hit Head", message: "If there is any chance the person hit their head, try to keep them as still as possible!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func LOCAlert() {
        let alert = UIAlertController(title: "Lost Consciousness", message: "If there is any chance the person has lost consciousness, use the buttons below to call EST and find the nearest AED!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func callEST(_ sender: Any) {
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
        messageVC.body = "I need help with a medical emergency. Here are my coordinates: \((currentLoc)!). And I am near these buildings: \(closeBuildings[0].name), \(closeBuildings[1].name), \(closeBuildings[2].name)";
        messageVC.recipients = ["3149357140"] //This is Prof Sproull's office number to avoid accidentally calling EST during testing. EST's number is 3149355555
        messageVC.messageComposeDelegate = self
        self.present(messageVC, animated: true, completion: nil)
    }
    
    @IBAction func findAED(_ sender: Any) {
        let alert = UIAlertController(title: "Nearest AED", message: "Nearest AED is in \(AEDLocation!.building) Floor \(AEDLocation!.floor!)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alerting() {
        let alert = UIAlertController(title: "Call EST", message: "Press CALL to call EST", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("CALL", comment: "Default action"), style: .default, handler: { _ in
            if let phoneCallURL = URL(string: "tel://+13149357140") { ////This is Prof Sproull's office number to avoid accidentally calling EST during testing. EST's number is 3149355555
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
    func canYouContinue(){
        if (HHPressed == true && LOCPressed == true){
            continueButton.isEnabled = true
            continueButton.alpha = 1
        }
    }
}
