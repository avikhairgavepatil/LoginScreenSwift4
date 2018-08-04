//
//  SignUpNewViewController.swift
//  LoginScreen
//
//  Created by varun daga on 03/08/18.
//  Copyright © 2018 varun daga. All rights reserved.
//

import UIKit

class SignUpNewViewController: UIViewController {
    
    @IBAction func BackVC(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var SignUpBtn: UIButton!
    
    @IBAction func SignUpBtnClick(_ sender: UIButton) {
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var NumberTx: SkyFloatingLabelTextField!
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var NameTx: SkyFloatingLabelTextField!
    
    @IBOutlet weak var EmailTx: SkyFloatingLabelTextField!
    
    @IBOutlet weak var PasswordTx: SkyFloatingLabelTextField!
    
    @IBOutlet weak var NumberRightLbl: UITextField!
    
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SignUpBtn.layer.cornerRadius = 5.0

        // Set textfield delegate
        NumberTx.delegate = self
        NameTx.delegate = self
        EmailTx.delegate = self
        PasswordTx.delegate = self
        
        NumberRightLbl.text = "\u{e66c}"
        NumberTx.placeholder = "ENTER PHONE NUMBER"
        NumberTx.title = "PHONE NUMBER"
        NumberTx.selectedTitleColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        NumberTx.selectedLineColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        
        
        
        
        //NameTx.text = "\u{e66c}"
        NameTx.placeholder = "ENTER NAME"
        NameTx.title = "NAME"
        NameTx.selectedTitleColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        NameTx.selectedLineColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        
        
        EmailTx.placeholder = "ENTER EMAIL"
        EmailTx.title = "EMAIL"
        EmailTx.selectedTitleColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        EmailTx.selectedLineColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        
        
        PasswordTx.placeholder = "ENTER PASSWORD"
        PasswordTx.title = "PASSWORD"
        PasswordTx.selectedTitleColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        PasswordTx.selectedLineColor = UIColor(red: 0/255, green: 98/255, blue: 193/255, alpha: 1.0);
        
        // Observe keyboard change
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Add touch gesture for contentView
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnTextView(gesture:))))
    }

    @objc func returnTextView(gesture: UIGestureRecognizer) {
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
    }
}

// MARK: UITextFieldDelegate
extension SignUpNewViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
}

// MARK: Keyboard Handling
extension SignUpNewViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardHeight != nil {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            // so increase contentView's height by keyboard height
            UIView.animate(withDuration: 0.3, animations: {
                self.constraintContentHeight.constant += self.keyboardHeight
            })
            
            // move if keyboard hide input field
            let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
            let collapseSpace = keyboardHeight - distanceToBottom
            
            if collapseSpace < 0 {
                // no collapse
                return
            }
            
            // set new offset for scroll view
            UIView.animate(withDuration: 0.3, animations: {
                // scroll to the position above keyboard 10 points
                self.scrollView.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.constraintContentHeight.constant -= self.keyboardHeight
            
            self.scrollView.contentOffset = self.lastOffset
        }
        
        keyboardHeight = nil
    }
}

