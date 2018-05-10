//
//  SMDController.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico on 10/05/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import Foundation
import UIKit

class SMD: UIViewController{
    
    @IBOutlet var field1: UITextField!
    @IBOutlet var field2: UITextField!
    @IBOutlet var field3: UITextField!
    @IBOutlet var field4: UITextField!
    @IBOutlet var eia_switch: UISwitch!
    
    @IBAction func four_button(_ sender: UIButton) {
        
        field3.isHidden = false
        field4.isHidden = false
    }
    
    @IBAction func three_button(_ sender: UIButton) {
        
        field3.isHidden = false
        field4.isHidden = true
    }
    
    
    @IBAction func two_button(_ sender: UIButton) {
        
        field3.isHidden = true
        field4.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.view.frame.origin.y = 0//reset keyboard height
    }
}

