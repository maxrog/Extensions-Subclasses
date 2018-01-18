//
//  ViewController.swift
//  
//
//  Created by Max Rogers on 1/17/18.
//

import UIKit

// MARK: - Present a basic alert on any view controller - customize as desired

extension UIViewController {
    
    func presentBasicAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error",
                                          message: message,
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            print(message)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
