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
    let limitLength = 1
    var eia_option = false
    var curr_button = 4
    var i: Int = 0
    var found_flag1 = 0
    var found_flag2 = 0
    var found_flag3 = 0
    var found_flag4 = 0

    
    
    
    @IBOutlet var error_label: UILabel!
    
    
    @IBOutlet var field1: UITextField! 
    @IBOutlet var field2: UITextField!
    @IBOutlet var field3: UITextField!
    @IBOutlet var field4: UITextField!
    @IBOutlet var eia_switch: UISwitch!
    @IBOutlet var four_button: UIButton!
    @IBOutlet var three_button: UIButton!
    @IBOutlet var two_button: UIButton!
    @IBOutlet var eia_label: UILabel!
    @IBAction func eia_switch_action(_ sender: UISwitch) {
        if(eia_option == true){
            eia_option = false
        } else{
            eia_option = true
            
        }
        
    }


    @IBOutlet var label_field1: UILabel!
    @IBOutlet var label_field2: UILabel!
    @IBOutlet var label_field3: UILabel!
    @IBOutlet var label_field4: UILabel!
    
    @IBAction func four_button(_ sender: UIButton) {
        
        field3.isHidden = false
        field4.isHidden = false
        four_button.isEnabled = false
        three_button.isEnabled = true
        two_button.isEnabled = true
        eia_switch.isEnabled = false
        eia_switch.setOn(false, animated: true)
        eia_label.isEnabled = false
        field1.text?.removeAll()
        field2.text?.removeAll()
        field3.text?.removeAll()
        field4.text?.removeAll()
        eia_option = false
        curr_button = 4

        //BOTTONE ANIMATO 4
        UIView.animate(withDuration: 0.07,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.98, y: 0.94)
        },
                       completion: { finish in
                        UIView.animate(withDuration: 0.07, animations: {
                            sender.transform = CGAffineTransform.identity
                        })
        })
    }
    
    @IBAction func three_button(_ sender: UIButton) {
        
        field3.isHidden = false
        field4.isHidden = true
        three_button.isEnabled = false
        four_button.isEnabled = true
        two_button.isEnabled = true
        eia_switch.isEnabled = true
        eia_label.isEnabled = true
        field1.text?.removeAll()
        field2.text?.removeAll()
        field3.text?.removeAll()
        field4.text?.removeAll()
        eia_option = false
        curr_button = 3

        //BOTTONE ANIMATO 3
        UIView.animate(withDuration: 0.07,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.98, y: 0.94)
        },
                       completion: { finish in
                        UIView.animate(withDuration: 0.07, animations: {
                            sender.transform = CGAffineTransform.identity
                        })
        })
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
        field1.text?.removeAll()
        field2.text?.removeAll()
        field3.text?.removeAll()
        field4.text?.removeAll()
        eia_option = false
        curr_button = 2
        //BOTTONE ANIMATO 2
        UIView.animate(withDuration: 0.07,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.98, y: 0.94)
        },
                       completion: { finish in
                        UIView.animate(withDuration: 0.07, animations: {
                            sender.transform = CGAffineTransform.identity
                        })
        })

    }
    
    
    let pickerStandard = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "R", "M"]
    let pickerDigits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let pickerLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let pickerEIA = ["Z", "Y", "R", "X", "S", "A", "B", "H", "C", "D", "E", "F"]
    
    
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
        self.four_button.layer.shadowRadius = 3
        self.four_button.layer.shadowOpacity = 0.3
        self.four_button.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        self.three_button.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        self.three_button.layer.borderWidth = 1
        self.three_button.layer.cornerRadius = 3
        self.three_button.layer.shadowRadius = 3
        self.three_button.layer.shadowOpacity = 0.3
        self.three_button.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        self.two_button.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        self.two_button.layer.borderWidth = 1
        self.two_button.layer.cornerRadius = 3
        self.two_button.layer.shadowRadius = 3
        self.two_button.layer.shadowOpacity = 0.3
        self.two_button.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        
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
        
        if(field1.text!.count > 1){
            error_label.text = "Please insert only one letter or number!"
         
            field1.text?.removeAll()
            field1.becomeFirstResponder()
            
        }else if(field2.text!.count > 1){
            error_label.text = "Please insert only one letter or number!"
            
            field2.text?.removeAll()
            field2.becomeFirstResponder()
            
        } else if(field3.text!.count > 1){
            error_label.text = "Please insert only one letter or number!"
            
            field3.text?.removeAll()
            field3.becomeFirstResponder()
            
        } else if(field4.text!.count > 1){
            error_label.text = "Please insert only one letter or number!"
            
            field4.text?.removeAll()
            field4.becomeFirstResponder()
            
        } else if((field1.text!.count <= 1) && (field2.text!.count <= 1) && (field3.text!.count <= 1) && (field4.text!.count <= 1) ) {
            error_label.text = "polpette"
            
        }
        
        if(curr_button == 4){
            
            for i in pickerStandard{
                if(field1.text! == i){
                    found_flag1 = 1
                }
            }
            
            if (found_flag1 == 1){
                
                found_flag1 = 0
                self.field1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field1.layer.borderWidth = 1
            } else if ( field1.text! != "") {
                
                self.field1.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.field1.layer.borderWidth = 2
                field1.text?.removeAll()
            }
            // fine  field1
            
            
            
            
            for i in pickerStandard{
                if(field2.text! == i){
                    found_flag2 = 1
                }
            }
            
            if (found_flag2 == 1){
                found_flag2 = 0
                self.field2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field2.layer.borderWidth = 1
            } else if ( field2.text! != ""){

                self.field2.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.field2.layer.borderWidth = 2
                field2.text?.removeAll()
                
            } // fine field 2
            
            for i in pickerStandard{
                if(field3.text! == i){
                    found_flag3 = 1
                }
            }
            
            if (found_flag3 == 1){
                found_flag3 = 0
                self.field3.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field3.layer.borderWidth = 1
            } else if ( field3.text! != ""){
                
                self.field3.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.field3.layer.borderWidth = 2
                field3.text?.removeAll()
                
            } // fine field 3
            
            for i in pickerStandard{
                if(field4.text! == i){
                    found_flag4 = 1
                }
            }
            
            if (found_flag4 == 1){
                found_flag4 = 0
                self.field4.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field4.layer.borderWidth = 1
            } else if ( field4.text! != ""){
                
                self.field4.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.field4.layer.borderWidth = 2
                field4.text?.removeAll()
                
            } // fine field 4
            
        } // fine if button == 4
        
        

        

        
    } // fine touchesBegan
    
    
    

    

}

