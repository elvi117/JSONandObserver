//
//  SubjectViewController.swift
//  JSONandObserver - iOS
//
//  Created by Lukasz Matuszczak on 31/01/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import UIKit

class SubjectViewController: UIViewController, Subject {

    var observerObject:Observer?
    
    var nameTextField = ExpandedTextField(frame: CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width-40, height: 90), title: "What is your favourive number ?")
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(nameTextField)
        self.nameTextField.superOwner = self
        
        
        //Gesture to hide keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forceHideKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func forceHideKeyboard(_ sender: UITapGestureRecognizer) {
        self.nameTextField.textField?.resignFirstResponder()

    }
    
    func registerObserver(o: Observer) {
        self.observerObject = o
    }
    
    func updateInObserver(message: Int){
        if self.observerObject != nil{
            self.observerObject?.getMessage(message: message)
        }
    }
}
