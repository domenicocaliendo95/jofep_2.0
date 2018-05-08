//
//  SMDController.swift
//  Inspectron2.0
//
//  Created by Gemito Gennaro on 07/05/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import Foundation
import UIKit

class SMD: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerStandard.count
    }
    
    //picker
    @IBOutlet var picker1: UIPickerView!
    @IBOutlet var picker2: UIPickerView!
    @IBOutlet var picker3: UIPickerView!
    @IBOutlet var picker4: UIPickerView!
    
    struct NamedValue
    {
        var nome: String
        var valore: Any
        init(nome : String, valore : Any)
        {
            self.nome = nome;
            self.valore = valore
        }
    }
    
    var pickerStandard: [NamedValue] = []
    var pickerDigits: [NamedValue] = []
    var pickerLetters: [NamedValue] = []
    var pickerEIA: [NamedValue] = []
    
    var selectedPicker1, selectedPicker2, selectedPicker3, selectedPicker4: String!
    
    //inizio viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s0 = 0
        let s1 = 1
        let s2 = 2
        let s3 = 3
        let s4 = 4
        let s5 = 5
        let s6 = 6
        let s7 = 7
        let s8 = 8
        let s9 = 9
        let R = "R"
        let M = "M"
        
        pickerStandard = [
            NamedValue(nome: "0", valore: s0),
            NamedValue(nome: "1", valore: s1),
            NamedValue(nome: "2", valore: s2),
            NamedValue(nome: "3", valore: s3),
            NamedValue(nome: "4", valore: s4),
            NamedValue(nome: "5", valore: s5),
            NamedValue(nome: "6", valore: s6),
            NamedValue(nome: "7", valore: s7),
            NamedValue(nome: "8", valore: s8),
            NamedValue(nome: "9", valore: s9),
            NamedValue(nome: "R", valore: R),
            NamedValue(nome: "M", valore: M)
        ]

        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch(pickerView.accessibilityIdentifier!)
            {
                
            case "Picker1": selectedPicker1 = pickerStandard[row].nome
            print(selectedPicker1)
                
            case "Picker2": selectedPicker2 = pickerStandard[row].nome
            print(selectedPicker2)
                
            case "Picker3": selectedPicker3 = pickerStandard[row].nome
            print(selectedPicker3)
                
            case "Picker4": selectedPicker4 = pickerStandard[row].nome
            print(selectedPicker4)
        
            default:
                break
            }
        }
        
        
        func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
            let titleData = pickerStandard[row].nome
            let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 26.0)!,NSAttributedStringKey.foregroundColor:UIColor.blue])
            return myTitle
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 36.0
        }
        // for best use with multitasking , dont use a constant here.
        //this is for demonstration purposes only.
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return 200
        }
        
    }//fine viewDidLoad
    
}
