//
//  SymptomViewController.swift
//  FinalProject2
//
//  Created by Alan Makedon on 11/21/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import UIKit

class SymptomViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var newTableView: UITableView!
    
    var symptomsArray: [Symptom] = []

    var finalSymptoms: [Symptom] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        newTableView.backgroundColor = view.backgroundColor
        newTableView.dataSource = self
        newTableView.delegate = self
        newTableView.layer.borderWidth = 0.5
        newTableView.layer.borderColor = UIColor.black.cgColor
        newTableView.rowHeight = 75
        makeSymptoms()
    }
    @IBOutlet weak var myTableView: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomsArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        finalSymptoms.append(symptomsArray[indexPath.row])
        self.performSegue(withIdentifier: "symptomseg", sender: tableView)
    }
    
    
    @IBAction func continueButton(_ sender: Any) {
       performSegue(withIdentifier: "sampleseg", sender: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SymptomCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = symptomsArray[indexPath.row].title
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = view.backgroundColor
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "symptomseg"){
            let sympcell = symptomsArray[newTableView.indexPathForSelectedRow!.row]
            let destination = segue.destination as! DetailedViewController2
            destination.selectedSymptom = sympcell
            destination.numOfQs = sympcell.specialQuestions.count
            destination.navigationItem.title = sympcell.title
        } else{
            let destination = segue.destination as! DetailedViewController
            destination.navigationItem.title = "Demographics"
        }
       
    }
    
    func makeSymptoms(){
        symptomsArray.append(Symptom(title: "Abdominal Pain", specialQuestions: ["Call EST & find nearest AED.", "Eaten unusual foods today?", "Allergic to any foods?", "Any trauma?", "Pain with palpation?", "Any vomit?", "Painful bowel movements?", "Any other information?"]))
        UserDefaults.standard.set(symptomsArray[0].specialQuestions, forKey: "Abdominal Pain Questions")
        symptomsArray.append(Symptom(title: "Burn", specialQuestions: ["Call EST & find nearest AED.", "Run under cool (NOT COLD) water.", "Do not pop any blisters", "Any other information?"]))
        UserDefaults.standard.set(symptomsArray[1].specialQuestions, forKey: "Burn Questions")
        symptomsArray.append(Symptom(title: "Bleeding", specialQuestions: ["Call EST", "Apply direct pressure.", "Use a fabric to wrap.", "What caused the injury?", "Any other information?"]))
        UserDefaults.standard.set(symptomsArray[2].specialQuestions, forKey: "Bleeding Questions")
        symptomsArray.append(Symptom(title: "Chest Pain", specialQuestions: ["Call EST & find nearest AED.","Personal history of cardiac issues?", "Family history of cardiac issues?", "Any trauma to the chest?", "Describe the pain.", "Normal blood pressure range?", "History of hypertension?", "Presribed BP medication?","Blood pressure range on meds?", "Prescribed nitroglycerin?", "Taken nitroglycerin?", "Allergic to aspirin?", "Taken aspirin?", "Any other information?"]))
        UserDefaults.standard.set(symptomsArray[3].specialQuestions, forKey: "Chest Pain Questions")
        symptomsArray.append(Symptom(title: "Difficulty Breathing", specialQuestions: ["Call EST and locate nearest AED.","Could this be an allergic reaction?", "If yes, find EpiPen (if they have one)", "Could it be asthma attack?", "If yes, find inhaler", "Any other information?"]))
        UserDefaults.standard.set(symptomsArray[4].specialQuestions, forKey: "Difficulty Breathing Questions")
        symptomsArray.append(Symptom(title: "Feel Like Fainting", specialQuestions: ["Call EST & find nearest AED.","Sit the person down.", "How much water/food today?", "Describe how you feel.", "Any nausea?", "Any lightheadedness?", "Any other information:"]))
        UserDefaults.standard.set(symptomsArray[5].specialQuestions, forKey: "Feel Like Fainting Questions")
        symptomsArray.append(Symptom(title: "Injured Limb", specialQuestions: ["Call EST", "How did it happen?", "Describe the pain.", "Rest, elevate, wait for EST", "Any other information?"]))
         UserDefaults.standard.set(symptomsArray[6].specialQuestions, forKey: "Injured Limb Questions")
        symptomsArray.append(Symptom(title: "Intoxication", specialQuestions: ["Call EST", "Time started drinking?","Time finished drinking?",  "What type of alcohol?", "How many drinks?","Shots? Mixed drinks? Etc.? ","Is this a normal amount?", "Is this a normal reaction?", "Alcohol from trusted source?", "Vomited? How long ago? How much?", "Any other substances?", "Any other information:", "Keep the person awake, do not shake!"]))
         UserDefaults.standard.set(symptomsArray[7].specialQuestions, forKey: "Intoxication Questions")
        symptomsArray.append(Symptom(title: "Panic Attack", specialQuestions: ["Call EST & find AED", "Do grounding techniques (if you know)", "Any other information?"]))
        UserDefaults.standard.set(symptomsArray[8].specialQuestions, forKey: "Panic Attack Questions")
        symptomsArray.append(Symptom(title: "Seizure", specialQuestions: ["Call EST & find AED", "Clear the area!!!", "How long was the seizure?","History of seizures/epilepsy?", "Do they know where they are located?", "Any other information?"]))
        UserDefaults.standard.set(symptomsArray[9].specialQuestions, forKey: "Seizure Questions")
        symptomsArray.append(Symptom(title: "Stroke", specialQuestions: ["Call EST & find AED", "Can they smile properly?", "Can they repeat a sentence after you?","What time did the stroke begin?", "Any history of strokes?","History of smoking?", "Any other information?"]))
         UserDefaults.standard.set(symptomsArray[10].specialQuestions, forKey: "Stroke Questions")
    }
    
}
