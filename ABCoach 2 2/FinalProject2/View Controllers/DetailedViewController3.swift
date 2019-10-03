//
//  DetailedViewController3.swift
//  FinalProject2
//
//  Created by Alan Makedon on 11/30/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import UIKit

class DetailedViewController3: UIViewController {
    
    var temp: Any = ""
    var question:[String] = []
    var answers:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame1 = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let scrollView = UIScrollView(frame: frame1)
        view.addSubview(scrollView)
        let a0 = UserDefaults.standard.array(forKey: "Demographics") as! [String]
        let a1 = UserDefaults.standard.array(forKey: "Abdominal Pain") as! [String]
        let a2 = UserDefaults.standard.array(forKey: "Burn") as! [String]
        let a3 = UserDefaults.standard.array(forKey: "Bleeding") as! [String]
        let a4 = UserDefaults.standard.array(forKey: "Chest Pain") as! [String]
        let a5 = UserDefaults.standard.array(forKey: "Difficulty Breathing") as! [String]
        let a6 = UserDefaults.standard.array(forKey: "Feel Like Fainting") as! [String]
        let a7 = UserDefaults.standard.array(forKey: "Injured Limb") as! [String]
        let a8 = UserDefaults.standard.array(forKey: "Intoxication") as! [String]
        let a9 = UserDefaults.standard.array(forKey: "Panic Attack") as! [String]
        let a10 = UserDefaults.standard.array(forKey: "Stroke") as! [String]
        let a11 = UserDefaults.standard.array(forKey: "Seizure") as! [String]
        
        let q0 = UserDefaults.standard.array(forKey: "Demographics Questions") as! [String]
        let q1 = UserDefaults.standard.array(forKey: "Abdominal Pain Questions") as! [String]
        let q2 = UserDefaults.standard.array(forKey: "Burn Questions") as! [String]
        let q3 = UserDefaults.standard.array(forKey: "Bleeding Questions") as! [String]
        let q4 = UserDefaults.standard.array(forKey: "Chest Pain Questions") as! [String]
        let q5 = UserDefaults.standard.array(forKey: "Difficulty Breathing Questions") as! [String]
        let q6 = UserDefaults.standard.array(forKey: "Feel Like Fainting Questions") as! [String]
        let q7 = UserDefaults.standard.array(forKey: "Injured Limb Questions") as! [String]
        let q8 = UserDefaults.standard.array(forKey: "Intoxication Questions") as! [String]
        let q9 = UserDefaults.standard.array(forKey: "Panic Attack Questions") as! [String]
        let q10 = UserDefaults.standard.array(forKey: "Stroke Questions") as! [String]
        let q11 = UserDefaults.standard.array(forKey: "Seizure Questions") as! [String]
        let arr = a0+a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11
        let arr2 = q0+q1+q2+q3+q4+q5+q6+q7+q8+q9+q10+q11
        
        answers = arr
        
        question = arr2
        var i = 0
        let height = 20
        var pos = 40
        while(i<answers.count){
            if(answers[i] != ""){
                let frame2 = CGRect(x: Int(scrollView.frame.width - 200), y: pos, width: 180, height: height)
                let frame3 = CGRect(x: 40, y: pos, width: 120, height: height)
                let aTextBox = UITextView(frame: frame2)
                let qTextBox = UITextView(frame: frame3)
                aTextBox.font = UIFont(name:"Avenir", size: 15)
                qTextBox.font = UIFont(name: "Avenir", size: 15)
                aTextBox.text = answers[i]

                qTextBox.text = question[i]
                var fr = aTextBox.frame
                var fr2 = qTextBox.frame
                fr.size.height = aTextBox.contentSize.height * 3
                fr2.size.height = qTextBox.contentSize.height * 3
                aTextBox.frame.size.height = fr.height
                qTextBox.frame.size.height = fr2.height
                if (fr.size.height > fr2.size.height){
                    pos = pos + Int(fr.size.height/3) + 10
                    
                } else {
                    pos = pos + Int(fr2.size.height/3) + 10
                    
                }
                scrollView.addSubview(aTextBox)
                scrollView.addSubview(qTextBox)
                i+=1
            }
            else{
                i+=1
            }
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: CGFloat(pos) + 200.0)
        // Do any additional setup after loading the view.
        
    }
}
