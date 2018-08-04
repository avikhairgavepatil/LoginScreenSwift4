//
//  SignUpViewController.swift
//  LoginScreen
//
//  Created by varun daga on 03/08/18.
//  Copyright © 2018 varun daga. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var Number: SkyFloatingLabelTextField!
    
    @IBOutlet weak var Name: SkyFloatingLabelTextField!
    
    @IBOutlet weak var EmailAddress: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var Password: SkyFloatingLabelTextField!
    
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
//        Number.delegate = self
//        EmailAddress.delegate = self
//        Name.delegate = self
//        Password.delegate = self

       
    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        if(textField == Number)
//        {
//           moveTextField(Number, moveDistance: -100, up: true)
//        }
//        else if(textField == Name)
//        {
//            moveTextField(Name, moveDistance: -100, up: true)
//        }
//        else if(textField == EmailAddress){
//           moveTextField(EmailAddress, moveDistance: -100, up: true)
//        }
//        else{
//            moveTextField(Password, moveDistance: -100, up: true)
//        }
//
//    }
//
//    // Finish Editing The Text Field
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//        if(textField == Number)
//        {
//            moveTextField(Number, moveDistance: -100, up: false)
//        }
//        else if(textField == Name)
//        {
//            moveTextField(Name, moveDistance: -100, up: false)
//        }
//        else if(textField == EmailAddress){
//            moveTextField(EmailAddress, moveDistance: -100, up: false)
//        }
//        else{
//            moveTextField(Password, moveDistance: -100, up: false)
//        }
//        //moveTextField(textField, moveDistance: 30, up: false)
//    }
//    
//    // Hide the keyboard when the return key pressed
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//
//    // Move the text field in a pretty animation!
//    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
//        let moveDuration = 0.3
//        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
//
//        UIView.beginAnimations("animateTextField", context: nil)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        UIView.setAnimationDuration(moveDuration)
//        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
//        UIView.commitAnimations()
//    }

}
