//
//  FormViewController.swift
//
//  A subclass for forms - screen moves up if keyboard covers UITextField
//
//  Created by Max Rogers on 12/1/17.
//

import UIKit

class FormViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    var amountMoved: CGFloat = 0
    var currentTextField: UITextField?
    var dontAdjust = false
    
    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToKeyBoardNotifications()
    }
    
    fileprivate func subscribeToKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldPressed(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldHiding(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Text Field
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    // MARK: Textfield Notifications
    
    @objc func textFieldPressed(_ sender: Notification) {
        let userInfo = sender.userInfo!
        let keyboardRect = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue
        let keyboardHeight = keyboardRect?.height
        
        if amountMoved == 0 {
            amountMoved = keyboardHeight!
            
            if !dontAdjust {
                adjustForTextField(withKeyboardHeight: keyboardHeight!)
            }
        }
    }
    
    @objc func textFieldHiding(_ sender: Notification) {
        if !dontAdjust {
            unadjustForTextField()
        }
    }
    
    func adjustForTextField(withKeyboardHeight keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3, animations: { [unowned self] () -> Void in
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height - keyboardHeight)
        })
    }
    
    func unadjustForTextField() {
        UIView.animate(withDuration: 0.3, animations: { [unowned self] () -> Void in
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height + self.amountMoved)
        })
        
        amountMoved = 0
    }
    
    // MARK: Deinit
    
    override func viewWillDisappear(_ animated: Bool) {
        currentTextField?.resignFirstResponder()
    }
    
}
