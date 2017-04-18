//
//  ExpandedTextField.swift
//  JSONandObserver - iOS
//
//  Created by Lukasz Matuszczak on 31/01/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import UIKit

extension UITextField{
    
    func textFieldDesign(color: UIColor){
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0.0,y: self.frame.size.height - 1,width: self.frame.size.width,height: 1.0);
        bottomBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(bottomBorder)
    }
}


class ExpandedTextField: UIView, UITextFieldDelegate {
    var superOwner:Subject?
    var textField:UITextField?
    var infoLabel:UILabel?
    
    
    var errorLabel = { () -> UILabel in  let t = UILabel(frame: CGRect(x: 0, y: 35, width: 100, height:40 ))
        
        t.text = "NOT VALID"
        t.textColor = UIColor.red
        t.font = UIFont.systemFont(ofSize: 15)
        t.isHidden = true
        
        return t
    }()
    
    
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.textField = UITextField(frame: CGRect(x: 10, y: 20, width: frame.width-20, height: 40))
        self.textField?.textFieldDesign(color: UIColor.purple)
        self.textField?.delegate = self
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        
        self.infoLabel = UILabel(frame: CGRect(x: 0, y: 5, width: frame.width-5, height:30 ))
        self.infoLabel?.font = UIFont.systemFont(ofSize: 18)
        self.infoLabel?.text = title
        self.infoLabel?.textColor = UIColor.purple
       
        self.textField?.addSubview(self.errorLabel)
        self.textField?.addSubview(self.infoLabel!)
        self.addSubview(self.textField!)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //////////////////////////////////
    //MARK: textField delegate methods
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            self.labelStandardDesign()
        }
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = ((textField.text as NSString?)?.replacingCharacters(in: range, with: string))!
        if currentText.characters.count < 10{
            self.validText(text: currentText, valid: isValidNumber)
        
            if currentText.characters.count == 1 {
                self.labelEditedDesign()
            }
            if currentText.characters.count == 0 {
                self.labelStandardDesign()
                self.errorLabel.isHidden = true
                self.textField?.textFieldDesign(color: UIColor.purple)
                self.textField?.textColor = UIColor.black
            }
        }
        else {
            return false
        }
        return true
    }
    
    ////////////////////////////////////
    //MARK: additional methods for design
    func labelStandardDesign() {
        UIView.animate(withDuration: 0.4, animations: {
            self.infoLabel?.font = UIFont.systemFont(ofSize: 18)
            self.infoLabel?.frame = CGRect(x: 0, y: 5, width: (self.infoLabel?.frame.width)!, height:30 )
        })
    }
    func labelEditedDesign() {
        UIView.animate(withDuration: 0.4, animations: {
            self.infoLabel?.font = UIFont.systemFont(ofSize: 12)
            self.infoLabel?.frame = CGRect(x: 0, y: -20, width: (self.infoLabel?.frame.width)!, height: 30)
        })
    }
    
    //////////////////////////
    //MARK: validation methods
    func validText(text: String, valid: (String)->Bool) {
        
        if !valid(text) {
            
            self.errorLabel.isHidden = false
            self.textField?.textFieldDesign(color: UIColor.red)
            self.textField?.textColor = UIColor.red
        }
        else{
            self.errorLabel.isHidden = true
            self.textField?.textFieldDesign(color: UIColor.purple)
            self.textField?.textColor = UIColor.black
            self.superOwner?.updateInObserver(message: Int(text)!)
        }
    }
    
    
    func isValidNumber(testStr:String) -> Bool{
        let regex = "^(?:[1-9]\\d*|0)$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let result =  phoneTest.evaluate(with: testStr)
        return result
    }



}
