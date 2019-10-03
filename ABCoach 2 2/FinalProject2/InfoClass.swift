//
//  InfoController.swift
//  InfoTab
//
//  Created by Sam Adelson on 11/24/18.
//  Copyright © 2018 Sam Adelson. All rights reserved.
//

import UIKit



class InfoController: UIViewController {
    
    
    var image : UIImage!
    var text : String!
    var display: UIImageView!
    var displayText: UITextView!
    var name: String!
    var number: String!
    var website: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = name
        let scrollfr = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let scroll = UIScrollView(frame: scrollfr)
        view.addSubview(scroll)
        let frame = CGRect(x: view.frame.midX - image.size.width/2, y: 40, width: image.size.width, height: image.size.height)
        display = UIImageView(frame: frame)
        display.image = image
        let frame2 = CGRect(x: 40, y: frame.height + 80, width: view.frame.width-80, height: 0)
        displayText = UITextView(frame: frame2)
        displayText.text = text
        //https://stackoverflow.com/questions/38714272/how-to-make-uitextview-height-dynamic-according-to-text-length
        var fr = displayText.frame
        if (name == "Habif"){
            fr.size.height = displayText.contentSize.height*3.5
        }
        else {
            fr.size.height = displayText.contentSize.height*3
        }
        print(fr.size.height)
        displayText.frame.size.height = fr.height
        displayText.font = UIFont(name: (displayText.font?.fontName)!,size: 20)
        displayText.isScrollEnabled = false
        displayText.textAlignment = .center
        //view.addSubview(displayText)
        let frame3 = CGRect(x: view.frame.width - 190, y: display.frame.height + displayText.frame.height + 100, width: 150, height: 20)
        let phone = UIButton(frame: frame3)
        phone.setTitle(number, for: .normal)
        phone.setTitleColor(UIColor.blue, for: .normal)
        phone.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        //view.addSubview(phone)
        let frame4 = CGRect(x: 40, y: display.frame.height + displayText.frame.height + 100, width: 80, height: 20)
        let web = UIButton(frame: frame4)
        web.setTitle("website", for: .normal)
        web.setTitleColor(UIColor.blue, for: .normal)
        web.addTarget(self, action: #selector(buttonAction2),for: .touchUpInside)
        //var scrfr = scroll.frame
        //scrfr.size.height = 1000//frame.height + displayText.frame.height + phone.frame.height + view.frame.height
        //scroll.frame = scrfr
        scroll.addSubview(display)
        scroll.addSubview(displayText)
        scroll.addSubview(phone)
        scroll.addSubview(web)
        scroll.contentSize = CGSize(width: view.frame.width, height: frame.height + displayText.frame.height + phone.frame.height + 200)
        //scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        //scroll.isScrollEnabled = true
        //view.addSubview(web)
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonAction(sender: UIButton!) { //https://stackoverflow.com/questions/27259824/calling-a-phone-number-in-swift
        print("Button tapped")
        let phoneNumber = number.replacingOccurrences(of: "-", with: "")
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func buttonAction2(sender: UIButton!) {
        print("Button 2 tapped")
        UIApplication.shared.openURL(NSURL(string: website)! as URL) //https://stackoverflow.com/questions/28010518/swift-open-web-page-in-app-button-doesnt-react
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
