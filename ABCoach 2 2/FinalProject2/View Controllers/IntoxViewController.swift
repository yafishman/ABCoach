//
//  IntoxViewController.swift
//  FinalProject2
//
//  Created by Alan Makedon on 11/20/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import UIKit

class IntoxViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
 
    @IBOutlet weak var intoxTableView: UITableView!
    let stepsArray: [String] = ["Call EST", "Have they hit their head?", "Demographics", "What did their night look like?"]
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let thisColor = view.backgroundColor
        intoxTableView.backgroundView?.backgroundColor = thisColor
        intoxTableView.dataSource = self
        intoxTableView.delegate = self
        myCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //maybe make this an enum
        print("pressed")
        navigationController?.pushViewController(DetailedViewController(), animated: true)
      

    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            intoxTableView.rowHeight = 90
            cell.textLabel?.text = stepsArray[indexPath.row]
            let thisColor = view.backgroundColor
            cell.backgroundColor = thisColor
            cell.textLabel?.font = UIFont(name: "DIN Condensed", size: 25)
            cell.textLabel?.textColor = UIColor.white
            return cell
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    let spot =  intoxTableView.indexPathsForSelectedItems![0].row
        //let spot = intoxTableView.indexPathForSelectedRow![0]
        print("time to segue")
       
    
    }
        
    
}
