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
        //scroll view
        let scrollfr = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let scroll = UIScrollView(frame: scrollfr)
        view.addSubview(scroll)
        
        //image view
        let frame = CGRect(x: view.frame.midX - image.size.width/2, y: 40, width: image.size.width, height: image.size.height)
        display = UIImageView(frame: frame)
        display.image = image
        display.layer.cornerRadius = display.frame.width/8
        display.clipsToBounds = true
        
        //phone button
        let frame3 = CGRect(x: view.frame.width - 190, y: display.frame.height  /*displayText.frame.height*/ + 80, width: 150, height: 30)
        let phone = UIButton(frame: frame3)
        phone.setTitle(number, for: .normal)
        phone.setTitleColor(UIColor.white, for: .normal)
        phone.setTitleColor(UIColor.lightGray, for: .highlighted)
        phone.titleLabel?.font = UIFont(name: "Avenir",size: 20)
        phone.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        //web button
        let frame4 = CGRect(x: 40, y: display.frame.height  /*displayText.frame.height*/ + 80, width: 80, height: 30)
        let web = UIButton(frame: frame4)
        web.setTitle("Website", for: .normal)
        web.setTitleColor(UIColor.white, for: .normal)
        web.titleLabel?.font = UIFont(name: "Avenir",size: 20)
        web.addTarget(self, action: #selector(buttonAction2),for: .touchUpInside)
        
        //info text
        let frame2 = CGRect(x: 40, y: frame.height + frame4.height + 100, width: view.frame.width-80, height: 0)
        displayText = UITextView(frame: frame2)
        displayText.text = text
        //https://stackoverflow.com/questions/38714272/how-to-make-uitextview-height-dynamic-according-to-text-length
        var fr = displayText.frame
        fr.size.height = displayText.contentSize.height*3.5
        displayText.frame.size.height = fr.height
        displayText.font = UIFont(name: "Avenir",size: 20)
        displayText.isScrollEnabled = false
        displayText.textAlignment = .center
        
        //add all views to scroll view
        scroll.addSubview(display)
        scroll.addSubview(displayText)
        scroll.addSubview(phone)
        scroll.addSubview(web)
        scroll.contentSize = CGSize(width: view.frame.width, height: frame.height + displayText.frame.height + phone.frame.height + 200)
        displayText.backgroundColor = view.backgroundColor
        displayText.textColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonAction(sender: UIButton!) { //https://stackoverflow.com/questions/27259824/calling-a-phone-number-in-swift
        //https://stackoverflow.com/questions/45728819/how-to-add-message-phone-call-alert-popupl
        let phoneNumber = number.replacingOccurrences(of: "-", with: "")
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                let alert = UIAlertController(title: "Call " + name, message: "Press OK to call " + name, preferredStyle: .alert)
                let callAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    //application.openURL(phoneCallURL) 
                    application.open(phoneCallURL)
                })
                let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
                })
                alert.addAction(callAction)
                alert.addAction(noAction)
                self.present(alert, animated: true, completion: nil)
            } else{
              
            }
        }
    }
    
    
    @objc func buttonAction2(sender: UIButton!) {
        UIApplication.shared.openURL(NSURL(string: website)! as URL) //https://stackoverflow.com/questions/28010518/swift-open-web-page-in-app-button-doesnt-react
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
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
