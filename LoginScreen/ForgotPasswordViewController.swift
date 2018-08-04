//
//  ForgotPasswordViewController.swift
//  LoginScreen
//
//  Created by varun daga on 02/08/18.
//  Copyright © 2018 varun daga. All rights reserved.
//

import UIKit
import UserNotifications

class ForgotPasswordViewController: UIViewController,UNUserNotificationCenterDelegate {

    var otpFromOlduser = ""
    var otpFromNewUser = ""
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBOutlet weak var VerifyBtn: UIButton!
    
    @IBAction func VerifyBtnClick(_ sender: UIButton) {
        
        let enterOtp = first.text! + second.text! + third.text! + fourth.text!
        
         print("Enter Otp",enterOtp)
         print("otpFromNewUser Otp",otpFromNewUser)
          print("otpFromOlduser Otp",otpFromOlduser)
        if(otpFromNewUser == enterOtp)
        {
            let SignUpNewVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpNewVC")
            self.navigationController?.pushViewController(SignUpNewVC!, animated: true)
            
        }
        else if(otpFromOlduser == enterOtp)
        {
            
            let ChangPassVC = self.storyboard?.instantiateViewController(withIdentifier: "ChgPassVC")
            self.navigationController?.pushViewController(ChangPassVC!, animated: true)
            
            
        }
        else{
            
            let alert = UIAlertController(title: "Error!",
                                          message: "Invalid OTP.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }

        
        
    }
    
    
    
    @IBOutlet weak var first: SkyFloatingLabelTextField!
    
    @IBOutlet weak var second: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var third: SkyFloatingLabelTextField!
    
    
    
    @IBOutlet weak var fourth: SkyFloatingLabelTextField!
    
    
    private func configureUserNotificationsCenter() {
        // Configure User Notification Center
        UNUserNotificationCenter.current().delegate = self
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

            let userInfo : [AnyHashable: Any] = response.notification.request.content.userInfo
            
            
        
            
            print(userInfo)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     configureUserNotificationsCenter()
        
        VerifyBtn.layer.cornerRadius = 5.0
        //--- add UIToolBar on keyboard and Done button on UIToolBar ---//
        //self.addDoneButtonOnKeyboard()
         VerifyBtn.isEnabled = false
        VerifyBtn.backgroundColor = UIColor.lightGray
         first.delegate = self
         second.delegate = self
         third.delegate = self
         fourth.delegate = self
         first.textAlignment = .center
         second.textAlignment = .center
         third.textAlignment = .center
         fourth.textAlignment = .center
        first.selectedLineColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        second.selectedLineColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        
        third.selectedLineColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        
        fourth.selectedLineColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        
        
         first.becomeFirstResponder()
         first.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        second.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        third.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        fourth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
   
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case first:
                second.becomeFirstResponder()
            case second:
                third.becomeFirstResponder()
            case third:
                fourth.becomeFirstResponder()
            case fourth:
                fourth.resignFirstResponder()
                VerifyBtn.isEnabled = true
                VerifyBtn.backgroundColor = UIColor.black
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case first:
                first.becomeFirstResponder()
                VerifyBtn.isEnabled = false
                VerifyBtn.backgroundColor = UIColor.lightGray
            case second:
                first.becomeFirstResponder()
                VerifyBtn.isEnabled = false
                VerifyBtn.backgroundColor = UIColor.lightGray
            case third:
                second.becomeFirstResponder()
                VerifyBtn.isEnabled = false
                VerifyBtn.backgroundColor = UIColor.lightGray
            case fourth:
                third.becomeFirstResponder()
                VerifyBtn.isEnabled = false
                VerifyBtn.backgroundColor = UIColor.lightGray
            default:
                break
            }
        }
        else{
            
            //VerifyBtn.isEnabled = false
            //VerifyBtn.backgroundColor = UIColor.lightGray
            
        }
    }


}
extension ForgotPasswordViewController: UITextFieldDelegate{
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        VerifyBtn.isEnabled = false
        VerifyBtn.backgroundColor = UIColor.lightGray
        textField.text = ""
        
    }
}
