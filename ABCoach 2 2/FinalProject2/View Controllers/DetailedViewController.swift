//
//  DetailedViewController.swift
//  FinalProject2
//
//  Created by Alan Makedon on 11/22/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var birthday: UITextField!
    
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var allergies: UITextField!
    @IBOutlet weak var medication: UITextField!
    @IBOutlet weak var medical: UITextField!
    @IBOutlet weak var food: UITextField!
    var boxes: [UITextField] = []
    @IBOutlet weak var theScrollView: UIScrollView!
    
    @IBOutlet weak var ContentView: UIView!
    var activeField: NotesField?
    override func viewDidLoad() {
        super.viewDidLoad()
        let arrq = ["Name:","Age:","Birthday:","Address/Dorm:","Allergies:", "Medications:","Medical History:","Last Food/Drink:"]
        UserDefaults.standard.set(arrq, forKey: "Demographics Questions")
        hideKeyboard()
        boxes = [name, age, birthday, address, allergies, medication, medical, food]
        var j = 0
        let arr = UserDefaults.standard.array(forKey: "Demographics") as! [String]
        let temp: [String] = []
        if(arr != temp){
            while (j < 8){
                boxes[j].text = arr[j]
                j += 1
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Summary", style: .plain, target: self, action: #selector(getSummary))
    }
    @objc func getSummary(sender: UIButton!) {
        performSegue(withIdentifier: "det3", sender: sender)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        setDemDefaults()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newDest = segue.destination as! DetailedViewController3 
        setDemDefaults()
        newDest.temp = " "
        
    }
    func setDemDefaults(){
        var j = 0
        var newinfo: [String] = []
        while (j < 8){
            if(boxes[j].text! != ""){
                newinfo.append(boxes[j].text!)
                
            } else {
                newinfo.append("")
                
            }
            j += 1
            
        }
        UserDefaults.standard.set(newinfo, forKey: "Demographics")
        
    }
    
    
}
