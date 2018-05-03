//
//  ResistorController.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico on 03/05/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import Foundation
import UIKit

class Resistor: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet var picker1: UIPickerView!
    @IBOutlet var picker2: UIPickerView!
    @IBOutlet var picker3: UIPickerView!
    @IBOutlet var picker4: UIPickerView!
    @IBOutlet var picker5: UIPickerView!
    @IBOutlet var picker6: UIPickerView!
    
    
    struct NamedColor
    {
        var name: String
        var color: UIColor
        init(name : String, color : UIColor)
        {
            self.name = name;
            self.color = color
        }
    }
    
    var pickerData: [NamedColor] = []
    var pickerDataMultiplier: [NamedColor] = []
    var pickerDataTolerance: [NamedColor] = []
    
    var selectedPicker1, selectedPicker2, selectedPicker3, selectedPicker4, selectedPicker5, selectedPicker6: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker1.delegate = self
        self.picker1.dataSource = self
        self.picker2.delegate = self
        self.picker2.dataSource = self
        self.picker3.delegate = self
        self.picker3.dataSource = self
        self.picker4.delegate = self
        self.picker4.dataSource = self
        self.picker5.delegate = self
        self.picker5.dataSource = self
        self.picker6.delegate = self
        self.picker6.dataSource = self
        //customize button
        
        
        let brown = #colorLiteral(red: 0.5616386027, green: 0.4023959335, blue: 0.2233105485, alpha: 1)
        let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let orange = #colorLiteral(red: 1, green: 0.4984615517, blue: 0.08212189493, alpha: 1)
        let yellow = #colorLiteral(red: 1, green: 0.9638280272, blue: 0.06725924462, alpha: 1)
        let green = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        let blue = #colorLiteral(red: 0, green: 0.3738567995, blue: 1, alpha: 1)
        let violet = #colorLiteral(red: 0.5465450394, green: 0, blue: 1, alpha: 1)
        let grey = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let gold = #colorLiteral(red: 0.8549019608, green: 0.6549019608, blue: 0.1254901961, alpha: 1)
        let silver = #colorLiteral(red: 0.7977497578, green: 0.7977686524, blue: 0.7977585196, alpha: 1)
        let red = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        
        picker1.tintColor=UIColor.clear
        //set color selected to default - black
        selectedPicker1 = "Black"
        selectedPicker2 = "Black"
        selectedPicker3 = "Black"
        selectedPicker4 = "Black"
        selectedPicker5 = "Brown"
        selectedPicker6 = "Brown"
        //--
        
 
        
        pickerData = [
            NamedColor(name: "Black", color: black),
            NamedColor(name: "Brown", color: brown),
            NamedColor(name: "Red", color: red),
            NamedColor(name: "Orange", color: orange),
            NamedColor(name: "Yellow", color: yellow),
            NamedColor(name: "Green", color: green),
            NamedColor(name: "Blue", color: blue),
            NamedColor(name: "Violet", color: violet),
            NamedColor(name: "Grey", color: grey),
            NamedColor(name: "White", color: white)]
        
        pickerDataMultiplier = [
            NamedColor(name: "Black", color: black),
            NamedColor(name: "Brown", color: brown),
            NamedColor(name: "Red", color: red),
            NamedColor(name: "Orange", color: orange),
            NamedColor(name: "Yellow", color: yellow),
            NamedColor(name: "Green", color: green),
            NamedColor(name: "Blue", color: blue),
            NamedColor(name: "Violet", color: violet),
            NamedColor(name: "Gold", color: gold),
            NamedColor(name: "Silver", color: silver)]
        
        pickerDataTolerance = [
            NamedColor(name: "Brown", color: brown),
            NamedColor(name: "Red", color: red),
            NamedColor(name: "Green", color: green),
            NamedColor(name: "Blue", color: blue),
            NamedColor(name: "Violet", color: violet),
            NamedColor(name: "Grey", color: grey),
            NamedColor(name: "Gold", color: gold),
            NamedColor(name: "Silver", color: silver)]
        //        picker1.dataSource = pickerData as? UIPickerViewDataSource
        //        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.accessibilityIdentifier == "Picker5")
        {
            return pickerDataMultiplier.count
        }
        if (pickerView.accessibilityIdentifier == "Picker6")
        {
            return pickerDataTolerance.count
        }
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        if (pickerView.accessibilityIdentifier == "Picker5")
        {
            return pickerDataMultiplier[row].name
        }
        if (pickerView.accessibilityIdentifier == "Picker6")
        {
            return pickerDataTolerance[row].name
        }
        return pickerData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(pickerView.accessibilityIdentifier)
        {
            
        case "Picker1"?:
            selectedPicker1 = pickerData[row].name
                    print(selectedPicker1)
        case "Picker2"?: selectedPicker2 = pickerData[row].name
                    print(selectedPicker2)
        case "Picker3"?: selectedPicker3 = pickerData[row].name
                    print(selectedPicker3)
        case "Picker4"?: selectedPicker4 = pickerData[row].name
                    print(selectedPicker4)
        case "Picker5"?: selectedPicker5 = pickerDataMultiplier[row].name
                    print(selectedPicker5)
        case "Picker6"?: selectedPicker6 = pickerDataTolerance[row].name
                    print(selectedPicker6)
        default:
            //            print("error")
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row].name
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 26.0)!,NSAttributedStringKey.foregroundColor:UIColor.blue])
        return myTitle
    }
    /* less conservative memory version
     func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
     let pickerLabel = UILabel()
     let titleData = pickerData[row]
     let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
     pickerLabel.attributedText = myTitle
     //color  and center the label's background
     let hue = CGFloat(row)/CGFloat(pickerData.count)
     pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
     pickerLabel.textAlignment = .Center
     return pickerLabel
     }
     */
    
    /* better memory management version */
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        var color: UIColor
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
            if (pickerView.accessibilityIdentifier == "Picker3")
            {
                color = pickerDataMultiplier[row].color
            }
            else if (pickerView.accessibilityIdentifier == "Picker4")
            {
                color = pickerDataTolerance[row].color
            }
            else {color = pickerData[row].color}
            pickerLabel?.backgroundColor = color
        }
        return pickerLabel!
        
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

