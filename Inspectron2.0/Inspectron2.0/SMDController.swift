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
    var j = 0
    
    @IBOutlet var risultatoSMD: UILabel!
    var eia_option = false
    
    var field1_text: String = ""
    var field2_text: String = ""
    var field3_text: String = ""
    var field4_text: String = ""


    var curr_button = 4
    var i: Int = 0
    var found_flag1 = 0
    var found_flag2 = 0
    var found_flag3 = 0
    var found_flag4 = 0
    
    let pickerStandard = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "R", "M"]
    let pickerDigits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let pickerLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let pickerEIA = ["Z", "Y", "R", "X", "S", "A", "B", "H", "C", "D", "E", "F"]
    

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
            self.risultatoSMD.text = "0 Ω"
            eia_option = false
            print(eia_option)
            self.i = 0
            self.found_flag1 = 0
            self.found_flag2 = 0
            self.found_flag3 = 0
            self.found_flag4 = 0
            field1.text?.removeAll()
            field2.text?.removeAll()
            field3.text?.removeAll()
            field4.text?.removeAll()
            self.field1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field1.layer.borderWidth = 1
            self.field2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field2.layer.borderWidth = 1
            self.field3.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field3.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field3.layer.borderWidth = 1
            self.field4.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field4.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field4.layer.borderWidth = 1
        } else{
            self.risultatoSMD.text = "0 Ω"
            eia_option = true
            print(eia_option)
            self.i = 0
            self.found_flag1 = 0
            self.found_flag2 = 0
            self.found_flag3 = 0
            self.found_flag4 = 0
            field1.text?.removeAll()
            field2.text?.removeAll()
            field3.text?.removeAll()
            field4.text?.removeAll()
            self.field1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field1.layer.borderWidth = 1
            self.field2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field2.layer.borderWidth = 1
            self.field3.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field3.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field3.layer.borderWidth = 1
            self.field4.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field4.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.field4.layer.borderWidth = 1
        }
        
    }
    
    //etichette sopra i fieldtext
    @IBOutlet var label_field1: UILabel!
    @IBOutlet var label_field2: UILabel!
    @IBOutlet var label_field3: UILabel!
    @IBOutlet var label_field4: UILabel!
    
    @IBAction func four_button(_ sender: UIButton) {
        self.risultatoSMD.text = "0 Ω"
        self.i = 0
        self.found_flag1 = 0
        self.found_flag2 = 0
        self.found_flag3 = 0
        self.found_flag4 = 0
        self.field3.isHidden = false
        self.field4.isHidden = false
        self.four_button.isEnabled = false
        self.three_button.isEnabled = true
        self.two_button.isEnabled = true
        self.eia_switch.isEnabled = false
        self.eia_switch.setOn(false, animated: true)
        self.eia_label.isEnabled = false
        self.field1.text?.removeAll()
        self.field2.text?.removeAll()
        self.field3.text?.removeAll()
        self.field4.text?.removeAll()
        self.eia_option = false
        print(eia_option)
        self.curr_button = 4
        self.label_field1.isHidden = false
        self.label_field2.isHidden = false
        self.label_field3.isHidden = false
        self.label_field4.isHidden = false
        self.field1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field1.layer.borderWidth = 1
        self.field2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field2.layer.borderWidth = 1
        self.field3.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field3.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field3.layer.borderWidth = 1
        self.field4.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field4.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field4.layer.borderWidth = 1


        //BOTTONE ANIMATO 4
        UIView.animate(withDuration: 0.07,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
                       completion: { finish in
                        UIView.animate(withDuration: 0.07, animations: {
                            sender.transform = CGAffineTransform.identity
                        })
        })
    }
    
    @IBAction func three_button(_ sender: UIButton) {
        self.risultatoSMD.text = "0 Ω"
        self.eia_option = false
        print(eia_option)
        self.i = 0
        self.found_flag1 = 0
        self.found_flag2 = 0
        self.found_flag3 = 0
        self.found_flag4 = 0
        self.field3.isHidden = false
        self.field4.isHidden = true
        self.three_button.isEnabled = false
        self.four_button.isEnabled = true
        self.two_button.isEnabled = true
        self.eia_switch.isEnabled = true
        self.eia_label.isEnabled = true
        self.field1.text?.removeAll()
        self.field2.text?.removeAll()
        self.field3.text?.removeAll()
        self.field4.text?.removeAll()
        self.curr_button = 3
        self.label_field1.isHidden = false
        self.label_field2.isHidden = false
        self.label_field3.isHidden = false
        self.label_field4.isHidden = true
    
        self.field1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field1.layer.borderWidth = 1
        self.field2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field2.layer.borderWidth = 1
        self.field3.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field3.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field3.layer.borderWidth = 1
        self.field4.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field4.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field4.layer.borderWidth = 1

        //BOTTONE ANIMATO 3
        UIView.animate(withDuration: 0.07,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
                       completion: { finish in
                        UIView.animate(withDuration: 0.07, animations: {
                            sender.transform = CGAffineTransform.identity
                        })
        })
    }
    
    
    @IBAction func two_button(_ sender: UIButton) {
        self.risultatoSMD.text = "0 Ω"
        self.i = 0
        self.found_flag1 = 0
        self.found_flag2 = 0
        self.found_flag3 = 0
        self.found_flag4 = 0
        self.field3.isHidden = true
        self.field4.isHidden = true
        self.two_button.isEnabled = false
        self.four_button.isEnabled = true
        self.three_button.isEnabled = true
        self.eia_switch.isEnabled = false
        self.eia_switch.setOn(false, animated: true)
        self.eia_label.isEnabled = false
        self.field1.text?.removeAll()
        self.field2.text?.removeAll()
        self.field3.text?.removeAll()
        self.field4.text?.removeAll()
        self.eia_option = false
        print(eia_option)
        self.curr_button = 2
        self.label_field1.isHidden = false
        self.label_field2.isHidden = false
        self.label_field3.isHidden = true
        self.label_field4.isHidden = true
        
        self.field1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field1.layer.borderWidth = 1
        self.field2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field2.layer.borderWidth = 1
        self.field3.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field3.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field3.layer.borderWidth = 1
        self.field4.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field4.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.field4.layer.borderWidth = 1
        
        //BOTTONE ANIMATO 2
        UIView.animate(withDuration: 0.07,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
                       completion: { finish in
                        UIView.animate(withDuration: 0.07, animations: {
                            sender.transform = CGAffineTransform.identity
                        })
        })

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }//fine viewDidAppear
    
    
    
    //######################### inizio viewDidLoad() #########################
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //field1.returnKeyType = UIReturnKeyType.continue


        field1.delegate = self
        field2.delegate = self
        field3.delegate = self
        field4.delegate = self
        
        //label con etichette
        self.label_field1.layer.cornerRadius = 3//label symbol1 arrotondata
        self.label_field2.layer.cornerRadius = 3//label symbol2 arrotondata
        self.label_field3.layer.cornerRadius = 3//label symbol3 arrotondata
        self.label_field4.layer.cornerRadius = 3//label symbol4 arrotondata
        
       
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
        
        
    }//######################### fine viewDidLoad() #########################
    
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
            error_label.text = ""
            
        }
        
        //verifica caratteri per 4 simboli
        
        
        if(curr_button == 4){
            
            for i in pickerStandard{
                if(field1.text! == i){
                    found_flag1 = 1
                }
            }
            
            if (found_flag1 == 1){
                found_flag1 = 0
                i = 0
                self.field1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field1.layer.borderWidth = 1
            } else if ( field1.text! != "") {
                self.field1.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)//rosso
                self.field1.layer.shadowColor = #colorLiteral(red: 0.8319607973, green: 0, blue: 0, alpha: 1)//rosso scuro -> mattone #C21212
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
                i = 0
                self.field2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field2.layer.borderWidth = 1
            } else if ( field2.text! != ""){

                self.field2.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.field2.layer.shadowColor = #colorLiteral(red: 0.8319607973, green: 0, blue: 0, alpha: 1)//rosso scuro -> mattone #C21212
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
                i = 0
                self.field3.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field3.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field3.layer.borderWidth = 1
            } else if ( field3.text! != ""){
                
                self.field3.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.field3.layer.shadowColor = #colorLiteral(red: 0.8319607973, green: 0, blue: 0, alpha: 1)//rosso scuro -> mattone #C21212
                self.field3.layer.borderWidth = 2
                field3.text?.removeAll()
                
            }//fine field 3
            
            for i in pickerStandard{
                if(field4.text! == i){
                    found_flag4 = 1
                }
            }
            
            if (found_flag4 == 1){
                found_flag4 = 0
                i = 0
                self.field4.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field4.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field4.layer.borderWidth = 1
            } else if ( field4.text! != ""){
                
                self.field4.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.field4.layer.shadowColor = #colorLiteral(red: 0.8319607973, green: 0, blue: 0, alpha: 1)//rosso scuro -> mattone #C21212
                self.field4.layer.borderWidth = 2
                field4.text?.removeAll()
                
            }//fine field 4
            
        }//fine verifica caratteri per 4 simboli
        
        //verifica caratteri per 3 simboli && NOT(eia-96)
        if(curr_button == 3 && eia_option == false){
            
            for i in pickerStandard{
                if(field1.text! == i){
                    found_flag1 = 1
                }
            }
            
            if (found_flag1 == 1){
                found_flag1 = 0
                i = 0
                self.field1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field1.layer.borderWidth = 1
            } else if ( field1.text! != "") {
                self.field1.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)//rosso
                self.field1.layer.shadowColor = #colorLiteral(red: 0.8319607973, green: 0, blue: 0, alpha: 1)//rosso scuro -> mattone #C21212
                self.field1.layer.borderWidth = 2
                field1.text?.removeAll()
            }
            //fine field1
            
            
            for i in pickerStandard{
                if(field2.text! == i){
                    found_flag2 = 1
                }
            }
            
            if (found_flag2 == 1){
                found_flag2 = 0
                i = 0
                self.field2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field2.layer.borderWidth = 1
            } else if ( field2.text! != ""){
                
                self.field2.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.field2.layer.shadowColor = #colorLiteral(red: 0.8319607973, green: 0, blue: 0, alpha: 1)//rosso scuro -> mattone #C21212
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
                i = 0
                self.field3.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field3.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field3.layer.borderWidth = 1
            } else if ( field3.text! != ""){
                
                self.field3.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.field3.layer.shadowColor = #colorLiteral(red: 0.8319607973, green: 0, blue: 0, alpha: 1)//rosso scuro -> mattone #C21212
                self.field3.layer.borderWidth = 2
                field3.text?.removeAll()
                
            }//fine field 3
            
            
        }//fine verifica caratteri per 3 simboli && NOT(eia-96)
        
        
        //verifica caratteri per 3 simboli && (eia-96)
        if(curr_button == 3 && eia_option == true){
            
            for i in pickerDigits{
                if(field1.text! == i){
                    found_flag1 = 1
                }
            }
            
            if (found_flag1 == 1){
                found_flag1 = 0
                i = 0
                self.field1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field1.layer.borderWidth = 1
            } else if ( field1.text! != "") {
                self.field1.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)//rosso
                self.field1.layer.shadowColor = #colorLiteral(red: 0.8319607973, green: 0, blue: 0, alpha: 1)//rosso scuro -> mattone #C21212
                self.field1.layer.borderWidth = 2
                field1.text?.removeAll()
            }
            // fine  field1
            
            
            for i in pickerDigits{
                if(field2.text! == i){
                    found_flag2 = 1
                }
            }
            
            if (found_flag2 == 1){
                found_flag2 = 0
                i = 0
                self.field2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field2.layer.borderWidth = 1
            } else if ( field2.text! != ""){
                
                self.field2.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.field2.layer.shadowColor = #colorLiteral(red: 0.8319607973, green: 0, blue: 0, alpha: 1)//rosso scuro -> mattone #C21212
                self.field2.layer.borderWidth = 2
                field2.text?.removeAll()
                
            } // fine field 2
            
            for i in pickerEIA{
                if(field3.text! == i){
                    found_flag3 = 1
                }
            }
            
            if (found_flag3 == 1){
                found_flag3 = 0
                i = 0
                self.field3.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field3.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field3.layer.borderWidth = 1
            } else if ( field3.text! != ""){
                
                self.field3.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.field3.layer.shadowColor = #colorLiteral(red: 0.8319607973, green: 0, blue: 0, alpha: 1)//rosso scuro -> mattone #C21212
                self.field3.layer.borderWidth = 2
                field3.text?.removeAll()
                
            }//fine field 3
            
            
        }//fine verifica caratteri per 3 simboli && (eia-96)
        
        //verifica caratteri per 2 simbolI
        if(curr_button == 2){
            
            for i in pickerLetters{
                if(field1.text! == i){
                    found_flag1 = 1
                }
            }
            
            if (found_flag1 == 1){
                found_flag1 = 0
                i = 0
                self.field1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field1.layer.borderWidth = 1
            } else if ( field1.text! != "") {
                self.field1.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)//rosso
                self.field1.layer.shadowColor = #colorLiteral(red: 0.8319607973, green: 0, blue: 0, alpha: 1)//rosso scuro -> mattone #C21212
                self.field1.layer.borderWidth = 2
                field1.text?.removeAll()
            }
            // fine  field1
            
            
            for i in pickerDigits{
                if(field2.text! == i){
                    found_flag2 = 1
                }
            }
            
            if (found_flag2 == 1){
                found_flag2 = 0
                i = 0
                self.field2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.field2.layer.borderWidth = 1
            } else if ( field2.text! != ""){
                
                self.field2.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.field2.layer.shadowColor = #colorLiteral(red: 0.8319607973, green: 0, blue: 0, alpha: 1)//rosso scuro -> mattone #C21212
                self.field2.layer.borderWidth = 2
                field2.text?.removeAll()
                
            } // fine field 2
            
            
            
        }//fine verifica caratteri per 2 simboli
        

        field1_text = self.field1.text!
        field2_text = self.field2.text!
        field3_text = self.field3.text!
        field4_text = self.field4.text!
        
        if(curr_button == 2){
            if((field1.text! != "") && (field2.text! != "")){
                calculateSMD2(field1_text: field1_text, field2_text: field2_text)
            }else if ((field1.text! == "") || (field2.text! == "")){
                self.risultatoSMD.text = "0 Ω"
            }
        }
        if(curr_button == 3 && eia_option == false){
            if((field1.text! != "") && (field2.text! != "") && (field3.text! != "")){
                calculateSMD3(field1_text: field1_text, field2_text: field2_text, field3_text: field3_text)
            }else if ((field1.text! == "") || (field2.text! == "") || (field3.text! == "")){
                self.risultatoSMD.text = "0 Ω"
            }
        }
        if(curr_button == 4 ){
            if((field1.text! != "") && (field2.text! != "") && (field3.text! != "") && (field4.text! != "")){
                calculateSMD4(field1_text: field1_text, field2_text: field2_text, field3_text: field3_text, field4_text: field4_text)
            }else if ((field1.text! == "") || (field2.text! == "") || (field3.text! == "") || (field4.text! == "")){
                self.risultatoSMD.text = "0 Ω"
            }
        }
        if(curr_button == 3 && eia_option == true){
            if((field1.text! != "") && (field2.text! != "") && (field3.text! != "")){
                calculateSMD_eia(field1_text: field1_text, field2_text: field2_text, field3_text: field3_text)
            }else if ((field1.text! == "") || (field2.text! == "") || (field3.text! == "")){
                self.risultatoSMD.text = "0 Ω"
            }
        }
        
    } // fine touchesBegan
    
    func calculateSMD2(field1_text: String, field2_text: String) {
  
        var valore1 = 0.0
        var valore2 = 0.0
        var risultato: Double
    
        if(field1_text == "A"){
        valore1 = 1.0
        } else if(field1_text == "B"){
            valore1 = 1.1
        } else if(field1_text == "C"){
            valore1 = 1.2
        } else if(field1_text == "D"){
            valore1 = 1.3
        } else if(field1_text == "E"){
            valore1 = 1.5
        } else  if(field1_text == "F"){
            valore1 = 1.6
        } else  if(field1_text == "G"){
            valore1 = 1.8
        } else  if(field1_text == "H"){
            valore1 = 2.0
        } else  if(field1_text == "J"){
            valore1 = 2.2
        } else  if(field1_text == "K"){
            valore1 = 2.4
        } else  if(field1_text == "L"){
            valore1 = 2.7
        } else  if(field1_text == "M"){
            valore1 = 3.0
        } else  if(field1_text == "N"){
            valore1 = 3.3
        } else  if(field1_text == "P"){
            valore1 = 3.6
        } else  if(field1_text == "Q"){
            valore1 = 3.9
        } else  if(field1_text == "R"){
            valore1 = 4.3
        } else if(field1_text == "S"){
            valore1 = 4.7
        } else  if(field1_text == "T"){
            valore1 = 5.1
        } else  if(field1_text == "U"){
            valore1 = 5.6
        } else  if(field1_text == "V"){
            valore1 = 6.2
        } else  if(field1_text == "W"){
            valore1 = 6.8
        } else  if(field1_text == "X"){
            valore1 = 7.5
        } else  if(field1_text == "Y"){
            valore1 = 8.2
        } else  if(field1_text == "Z"){
            valore1 = 9.1
        } else {
            valore1 = 0.0
        }
        
        valore2 = Double(field2_text)!
        risultato = valore1*pow(10.0, valore2)
        print_label(result: risultato)
        
    } // fine calculateSMD2
    
    func calculateSMD3(field1_text: String, field2_text: String, field3_text: String){
        
        var risultato = 0.0
        var count = 0
        
        if(field1_text == "M" || field1_text == "R" ){
            count = count+1
        }
        if(field2_text == "M" || field2_text == "R" ){
            count = count+1
        }
        if(field3_text == "M" || field3_text == "R" ){
            count = count+1
        }
        
        if(field1_text == "M" && field2_text != "M" && field2_text != "R" && field3_text != "M" && field3_text != "R") {
            risultato = Double("0." + field2_text + field3_text)!/1000
            print_label(result: risultato)
        }else if(field1_text != "M" && field1_text != "R" && field2_text == "M" && field3_text != "M" && field3_text != "R"){
            risultato = Double(field1_text + "." + field3_text)!/1000
            print_label(result: risultato)
        }else if(field1_text != "M" && field1_text != "R" && field2_text != "M" && field2_text != "R" && field3_text == "M"){
            risultato = Double(field1_text + field2_text + ".0")!/1000
            print_label(result: risultato)
        }else if(field1_text == "R" && field2_text != "M" && field2_text != "R" && field3_text != "M" && field3_text != "R") {
            risultato = Double("0." + field2_text + field3_text)!
            print_label(result: risultato)
        }else if(field1_text != "M" && field1_text != "R" && field2_text == "R" && field3_text != "M" && field3_text != "R"){
            risultato = Double(field1_text + "." + field3_text)!
            print_label(result: risultato)
        }else if(field1_text != "M" && field1_text != "R" && field2_text != "M" && field2_text != "R" && field3_text == "R"){
            risultato = Double(field1_text + field2_text + ".0")!
            print_label(result: risultato)
        }else if(count == 0)  {
            risultato = Double(field1_text + field2_text)! * pow(10.0, Double(field3_text)!)
            print_label(result: risultato)
        }else{
            self.risultatoSMD.text =  "?"
        }
        
    } // fine calculate SMD3
    

    func calculateSMD4(field1_text: String, field2_text: String, field3_text: String, field4_text: String){
        
        var risultato = 0.0
        var count = 0
        
        if(field1_text == "M" || field1_text == "R" ){
            count = count+1
        }
        if(field2_text == "M" || field2_text == "R" ){
            count = count+1
        }
        if(field3_text == "M" || field3_text == "R" ){
            count = count+1
        }
        if(field4_text == "M" || field4_text == "R" ){
            count = count+1
        }
        
        if(field1_text == "M" && field2_text != "M" && field2_text != "R" && field3_text != "M" && field3_text != "R" && field4_text != "M" && field4_text != "R") {
            risultato = Double("0." + field2_text + field3_text + field4_text)!/1000
            print_label(result: risultato)
        }else if(field1_text != "M" && field1_text != "R" && field2_text == "M" && field3_text != "M" && field3_text != "R" && field4_text != "M" && field4_text != "R"){
            risultato = Double(field1_text + "." + field3_text + field4_text)!/1000
            print_label(result: risultato)
        }else if(field1_text != "M" && field1_text != "R" && field2_text != "M" && field2_text != "R" && field3_text == "M" && field4_text != "M" && field4_text != "R"){
            risultato = Double(field1_text + field2_text + "." + field4_text)!/1000
            print_label(result: risultato)
        }else if(field1_text != "M" && field1_text != "R" && field2_text != "M" && field2_text != "R" && field3_text != "M" && field3_text != "R" && field4_text == "M"){
            risultato = Double(field1_text + field2_text + field3_text + ".0")!/1000
            print_label(result: risultato)
        }else if(field1_text == "R" && field2_text != "M" && field2_text != "R" && field3_text != "M" && field3_text != "R" && field4_text != "M" && field4_text != "R") {
            risultato = Double("0." + field2_text + field3_text + field4_text)!
            print_label(result: risultato)
        }else if(field1_text != "M" && field1_text != "R" && field2_text == "R" && field3_text != "M" && field3_text != "R" && field4_text != "M" && field4_text != "R"){
            risultato = Double(field1_text + "." + field3_text + field4_text)!
            print_label(result: risultato)
        }else if(field1_text != "M" && field1_text != "R" && field2_text != "M" && field2_text != "R" && field3_text == "R" && field4_text != "M" && field4_text != "R"){
            risultato = Double(field1_text + field2_text + "." + field4_text)!
            print_label(result: risultato)
        }else if(field1_text != "M" && field1_text != "R" && field2_text != "M" && field2_text != "R" && field3_text != "R" && field3_text != "M" && field4_text == "R"){
            risultato = Double(field1_text + field2_text + field3_text + ".0")!
            print_label(result: risultato)
        }else if(count == 0)  {
            risultato = Double(field1_text + field2_text + field3_text)! * pow(10.0, Double(field4_text)!)
            print_label(result: risultato)
        }else{
            self.risultatoSMD.text =  "?"
        }
        
    } // fine calculate SMD4
    
    func calculateSMD_eia(field1_text: String, field2_text: String, field3_text: String){
        var valore = 0.0
        var moltiplicatore = 0.0
        var risultato = 0.0
        var indice = 0
        var values = [100, 102, 105, 107, 110, 113, 115, 118, 121, 124, 127, 130, 133, 137, 140, 143, 147, 150, 154, 158, 162, 165, 169, 174, 178, 182, 187, 191, 196,200, 205, 210, 215, 221, 226, 232, 237, 243, 249, 255, 261, 267, 274, 280, 287, 294, 301, 309, 316, 324, 332, 340, 348, 357, 365, 374, 383, 392, 402, 412, 422, 432, 442, 453, 464, 475, 487, 499, 511, 523, 536, 549, 562, 576, 590, 604, 619, 634, 649, 665, 681, 698, 715, 732, 750, 768, 787, 806, 825, 845, 866, 887, 909, 931, 953, 976]
        
        indice = Int(field1_text + field2_text)!
        if(indice == 0 || indice == 97 || indice == 98 || indice == 99){
            self.risultatoSMD.text = "?"
        }else{
        valore = Double(values[indice-1])
            
        }
       
        if(field3_text == "Z"){
            moltiplicatore = 0.001
        }else if(field3_text == "Y" || field3_text == "R"){
            moltiplicatore = 0.01
        }else if(field3_text == "X" || field3_text == "S"){
            moltiplicatore = 0.1
        }else if(field3_text == "A"){
            moltiplicatore = 1
        }else if(field3_text == "B" || field3_text == "H"){
            moltiplicatore = 10
        }else if(field3_text == "C"){
            moltiplicatore = 100
        }else if(field3_text == "D"){
            moltiplicatore = 1000
        }else if(field3_text == "E"){
            moltiplicatore = 10000
        }else if(field3_text == "F"){
            moltiplicatore = 100000
        }
        risultato = valore * moltiplicatore
        print_label(result: risultato)
    } // fine funzione EIA
    
    func print_label(result: Double){
        print(result)
        if(result < 0.001){
            self.risultatoSMD.text = String(format: "%g", result*1000000) + " μΩ"
        }else if((result < 1) && (result >= 0.001)){
            self.risultatoSMD.text = String(format: "%g", result*1000) + " mΩ"
        }else if ((result < 1000) && (result > 1) ){
            self.risultatoSMD.text = String(format: "%g", result) + " Ω"
        }else if (result >= 1000) && (result < 1000000){
            self.risultatoSMD.text = String(format: "%g", result/1000) + " KΩ"
        }else if (result >= 1000000) && (result < 1000000000){
            self.risultatoSMD.text = String(format: "%g", result/1000000) + " MΩ"
        }else if (result >= 1000000000){
            self.risultatoSMD.text = String(format: "%g", result/1000000000) + " GΩ"
        }
    }
    
    
}

