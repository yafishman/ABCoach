
//  ViewController.swift
//  InfoTab
//
//  Created by Sam Adelson on 11/24/18.
//  Copyright © 2018 Sam Adelson. All rights reserved.
//

import UIKit

class ListController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var tabs: [String] = ["EST","SARAH","Uncle Joe's","RSVP Center","Center for Inclusion and Diversity","Habif"]
    
    var pics: [UIImage] = [UIImage(named: "EST")!,UIImage(named: "SARAH")!,UIImage(named: "Uncle Joes")!,UIImage(named: "RSVP")!,UIImage(named: "diversity-1")!,UIImage(named: "Habif")!]
    
    var numbers: [String] = ["314-935-5555","314-935-8080","314-935-5099","314-935-8080","314-935-7535","314-935-6666"]
    
    var websites: [String] = ["http://est.wustl.edu/","http://sarah.wustl.edu/","https://unclejoe.wustl.edu/","https://rsvpcenter.wustl.edu/","https://diversityinclusion.wustl.edu/","https://shs.wustl.edu/Pages/default.aspx"]
    
    
    var est : String = "The Washington University Emergency Support Team is a student-run volunteer first responder emergency medical service for the Danforth campus, active 24 hours a day, 7 days a week during the fall and spring semesters."
    
    var sarah : String = "We are a student-run helpline that serves the Washington University in St. Louis community. \n We offer counseling on topics including, but certainly not limited to, feelings, sexual assault, sexual harassment, intimate partner and sexual violence, relationships, mental and sexual health. \n \n S.A.R.A.H. is a confidential resource, and is available to members of the Wash U community 24 hours a day, 7 days a week (excluding winter and summer break)."
    
    var uncle : String = "Highly Trained Peer-Counselors: All of our Uncle Joe’s counselors have undergone 100+ hours of intense training on an extensive range of issues that members of our community may be facing. Undergraduate students of Washington University in St. Louis are welcome to stop by during our office hours or call at any time to talk about any problems or concerns they are dealing with. \n \n Confidential: Members of Uncle Joe’s will not disclose any information about a client’s identity or situation. However, in circumstances where an individual is in immediate and severe danger, confidentiality is not maintained. \n \n Equipped with Resources: As both a counseling and resource center, we are not only knowledgable about available resources on and off campus for appropriate issues, but we also have an abundant supply of resource materials, pamphlets, and brochures in our office that cover a wide range of issues college students and others commonly face. Further, if a client wants ongoing or additional help, we have referrals to over 100 different organizations on campus and in the St. Louis area. \n \n Student-Run and Staffed: All of our counselors are Washington University students who have volunteered their time and energy to serve our community."
    
    var rsvp : String = "The RSVP Center is a community health resource committed to prevention education, as well as response, support and empowerment for victims of relationship and sexual violence. \n \n 24-hour services are available for individuals in immediate need of assistance, such as hospital care, reporting an assault to police or emergency housing accommodations."
    
    var diversity = "The Center of Diversity and Inclusion supports and advocates for undergraduate, graduate, and professional students from underrepresented and/or marginalized populations, creates collaborative partnerships with campus and community partners, and promotes dialogue and social change among all students. Our work enhances and strengthens Washington University’s commitment to diversity and inclusion."
    
    var habif = "Our Mission: \n \n We support the education and development of our students by promoting their health and well-being through the highest quality comprehensive care, provided with compassion and integrity. \n \n We offer a range of services from medical checkups and mental health services to wellness support and health education. \n \n We are here to support you and help you thrive during your time at WashU."
    
    var infos : [String] = []
    
    @IBOutlet weak var tabview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = tabs[indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont(name: "Avenir",size: 20)
        cell.textLabel?.textAlignment = .right
        cell.imageView?.image = pics[indexPath.row]
        cell.imageView?.layer.cornerRadius = 15
        cell.imageView?.clipsToBounds = true
        cell.backgroundColor = view.backgroundColor
        cell.textLabel?.textColor = UIColor.white
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 7
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabview.delegate = self
        tabview.dataSource = self
        infos = [est,sarah,uncle,rsvp,diversity,habif]
        tabview.backgroundColor = view.backgroundColor
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = tabview.indexPathForSelectedRow!.row
        let newDest = segue.destination as! InfoController
        newDest.name = tabs[cell]
        newDest.image = pics[cell]
        newDest.text = infos[cell]
        newDest.number = numbers[cell]
        newDest.website = websites[cell]
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){ //https://stackoverflow.com/questions/29974864/how-to-access-segue-in-didselectrowatindexpath-swift-ios
    
        self.performSegue(withIdentifier: "detailedcell", sender: tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}

