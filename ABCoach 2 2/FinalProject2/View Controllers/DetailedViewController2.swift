//
//  DetailedViewController2.swift
//  FinalProject2
//
//  Created by Alan Makedon on 11/24/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import UIKit

class DetailedViewController2: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    var titleDisplay = UILabel()
    var selectedSymptom: Symptom?
    var totalHeight: CGFloat?
    var totalWidth: CGFloat?
    var numOfQs: Int?
    var textBoxes: [NotesField] = []
    var theScrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleFrame = CGRect(x: 0, y: 50, width: view.frame.width, height: 40)
        titleDisplay.frame = titleFrame
        titleDisplay.textAlignment = .center
        titleDisplay.font = UIFont(name: "Avenir", size: 30)
        titleDisplay.text = selectedSymptom?.title
        titleDisplay.textColor = UIColor.white
        
        let magicNumber = Double(titleDisplay.bounds.height + 90) * Double(numOfQs!)
        
        theScrollView = UIScrollView(frame: view.frame)
        theScrollView?.backgroundColor = view.backgroundColor
        theScrollView?.addSubview(titleDisplay)
        theScrollView?.contentSize = CGSize(width: Double(view.frame.width), height: magicNumber + 500)
        
        view.addSubview(theScrollView!)
        
        totalHeight = view.bounds.height
        totalWidth = view.bounds.width
        if (selectedSymptom?.title == "Intoxication"){
            alerting(warningString: "Gather as many details about their night as possible! The more information you can provide EST, the better!")
        } else if (selectedSymptom?.title == "Seizure"){
            alerting(warningString: "There is nothing you can do to stop a seizure! Clear the area of furniture/people so this person doesn't hurt themselves any further. Also, stay clear yourself so you don't get hurt!")
        }
        makeBoxes()        
        hideKeyboard()
        // Do any additional setup after loading the view.
    }
    @objc func editingAction(sender: NotesField!) {
        sender.textFieldDidEndEditing(sender)
        //https://stackoverflow.com/questions/28010518/swift-open-web-page-in-app-button-doesnt-react
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func makeBoxes(){
        var i = 1.0
        while (i <= Double(numOfQs!)){
            
            let notesFrame = CGRect(x: Double(view.center.x)-150.0 , y: Double(titleDisplay.bounds.height + 90)*i, width: 300.0, height: 75.0)
            let promptFrame = CGRect(x: Double(view.center.x)-150.0 , y: Double(notesFrame.minY - 30), width: 300.0, height: 40.0)
            let prompt = UILabel(frame: promptFrame)
            let question = NotesField(frame: notesFrame)
            prompt.text = selectedSymptom?.specialQuestions[Int(i)-1]
            prompt.textAlignment = .center
            prompt.textColor = UIColor.white
            prompt.lineBreakMode = .byWordWrapping
            question.backgroundColor = UIColor.white
            question.title = prompt.text
            question.layer.borderWidth = 0.5
            question.layer.borderColor = UIColor.lightGray.cgColor
            question.layer.cornerRadius = 5
            question.placeholder = "Notes:"
            question.textAlignment = .left
            question.font = UIFont(name: "Avenir", size: 15)
            question.textColor = UIColor.black
            question.addTarget(self, action: #selector(editingAction),for: .editingDidEnd)
            theScrollView?.addSubview(question)
            theScrollView?.addSubview(prompt)
            i += 1
            textBoxes.append(question)
        }
        var j = 0
        let arr = UserDefaults.standard.array(forKey: (selectedSymptom?.title)!) as! [String]
        let temp: [String] = []
        while (j < numOfQs!){
            if(arr != temp){
                textBoxes[j].text = arr[j]
            }
            j += 1
        }
      
    }
    override func viewWillDisappear(_ animated: Bool) {
        var j = 0
        var newinfo: [String] = []
        while (j < numOfQs!){
            if(textBoxes[j].text! != ""){
                newinfo.append(textBoxes[j].text!)

            } else {
                newinfo.append("")

            }
            j += 1

        }
        UserDefaults.standard.set(newinfo, forKey: (selectedSymptom?.title)!)
    }
    
    func alerting(warningString: String) {
        let alert = UIAlertController(title: selectedSymptom?.title, message: warningString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"Continue\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
extension UIViewController {
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}



