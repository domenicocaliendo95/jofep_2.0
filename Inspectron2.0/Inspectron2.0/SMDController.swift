//
//  SMDController.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico on 10/05/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import Foundation
import UIKit

class SMD: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var picker1: UIPickerView!
    @IBOutlet var picker2: UIPickerView!
    @IBOutlet var picker3: UIPickerView!
    @IBOutlet var picker4: UIPickerView!
    
  
    var curr_button = 4
    var eia = false
    var selectedPicker1, selectedPicker2, selectedPicker3, selectedPicker4: String!
    
    @IBAction func four_digits_button(_ sender: UIButton) {
        curr_button = 4
        print(curr_button)
        eia = false
        self.picker1.isHidden = false
        self.picker2.isHidden = false
        self.picker3.isHidden = false
        self.picker4.isHidden = false
        
    }
    
    
    @IBAction func three_digits_button(_ sender: UIButton) {
        curr_button = 3
        print(curr_button)
        eia = false
        self.picker1.isHidden = false
        self.picker2.isHidden = false
        self.picker3.isHidden = false
        self.picker4.isHidden = true
    }
    
    
    @IBAction func two_digits_button(_ sender: UIButton) {
        curr_button = 2
        print(curr_button)
        eia = false
        self.picker1.isHidden = false
        self.picker2.isHidden = false
        self.picker3.isHidden = true
        self.picker4.isHidden = true
    }
    
    
    struct NamedValue
    {
        var name: String
        var value: Any
        init(name : String, value : Any)
        {
            self.name = name
            self.value = value
        }
    }
    
    var pickerStandard: [NamedValue] = []
    var pickerDigits: [NamedValue] = []
    var pickerLetters: [NamedValue] = []
    var pickerEIA: [NamedValue] = []
    
    
    //inizio viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s0 = "0"
        let s1 = "1"
        let s2 = "2"
        let s3 = "3"
        let s4 = "4"
        let s5 = "5"
        let s6 = "6"
        let s7 = "7"
        let s8 = "8"
        let s9 = "9"
        
        
        let sA = "A"
        let sB = "B"
        let sC = "C"
        let sD = "D"
        let sE = "E"
        let sF = "F"
        let sG = "G"
        let sH = "H"
        let sJ = "J"
        let sK = "K"
        let sL = "L"
        let sM = "M"
        let sN = "N"
        let sP = "P"
        let sQ = "Q"
        let sR = "R"
        let sS = "S"
        let sT = "T"
        let sU = "U"
        let sV = "V"
        let sW = "W"
        let sX = "X"
        let sY = "Y"
        let sZ = "Z"
        
        
        pickerStandard = [
            NamedValue(name: "     0", value: s0),//5 SPAZI INIZIALI
            NamedValue(name: "     1", value: s1),
            NamedValue(name: "     2", value: s2),
            NamedValue(name: "     3", value: s3),
            NamedValue(name: "     4", value: s4),
            NamedValue(name: "     5", value: s5),
            NamedValue(name: "     6", value: s6),
            NamedValue(name: "     7", value: s7),
            NamedValue(name: "     8", value: s8),
            NamedValue(name: "     9", value: s9),
            NamedValue(name: "     R", value: sR),
            NamedValue(name: "     M", value: sM)
        ]
        
        pickerDigits = [
            NamedValue(name: "     0", value: s0),
            NamedValue(name: "     1", value: s1),
            NamedValue(name: "     2", value: s2),
            NamedValue(name: "     3", value: s3),
            NamedValue(name: "     4", value: s4),
            NamedValue(name: "     5", value: s5),
            NamedValue(name: "     6", value: s6),
            NamedValue(name: "     7", value: s7),
            NamedValue(name: "     8", value: s8),
            NamedValue(name: "     9", value: s9)
        ]
        
        pickerLetters = [
            NamedValue(name: "A", value: sA),
            NamedValue(name: "B", value: sB),
            NamedValue(name: "C", value: sC),
            NamedValue(name: "D", value: sD),
            NamedValue(name: "E", value: sE),
            NamedValue(name: "F", value: sF),
            NamedValue(name: "G", value: sG),
            NamedValue(name: "H", value: sH),
            NamedValue(name: "J", value: sJ),
            NamedValue(name: "K", value: sK),
            NamedValue(name: "L", value: sL),
            NamedValue(name: "M", value: sM),
            NamedValue(name: "N", value: sN),
            NamedValue(name: "P", value: sP),
            NamedValue(name: "Q", value: sQ),
            NamedValue(name: "R", value: sR),
            NamedValue(name: "S", value: sS),
            NamedValue(name: "T", value: sT),
            NamedValue(name: "U", value: sU),
            NamedValue(name: "V", value: sV),
            NamedValue(name: "W", value: sW),
            NamedValue(name: "X", value: sX),
            NamedValue(name: "Y", value: sY),
            NamedValue(name: "Z", value: sZ)
        ]
        
        pickerEIA = [
            NamedValue(name: "Z", value: sZ),
            NamedValue(name: "Y", value: sY),
            NamedValue(name: "R", value: sR),
            NamedValue(name: "X", value: sX),
            NamedValue(name: "S", value: sS),
            NamedValue(name: "A", value: sA),
            NamedValue(name: "B", value: sB),
            NamedValue(name: "H", value: sH),
            NamedValue(name: "C", value: sC),
            NamedValue(name: "D", value: sD),
            NamedValue(name: "E", value: sE),
            NamedValue(name: "F", value: sF)
            
        ]
        
        
        //      ◊◊◊◊◊◊◊◊◊◊  Picker Default Value  ◊◊◊◊◊◊◊◊◊◊◊
        /* Po' semp serv
        selectedPicker1 = "1111111111111111111"
        selectedPicker2 = "2222222222222222222"
        selectedPicker3 = "3333333333333333333"
        selectedPicker4 = "4444444444444444444" */
        
        }//fine viewDidLoad
        
        override  func didReceiveMemoryWarning(){
            super.didReceiveMemoryWarning()
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            if(curr_button == 4) {
                if(pickerView.accessibilityIdentifier == "Picker1"){
                return pickerStandard.count
                }
                if(pickerView.accessibilityIdentifier == "Picker2"){
                    return pickerStandard.count
                }
                if(pickerView.accessibilityIdentifier == "Picker3"){
                    return pickerEIA.count
                }
                if(pickerView.accessibilityIdentifier == "Picker4"){
                    return pickerEIA.count
                }
            }//fine curr_button == 4
            
            return pickerStandard.count
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int{
            // Aggiungere condizioni di selezione in base alla differenziazione del picker
            
            if(curr_button == 4) {
                if(pickerView.accessibilityIdentifier == "Picker1"){
                    return pickerStandard.count
                }
                if(pickerView.accessibilityIdentifier == "Picker2"){
                    return pickerStandard.count
                }
                if(pickerView.accessibilityIdentifier == "Picker3"){
                    return pickerEIA.count
                }
                if(pickerView.accessibilityIdentifier == "Picker4"){
                    return pickerEIA.count
                }
            }//fine curr_button == 4
            return pickerStandard.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
            // Aggiungere condizioni di selezione in base alla differenziazione del picker
            
            if(curr_button == 4) {
                if(pickerView.accessibilityIdentifier == "Picker1"){
                    return pickerStandard[row].name
                }
                if(pickerView.accessibilityIdentifier == "Picker2"){
                    return pickerStandard[row].name
                }
                if(pickerView.accessibilityIdentifier == "Picker3"){
                    return pickerEIA[row].name
                }
                if(pickerView.accessibilityIdentifier == "Picker4"){
                    return pickerEIA[row].name
                }
            }//fine curr_button == 4
            return pickerStandard[row].name
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
            switch(pickerView.accessibilityIdentifier!)
            {
                
            case "Picker1": selectedPicker1 = pickerStandard[row].name
            print(selectedPicker1)
            
                
                
            case "Picker2": selectedPicker2 = pickerStandard[row].name
            print(selectedPicker2)
                
                
            case "Picker3": selectedPicker3 = pickerEIA[row].name
            print(selectedPicker3)
                
                
            case "Picker4": selectedPicker4 = pickerEIA[row].name
            print(selectedPicker4)
                
                
            default:
                break
            }
        }
        
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        selectedPicker1 = pickerStandard[row].name
        let titleData = selectedPicker1
        let myTitle = NSAttributedString(string: titleData!, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 25.0)!,NSAttributedStringKey.foregroundColor:UIColor.white])
        pickerLabel.attributedText = myTitle
        pickerLabel.backgroundColor = UIColor.black
        pickerLabel.textAlignment = .justified
        return pickerLabel
        
    }
    
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 36.0
        }
        // for best use with multitasking , dont use a constant here.
        //this is for demonstration purposes only.
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return 200
        }
        

    

    
    
    
    
}

