//
//  NotesField.swift
//  FinalProject2
//
//  Created by Alan Makedon on 11/27/18.
//  Copyright © 2018 Alan Makedon. All rights reserved.
//

import UIKit

class NotesField: UITextField, UITextFieldDelegate {
    var title: String?
    var body: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.body = self.text
    }

    
}
