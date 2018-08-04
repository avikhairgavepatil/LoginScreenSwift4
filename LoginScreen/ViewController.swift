//
//  ViewController.swift
//  LoginScreen
//
//  Created by varun daga on 01/08/18.
//  Copyright © 2018 varun daga. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import UserNotifications

class ViewController: UIViewController,UITextFieldDelegate {
  var newString: NSString = ""
  var kayboardHight = 0.0
  var isUserNew:Bool = true
    
    @IBOutlet weak var LoginViewHightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var ForgotBtn: UIButton!
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            
            completionHandler(success)
        }
    }
    private func scheduleLocalNotification(fourdigitnum:String) {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        print("fourdigitnum",fourdigitnum)
        // Configure Notification Content
        notificationContent.title = "Your One time OTP is:\(fourdigitnum)"
        notificationContent.subtitle = "Local Notifications"
       // notificationContent.body = "In this tutorial, you learn how to schedule local notifications with the User Notifications framework."
        
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
        
         DispatchQueue.main.async
            {
                let ForgotVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgotVC") as! ForgotPasswordViewController;
                
                if(self.isUserNew)
                {
                     ForgotVC.otpFromNewUser = fourdigitnum
                    
                }
                else{
                    
                    ForgotVC.otpFromOlduser = fourdigitnum
                }
               
                self.navigationController?.pushViewController(ForgotVC, animated: true)
        }

    }
    

    
    @IBAction func ForgotBtnClick(_ sender: UIButton) {
        
        
        var fourDigitNumber: String {
            var result = ""
            repeat {
                // Create a string with a random number 0...9999
                result = String(format:"%04d", arc4random_uniform(10000) )
            } while Set<Character>(result.characters).count < 4
            return result
        }
        
        
       
        // Request Notification Settings
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization(completionHandler: { (success) in
                    guard success else { return }
                    
                    // Schedule Local Notification
                    self.scheduleLocalNotification(fourdigitnum: fourDigitNumber)
                })
            case .authorized:
                // Schedule Local Notification
                self.scheduleLocalNotification(fourdigitnum: fourDigitNumber)
            case .denied:
                print("Application Not Allowed to Display Notifications")
            }
        }
        print("FourDesigtNum",fourDigitNumber)
        
        
       
        
        //self.present(ForgotVC!, animated: true, completion: nil)
        
        
    }
    
    @IBOutlet weak var ForgotPasswordHightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var ArrowLabel: UILabel!
    
    @IBAction func PhoneClick(_ sender: UIButton) {
        //LoginBtn.backgroundColor = UIColor.lightGray
              LoginBtn.alpha = 0.4;
        isUserNew = true
        LoginViewHightConstraint.constant = 278
        EmailTextField.errorMessage = ""
        NumberTextField.errorMessage = ""
        FlagBottomView.backgroundColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0)
        FlagBottomViewHightConstraint.constant = 2.0
        PasswordTextFieldHightConstraint.constant =  0
        FlagViewTopConstraint.constant = -2
        PasswordTexField.isHidden = true
         ForgotBtn.isHidden = true
        EmailTextField.text = ""
        
        NumberTextField.becomeFirstResponder()
        FlagBottomView.isHidden = false
        FlagImage.isHidden = false
        countryCodeButton.isHidden = false
        ArrowLabel.isHidden = false
        PhoneBtn.layer.borderColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0).cgColor
        
        EmailBtn.layer.borderColor = UIColor.lightGray.cgColor
        EmailBtn.setTitleColor(UIColor.gray, for: UIControlState.normal)
        PhoneBtn.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0), for: UIControlState.normal)
        EmailTextField.isHidden = true
        NumberTextField.isHidden = false
       // PasswordTextFieldHightConstraint.constant = 0
        
        
    }
    
    
    @IBAction func EmailClick(_ sender: UIButton) {
        isUserNew = true
             LoginBtn.alpha = 0.4;
        //LoginBtn.backgroundColor = UIColor.lightGray
        //TopConstraintOfLoginView.constant = 156
          LoginViewHightConstraint.constant = 278
        PasswordTextFieldHightConstraint.constant =  0
        PasswordTexField.isHidden = true
        ForgotBtn.isHidden = true
        EmailTextField.becomeFirstResponder()
        NumberTextField.text = ""
        FlagBottomView.isHidden = true
        FlagImage.isHidden = true
        countryCodeButton.isHidden = true
        ArrowLabel.isHidden = true
        PhoneBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        EmailBtn.layer.borderColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0).cgColor
        EmailBtn.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0), for: UIControlState.normal)
        PhoneBtn.setTitleColor(UIColor.gray, for: UIControlState.normal)
        //EmailBtn.titleLabel?.textColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
       // PhoneBtn.titleLabel?.textColor = UIColor.gray
        EmailTextField.isHidden = false
        NumberTextField.isHidden = true
        PasswordTextFieldHightConstraint.constant = 0
        
    }
    
    @IBOutlet weak var EmailTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var PhoneBtn: UIButton!
    
    @IBOutlet weak var EmailBtn: UIButton!
    
    
    @IBOutlet weak var FlagImage: UIImageView!
    
    @IBOutlet weak var FlagViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var FlagBottomViewHightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var countryCodeButton: UIButton!
    
    @IBOutlet weak var FlagBottomView: UIView!
    
    let country = CountryManager.currentCountry
    var countryDilingCode = ""
    let contryPickerController = CountryPickerController()
    var countryDilingCodeFromReg = ""
    
    @IBOutlet weak var LoginViewBottomConstraint: NSLayoutConstraint!
    
