//
//  SMDController.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico on 10/05/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import Foundation
import UIKit

class SMD: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var field1: UITextField!
    @IBOutlet var field2: UITextField!
    @IBOutlet var field3: UITextField!
    @IBOutlet var field4: UITextField!
    @IBOutlet var eia_switch: UISwitch!
    @IBOutlet var four_button: UIButton!
    @IBOutlet var three_button: UIButton!
    @IBOutlet var two_button: UIButton!
    @IBOutlet var eia_label: UILabel!
    let limitLength = 1
    
    
    @IBAction func four_button(_ sender: UIButton) {
        
        field3.isHidden = false
        field4.isHidden = false
        four_button.isEnabled = false
        three_button.isEnabled = true
        two_button.isEnabled = true
        eia_switch.isEnabled = false
        eia_switch.setOn(false, animated: true)
        eia_label.isEnabled = false

    }
    
    @IBAction func three_button(_ sender: UIButton) {
        
        field3.isHidden = false
        field4.isHidden = true
        three_button.isEnabled = false
        four_button.isEnabled = true
        two_button.isEnabled = true
        eia_switch.isEnabled = true
        eia_label.isEnabled = true
    }
    
    
    @IBAction func two_button(_ sender: UIButton) {
        
        field3.isHidden = true
        field4.isHidden = true
        two_button.isEnabled = false
        four_button.isEnabled = true
        three_button.isEnabled = true
        eia_switch.isEnabled = false
        eia_switch.setOn(false, animated: true)
        eia_label.isEnabled = false

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        field1.delegate = self
        field2.delegate = self
        field3.delegate = self
        field4.delegate = self
        
        
        //inizializzazione bottoni
        self.four_button.isEnabled = false
        self.three_button.isEnabled = true
        self.two_button.isEnabled = true
        self.eia_switch.isEnabled = false
        self.eia_switch.setOn(false, animated: true)
        self.eia_label.isEnabled = false

        
        self.field1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field1.layer.borderWidth = 1
        self.field1.layer.cornerRadius = 3
        self.field1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field1.layer.shadowRadius = 3
        self.field1.layer.shadowOpacity = 0.3
        self.field1.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        self.field2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field2.layer.borderWidth = 1
        self.field2.layer.cornerRadius = 3
        self.field2.layer.shadowRadius = 3
        self.field2.layer.shadowOpacity = 0.3
        self.field2.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        self.field3.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field3.layer.borderWidth = 1
        self.field3.layer.cornerRadius = 3
        self.field3.layer.shadowRadius = 3
        self.field3.layer.shadowOpacity = 0.3
        self.field3.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        self.eia_switch.layer.shadowRadius = 2
        self.eia_switch.layer.shadowOpacity = 0.2
        self.eia_switch.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        self.field4.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field4.layer.borderWidth = 1
        self.field4.layer.cornerRadius = 3
        self.field4.layer.shadowRadius = 3
        self.field4.layer.shadowOpacity = 0.3
        self.field4.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        self.four_button.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        self.four_button.layer.borderWidth = 1
        self.four_button.layer.cornerRadius = 3
        
        self.three_button.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        self.three_button.layer.borderWidth = 1
        self.three_button.layer.cornerRadius = 3
        
        self.two_button.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        self.two_button.layer.borderWidth = 1
        self.two_button.layer.cornerRadius = 3
        
        
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

