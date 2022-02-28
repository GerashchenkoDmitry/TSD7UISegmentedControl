//
//  ViewControllerExtension.swift
//  TSD7UISegmentedControl
//
//  Created by Дмитрий Геращенко on 16.02.2022.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.hideKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