@IBAction func selectCountryCode(_ sender: Any) {
        
    let countryController = CountryPickerController.presentController(on: self) { (country: Country) in
        self.FlagImage.image = country.flag
        self.countryCodeButton.setTitle(country.dialingCode(), for: .normal)
        self.countryDilingCode = (country.dialingCode())!  ;
        //            if(self.countryDilingCode != "+91")
        //            {
        //                self.mobilenumber = self.countryDilingCode +  self.NumberText.text!
        //               // self.NumberText.text = self.countryDilingCode
        //
        //            }
        //            else{
        //                self.mobilenumber =  self.NumberText.text!
        //
        //            }
        
    }
    countryController.detailColor = UIColor.red
        
    }
    @IBOutlet weak var NumberTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var PasswordTexField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var TopConstraintOfLoginView: NSLayoutConstraint!
    
    /*
    
    
     PasswordTexField.isHidden = false
     PasswordTexField.becomeFirstResponder()
     TopConstraintOfLoginView.constant =  100
     FlagBottomView.backgroundColor = UIColor.lightGray
     PasswordTextFieldHightConstraint.constant =  40
     FlagBottomViewHightConstraint.constant = 1
     FlagViewTopConstraint.constant = -1
     NumberTextField.isEnabled = false
     NumberTextField.isSelected = false
     countryCodeButton.isEnabled = false
    
    */
    
    
    @IBOutlet weak var LoginBtn: TransitionButton!
    
    
    @IBAction func LoginBtnClick(_ sender: TransitionButton) {
        
        
        if(!isUserNew)
        {
            
            
            PasswordTexField.becomeFirstResponder();
            self.view.endEditing(true)
            
            let num =   NumberTextField.text!;
            
            
            
            if( !EmailTextField.text!.isEmpty && !PasswordTexField.text!.isEmpty)
                
            {
                
                
                
                if(!isValidEmail(testStr: EmailTextField.text!))
                {
                    EmailTextField.errorMessage = "Invalid Email"
                    
                    // self.ErrorMassage.text = "Invalid Email"
                    
                }
                else{
                    
                    
                    // ContinueBtn.setTitle("Login", for: .normal)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    if !appDelegate.isInternetAvailable() {
                        /*var alert = UIAlertView(title: "Error!", message: "Please Check Your Internet Connection.", delegate: self as! UIAlertViewDelegate, cancelButtonTitle: "OK", otherButtonTitles: "")
                         alert.show()*/
                        let alert = UIAlertController(title: "Error!",
                                                      message: "Please Check Your Internet Connection.",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                        
                        
                        
                        
                    else{
                        self.LoginBtn.startAnimation()
                        self.login(email: EmailTextField.text!, Password: PasswordTexField.text!)
                    }
                    
                    
                    
                    
                    
                    
                    // NumberTextField.isEnabled = false
                    // NumberTextField.isSelected = false
                    // countryCodeButton.isEnabled = false
                    // self.CheackNumIsPresent()
                    
                }
                
                
                
                
                
            }
                
            else if( !NumberTextField.text!.isEmpty && !PasswordTexField.text!.isEmpty)
            {
                if(countryDilingCode == "+91")
                {
                    if(num.count < 10 ||  num.count > 10)
                    {
                        
                        
                    }else{
                        
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        if !appDelegate.isInternetAvailable() {
                            /*var alert = UIAlertView(title: "Error!", message: "Please Check Your Internet Connection.", delegate: self as! UIAlertViewDelegate, cancelButtonTitle: "OK", otherButtonTitles: "")
                             alert.show()*/
                            let alert = UIAlertController(title: "Error!",
                                                          message: "Please Check Your Internet Connection.",
                                                          preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else{
                        
                            self.LoginBtn.startAnimation()
                            self.login(email: NumberTextField.text!, Password: PasswordTexField.text!)
         
                        //NumberTextField.isEnabled = false
                        // NumberTextField.isSelected = false
                        // countryCodeButton.isEnabled = false
                        }
                    }
                    
                }
                else{
                    
                    if(num.count < 3 ||  num.count > 15)
                    {
                        
                        
                    }
                    else{
                        
                        // ContinueBtn.setTitle("Login", for: .normal)
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        if !appDelegate.isInternetAvailable() {
                            /*var alert = UIAlertView(title: "Error!", message: "Please Check Your Internet Connection.", delegate: self as! UIAlertViewDelegate, cancelButtonTitle: "OK", otherButtonTitles: "")
                             alert.show()*/
                            let alert = UIAlertController(title: "Error!",
                                                          message: "Please Check Your Internet Connection.",
                                                          preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else{
                            
                            self.LoginBtn.startAnimation()
                            self.login(email: countryDilingCode+NumberTextField.text!, Password: PasswordTexField.text!)
//                            PasswordTexField.isHidden = false
//                            PasswordTexField.becomeFirstResponder()
//                            ForgotBtn.isHidden = false
//                            ForgotPasswordHightConstraint.constant = 20
//                            LoginViewHightConstraint.constant = 278 + 40
//                            FlagBottomView.backgroundColor = UIColor.lightGray
//                            PasswordTextFieldHightConstraint.constant =  40
//                            FlagBottomViewHightConstraint.constant = 1
//                            FlagViewTopConstraint.constant = -1
//
                        }
                        
                        
                    }
                    
                }
                
            }
                
            else{
                
                
            }
            
            
            
            
            
            
            
        }
        else{
            
            PasswordTexField.becomeFirstResponder();
            self.view.endEditing(true)
           
            let num =   NumberTextField.text!;
            
            
            
            if( !EmailTextField.text!.isEmpty)
                
            {
                
                
                
                if(!isValidEmail(testStr: EmailTextField.text!))
                {
                    EmailTextField.errorMessage = "Invalid Email"
                    
                    // self.ErrorMassage.text = "Invalid Email"
                    
                }
                else{
                    
                    
                    // ContinueBtn.setTitle("Login", for: .normal)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    if !appDelegate.isInternetAvailable() {
                        /*var alert = UIAlertView(title: "Error!", message: "Please Check Your Internet Connection.", delegate: self as! UIAlertViewDelegate, cancelButtonTitle: "OK", otherButtonTitles: "")
                         alert.show()*/
                        let alert = UIAlertController(title: "Error!",
                                                      message: "Please Check Your Internet Connection.",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                        
                        
                        
                        
                    else{
                        self.LoginBtn.startAnimation()
                        CheackloginByEmail(email: EmailTextField.text!)
                    }
                    
                    
                    
                    
                    
                    
                    // NumberTextField.isEnabled = false
                    // NumberTextField.isSelected = false
                    // countryCodeButton.isEnabled = false
                    // self.CheackNumIsPresent()
                    
                }
                
                
                
                
                
            }
                
            else if( !NumberTextField.text!.isEmpty)
            {
                if(countryDilingCode == "+91")
                {
                    if(num.count < 10 ||  num.count > 10)
                    {
                        
                        
                    }else{
                        
                        self.LoginBtn.startAnimation()
                        CheackloginByEmail(email: NumberTextField.text!)
//                        PasswordTexField.isHidden = false
//                        PasswordTexField.becomeFirstResponder()
//                        ForgotBtn.isHidden = false
//                        ForgotPasswordHightConstraint.constant = 20
//                        //TopConstraintOfLoginView.constant =  100
//                        LoginViewHightConstraint.constant = 278 + 40
//                        FlagBottomView.backgroundColor = UIColor.lightGray
//                        PasswordTextFieldHightConstraint.constant =  40
//                        FlagBottomViewHightConstraint.constant = 1
//                        FlagViewTopConstraint.constant = -1
                        //NumberTextField.isEnabled = false
                        // NumberTextField.isSelected = false
                        // countryCodeButton.isEnabled = false
                    }
                    
                }
                else{
                    
                    if(num.count < 3 ||  num.count > 15)
                    {
                        
                        
                    }
                    else{
                        
                        // ContinueBtn.setTitle("Login", for: .normal)
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        if !appDelegate.isInternetAvailable() {
                            /*var alert = UIAlertView(title: "Error!", message: "Please Check Your Internet Connection.", delegate: self as! UIAlertViewDelegate, cancelButtonTitle: "OK", otherButtonTitles: "")
                             alert.show()*/
                            let alert = UIAlertController(title: "Error!",
                                                          message: "Please Check Your Internet Connection.",
                                                          preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else{
                            
                            
                            
                            self.LoginBtn.startAnimation()
                            CheackloginByEmail(email: countryDilingCode+NumberTextField.text!)
//                            PasswordTexField.isHidden = false
//                            PasswordTexField.becomeFirstResponder()
//                            ForgotBtn.isHidden = false
//                            ForgotPasswordHightConstraint.constant = 20
//                            LoginViewHightConstraint.constant = 278 + 40
//                            FlagBottomView.backgroundColor = UIColor.lightGray
//                            PasswordTextFieldHightConstraint.constant =  40
//                            FlagBottomViewHightConstraint.constant = 1
//                            FlagViewTopConstraint.constant = -1
                            
                        }
                        
                        
                    }
                    
                }
                
            }
                
            else{
                
                
            }
            
            
            
        }
        
       
        
        
    }
    
    @IBAction func sumit(_ sender: Any) {
       
        
        
    }
    
    
    func CheackloginByEmail(email:String)
    {
        
        
        var url  = "&"+"Mobile=\(email)"+"&Email=\(email)"
        let service = ApiService()
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        service.getDataWith(url:urlString! ){ (result) in
            switch result {
            case .Success(let data):
                
                self.isUserNew = false
                self.getUsrData(array:data)
                
                // 2: Then start the animation when the user tap the button
                let qualityOfServiceClass = DispatchQoS.QoSClass.background
                let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
                backgroundQueue.async(execute: {
                    
                    sleep(3) // 3: Do your networking task or background work here.
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        // 4: Stop the animation, here you have three options for the `animationStyle` property:
                        // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                        // .shake: when you want to reflect to the user that the task did not complete successfly
                        // .normal
                        
                        self.EmailTextField.errorMessage = ""
                        self.countryDilingCode =  ""
                        self.PasswordTexField.isHidden = false
                        self.ForgotBtn.isHidden = false
                        self.ForgotPasswordHightConstraint.constant = 20
                        self.PasswordTexField.becomeFirstResponder()
                        self.LoginViewHightConstraint.constant = 278 + 40
                        self.FlagBottomView.backgroundColor = UIColor.lightGray
                        self.PasswordTextFieldHightConstraint.constant =  40
                        self.FlagBottomViewHightConstraint.constant = 1
                        self.FlagViewTopConstraint.constant = -1
                        self.LoginBtn.stopAnimation(animationStyle: .shake, completion: {
                            
                            
                            
                            //let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")
                            //self.navigationController?.pushViewController(HomeVC!, animated: true)
                            //self.present(secondVC, animated: true, completion: nil)
                        })
                    })
                })
                
                
                
 
            case .Error( _):
                
//
//
//                self.LoginBtn.stopAnimation(animationStyle: .shake, completion: {
//
//
//
//                })
                DispatchQueue.main.async {
                    self.LoginBtn.stopAnimation()
                    self.isUserNew = true
                    var fourDigitNumber: String {
                        var result = ""
                        repeat {
                            // Create a string with a random number 0...9999
                            result = String(format:"%04d", arc4random_uniform(10000) )
                        } while Set<Character>(result.characters).count < 4
                        return result
                    }
                    //let otp = self.createOtp
                    // Request Notification Settings
                    UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
                        switch notificationSettings.authorizationStatus {
                        case .notDetermined:
                            self.requestAuthorization(completionHandler: { (success) in
                                guard success else { return }
                                
                                // Schedule Local Notification
                                self.scheduleLocalNotification(fourdigitnum: fourDigitNumber)
                            })
                        case .authorized:
                            // Schedule Local Notification
                            self.scheduleLocalNotification(fourdigitnum: fourDigitNumber)
                        case .denied:
                            print("Application Not Allowed to Display Notifications")
                        }
                    }
//                    
//                    let ForgotVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgotVC") as! ForgotPasswordViewController;
//                    ForgotVC.otpFromNewUser = fourDigitNumber
//                    self.navigationController?.pushViewController(ForgotVC, animated: true)
                    

                }
                
                
                
                //self.sendsms()
                
            }
            
            
            
            
        }
        
    
    
        
        
    }
    
    
    
    func login(email:String,Password:String)
    {
        var UrlApi = ""+"&Mobile=\(email)"+"&Email=\(email)"+"&Authonitication=\(Password)"
        let service = ApiService()
        
        let urlString = UrlApi.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        service.getDataWith(url:urlString! ){ (result) in
            switch result {
                
            case .Success(let data):
                
                
                DispatchQueue.main.async {
                    self.LoginBtn.stopAnimation()
                    var HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")
                    self.navigationController?.pushViewController(HomeVC!, animated: true)
          
                }
          
               
                
            case .Error( _):
                DispatchQueue.main.async{
                    
                    self.LoginBtn.stopAnimation(animationStyle: .shake, completion: {
                        let alert = UIAlertController(title: "Error!",
                                                      message: "Invalid Password",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    })
                   
                    
                   
                }
                
                
            }
            
            
        }
        
        
        
        
    }
    func getUsrData(array: [[String: AnyObject]])
    {
        
        
        
        
        
        
        for i in 0  ..< array.count
        {
            
            var tempEmail = array[i]["Email"] as! String
            var tempNumber = array[i]["Mobile"] as! String
            var cheack = ""
            var tempCid = String(array[i]["CID"] as! Int);
            if(array[i]["singUp"]! .isEqual(NSNull()) )
            {
                cheack = ""
                
                
                
            }
            else{
                
                cheack = array[i]["singUp"] as! String;
                
                // UserDefaults.standard.set(self.CIDNUM, forKey: "cid")
                
            }
            
            //self.ErrorMassage.text = ""
            
            
        }
        
        
        
    }
    
    
    @IBOutlet weak var PasswordTextFieldHightConstraint: NSLayoutConstraint!
    
    
   // @IBOutlet weak var SubmitBtn: UIButton!
    
    
    @IBOutlet weak var LoginView: UIView!
    

    
  //  @IBOutlet weak var LoginViewHightConstraint: NSLayoutConstraint!
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                
                

                
                let d = notification.userInfo!
                var r = (d[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                r = self.LoginView.convert(r, from:nil)
                
                UIView.animate(withDuration: 1, animations: {
                    
                    self.LoginViewBottomConstraint.constant = r.size.height - 40
                    
                    //self.TopConstraintOfLoginView.constant = 156
                   
                })
                //kayboardHight = Double(keyboardSize.height)
               // LoginView.frame.origin.y = keyboardSize.height
               // LoginViewBottomConstraint.constant = keyboardSize.height
                print("KayboardHight ==",keyboardSize.height)
                print("KayboardHight ==",r.size.height)
                //self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
               // self.TopConstraintOfLoginView.constant += keyboardSize.height
            }
        }
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.NumberTextField.inputAccessoryView = doneToolbar
        
    }
    func createOtp() -> String
    {
        
        var fourDigitNumber: String {
            var result = ""
            repeat {
                // Create a string with a random number 0...9999
                result = String(format:"%04d", arc4random_uniform(10000) )
            } while Set<Character>(result.characters).count < 4
            return result
        }
        
        return fourDigitNumber
        //otp = fourDigitNumber
    }
     @objc func doneButtonAction()
    {
       // self.NumberTextField.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in })
          UNUserNotificationCenter.current().delegate = self
        
        //
        self.addDoneButtonOnKeyboard()
        
        //
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        
        
        
        
        //TopConstraintOfLoginView.constant = 156
        
        
        PhoneBtn.setTitle("\u{f095}", for: .normal)
        EmailBtn.setTitle("\u{f0e0}", for: .normal)
        //PhoneBtn.layer.cornerRadius = 5.0
        //EmailBtn.layer.cornerRadius = 5.0
        //PhoneBtn.layer.borderWidth = 1.0
        //EmailBtn.layer.borderWidth = 1.0
        PhoneBtn.layer.borderColor = UIColor.lightGray.cgColor
        EmailBtn.layer.borderColor = UIColor.lightGray.cgColor
       // PhoneBtn.titleLabel?.text = "\u{f095}"
        //EmailBtn.titleLabel?.text = "\u{f0e0}"
        countryCodeButton.setTitle("+91", for: .normal)
        countryDilingCode = "+91"
        //FlagImage.image = country?.flag
        FlagImage.image = UIImage(named: "IN.png")
        countryCodeButton.clipsToBounds = true
        
         FlagBottomView.backgroundColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0)
        
        
        
        
        
        LoginBtn.isEnabled = false
        //SubmitBtn.backgroundColor = UIColor.black
        NumberTextField.becomeFirstResponder()
        //EmailTextField.becomeFirstResponder()
        PasswordTexField.isHidden = true
        NumberTextField.placeholder = "Mobile Number"
        NumberTextField.title = "Mobile Number"
        NumberTextField.delegate = self
        PasswordTexField.placeholder = "Enter Password"
        PasswordTexField.title = "Password"
        
        EmailTextField.delegate = self
        EmailTextField.placeholder = "Enter emailid"
        EmailTextField.title = "EMAIL"
        
        
        
        
        
        NumberTextField.selectedTitleColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        NumberTextField.selectedLineColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        
        PasswordTexField.selectedTitleColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        PasswordTexField.selectedLineColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        
        EmailTextField.selectedTitleColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        EmailTextField.selectedLineColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        
//        TextField.placeholder = "Company ID"
//        TextField.placeholderLabel.highlightedTextColor = UIColor.black
//        TextField.placeholderLabel.textColor = UIColor.white
//        TextField.underline?.color = UIColor.white
       // TextField.delegate = self
       // TextField.setMarkedText("Avi", selectedRange: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
       // self.LoginBtn.stopAnimation()
        LoginBtn.layer.cornerRadius = 5.0
        LoginBtn.alpha = 0.4
        
        PasswordTexField.becomeFirstResponder()
        let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
        LoginBtn.spinnerColor = .white
      /*  LoginView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.view.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.LoginView.frame*/
        animateView()
        
    }
    func animateView() {
        LoginView.alpha = 0;
        self.LoginView.frame.origin.y = self.LoginView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.LoginView.alpha = 1.0;
            self.LoginView.frame.origin.y = self.LoginView.frame.origin.y - 50
        })
    }

    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func textFieldDidBeginEditing(TxtBoxPsgVar: UITextField)
    {
        self.NumberTextField = TxtBoxPsgVar as! SkyFloatingLabelTextField
    }
    
    func textFieldDidEndEditing(TxtBoxPsgVar: UITextField)
    {
        self.NumberTextField = nil
        LoginBtn.isEnabled = false
    }
    
    func textFieldShouldReturn(TxtBoxPsgVar: UITextField) -> Bool
    {
        self.NumberTextField.resignFirstResponder()
        return true
    }


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if  textField == NumberTextField
        {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            if(countryDilingCode == "+91")
            {
                
                let maxLength = 10
                let currentString: NSString = textField.text! as NSString
                newString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                
                if(newString.length<maxLength)
                {
                    NumberTextField.errorMessage = "Invalid Number"
                     LoginBtn.isEnabled = false
                        LoginBtn.alpha = 0.4
                    FlagBottomView.backgroundColor = UIColor.red
                }
                    
                    
                    
                else{
                         LoginBtn.alpha = 1.0
                    NumberTextField.errorMessage = ""
                      LoginBtn.isEnabled = true
                    //LoginBtn.backgroundColor = UIColor.black
                    FlagBottomView.backgroundColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0)
                }
                if(newString.length==0)
                {
                      LoginBtn.isEnabled = false
                          LoginBtn.alpha = 0.4;
                    NumberTextField.errorMessage = ""
                    FlagBottomView.backgroundColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0)
                }
                return newString.length <= maxLength
                // return allowedCharacters.isSuperset(of: characterSet)
                
            }
            else{
                let maxLength = 15
                let currentString: NSString = textField.text! as NSString
                newString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                
                if(newString.length<8)
                {
                    LoginBtn.isEnabled = false
                    LoginBtn.alpha = 0.4
                    NumberTextField.errorMessage = "Invalid Number"
                    FlagBottomView.backgroundColor = UIColor.red
                }
                    
                    
                    
                else{
                         LoginBtn.alpha = 1.0
                      LoginBtn.isEnabled = true
                    //LoginBtn.backgroundColor = UIColor.black
                    FlagBottomView.backgroundColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0)
                    NumberTextField.errorMessage = ""
                }
                if(newString.length==0)
                {
                      LoginBtn.isEnabled = false
                        LoginBtn.alpha = 0.4
                    NumberTextField.errorMessage = ""
                    FlagBottomView.backgroundColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0)
                    
                }
                return newString.length <= maxLength
                 //return allowedCharacters.isSuperset(of: characterSet)
                
                
            }
            
            
        }
        if textField == EmailTextField
        {
            
            if let text = EmailTextField.text {
                if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
                    if(!isValidEmail(testStr: text)) {
                        
                         EmailTextField.errorMessage = "Invalid email"
                         LoginBtn.isEnabled = false
                    }
                    else {
                        // The error message will only disappear when we reset it to nil or empty string
                        LoginBtn.isEnabled = true
                        LoginBtn.backgroundColor = UIColor.black
                        EmailTextField.errorMessage = ""
                    }
                    if(text.count==0)
                    {
                        
                        EmailTextField.errorMessage = ""
                        LoginBtn.isEnabled = false
                        
                    }
                }
            }
            return true
            
            
        }
        return true
        
        
        
    }

}
extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
}
