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
    

    //seleziona numero di bande premendo +/-
    @IBAction func addRemoveBand(_ sender: UIStepper) {
        
        bandsNumber.text = String(Int(sender.value))+" Bands"
        disablePickers(bands: Int(sender.value))
        
        //BOTTONE ANIMATO
        UIStepper.animate(withDuration: 0.07,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.98, y: 0.94)
        },
                         completion: { finish in
                            UIStepper.animate(withDuration: 0.07, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
        })
        
       
    }
    
    @IBOutlet var outputTolerance: UILabel!
    @IBOutlet var outputValue: UILabel!
    @IBOutlet var bandsNumber: UILabel!
    @IBOutlet var outputTCR: UILabel!
    @IBOutlet var upperText: UILabel!
    
    
    
    //picker
    @IBOutlet var picker1: UIPickerView!
    @IBOutlet var picker2: UIPickerView!
    @IBOutlet var picker3: UIPickerView!
    @IBOutlet var picker4: UIPickerView!
    @IBOutlet var picker5: UIPickerView!
    @IBOutlet var picker6: UIPickerView!
    
    //label con i valori
    @IBOutlet var digit1: UILabel!
    @IBOutlet var digit2: UILabel!
    @IBOutlet var digit3: UILabel!
    @IBOutlet var labelMultiplier: UILabel!
    @IBOutlet var labelTolerance: UILabel!
    @IBOutlet var labelTCR: UILabel!
    
    //label per le etichette
    @IBOutlet var etichettaD1: UILabel!
    @IBOutlet var etichettaD2: UILabel!
    @IBOutlet var etichettaD3: UILabel!
    @IBOutlet var etichettaMultiplier: UILabel!
    @IBOutlet var etichettaTolerance: UILabel!
    @IBOutlet var etichettaTCR: UILabel!
    

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
    var pickerDataTCR: [NamedColor] = []
    
    var selectedPicker1, selectedPicker2, selectedPicker3, selectedPicker4, selectedPicker5, selectedPicker6: String!

    /*#########################inizio viewDidLoad#########################*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.etichettaD1.layer.cornerRadius = 3//etichetta D1 arrotondata
        self.etichettaD2.layer.cornerRadius = 3//etichetta D2 arrotondata
        self.etichettaD3.layer.cornerRadius = 3//etichetta D3 arrotondata
        self.etichettaMultiplier.layer.cornerRadius = 3//etichetta Multiplier arrotondata
        self.etichettaTolerance.layer.cornerRadius = 3//etichetta Tolerance arrotondata
        self.etichettaTCR.layer.cornerRadius = 3//etichetta TCR arrotondata
        
        self.digit1.layer.cornerRadius = 3//label digit1 arrotondata
        self.digit1.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)//label digit1 bordo arancione
        self.digit1.layer.borderWidth = 1//label digit1 spessore bordo
        
        self.digit2.layer.cornerRadius = 3//label digit2 arrotondata
        self.digit2.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)//label digit2 bordo arancione
        self.digit2.layer.borderWidth = 1//label digit2 spessore bordo
        
        self.digit3.layer.cornerRadius = 3//label digit3 arrotondata
        self.digit3.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)//label digit3 bordo arancione
        self.digit3.layer.borderWidth = 1//label digit3 spessore bordo

        self.labelMultiplier.layer.cornerRadius = 3//labelMultiplier arrotondata
        self.labelMultiplier.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)//labelMultiplier bordo arancione
        self.labelMultiplier.layer.borderWidth = 1//labelMultiplier spessore bordo
        
        self.labelTolerance.layer.cornerRadius = 3//labelTolerance arrotondata
        self.labelTolerance.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)//labelTolerance bordo arancione
        self.labelTolerance.layer.borderWidth = 1//labelTolerance spessore bordo
        
        self.labelTCR.layer.cornerRadius = 3//labelTCR arrotondata
        self.labelTCR.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)//labelTCR bordo arancione
        self.labelTCR.layer.borderWidth = 1//labelTCR spessore bordo
        
        //colori
        let brown =  #colorLiteral(red: 0.5616386027, green: 0.4023959335, blue: 0.2233105485, alpha: 1)
        let black =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let orange = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        let yellow = #colorLiteral(red: 1, green: 0.9638280272, blue: 0.06725924462, alpha: 1)
        let green =  #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        let blue =   #colorLiteral(red: 0, green: 0.3738567995, blue: 1, alpha: 1)
        let violet = #colorLiteral(red: 0.5465450394, green: 0, blue: 1, alpha: 1)
        let grey =   #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let white =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let gold =   #colorLiteral(red: 0.8549019608, green: 0.6549019608, blue: 0.1254901961, alpha: 1)
        let silver = #colorLiteral(red: 0.7977497578, green: 0.7977686524, blue: 0.7977585196, alpha: 1)
        let red =    #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        picker1.tintColor=UIColor.clear
        picker2.tintColor=UIColor.clear
        picker3.tintColor=UIColor.clear
        picker4.tintColor=UIColor.clear
        picker5.tintColor=UIColor.clear
        picker6.tintColor=UIColor.clear
        
        //set color selected to default
        selectedPicker1 = "Black"
        selectedPicker2 = "Black"
        selectedPicker3 = "Black"
        selectedPicker4 = "Silver"
        selectedPicker5 = "Silver"
        selectedPicker6 = "Black"
        
        //picker1, picker2, picker3
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
        
        //picker4
        pickerDataMultiplier = [
            NamedColor(name: "Silver", color: silver),
            NamedColor(name: "Gold", color: gold),
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
        
        //picker5
        pickerDataTolerance = [
            NamedColor(name: "Silver", color: silver),
            NamedColor(name: "Gold", color: gold),
            NamedColor(name: "Red", color: red),
            NamedColor(name: "Brown", color: brown),
            NamedColor(name: "Green", color: green),
            NamedColor(name: "Blue", color: blue),
            NamedColor(name: "Violet", color: violet)]
        
        //picker6
        pickerDataTCR = [
            NamedColor(name: "Black", color: black),
            NamedColor(name: "Brown", color: brown),
            NamedColor(name: "Red", color: red),
            NamedColor(name: "Yellow", color: yellow),
            NamedColor(name: "Green", color: green),
            NamedColor(name: "Orange", color: orange),
            NamedColor(name: "Blue", color: blue),
            NamedColor(name: "Violet", color: violet),
            NamedColor(name: "Grey", color: grey)]
        
        //picker1.dataSource = pickerData as? UIPickerViewDataSource
        //Do any additional setup after loading the view, typically from a nib.
        
        
    }

    //restituisce il valore del picker in INT in base al colore, valido per picker 1, 2 e 3!
    func valueBandFromColor (color: String) -> Int {
        
        var value: Int = 0
        
        switch color {
        case "Black": value = 0
        case "Brown": value = 1
        case "Red": value = 2
        case "Orange": value = 3
        case "Yellow": value = 4
        case "Green": value = 5
        case "Blue": value = 6
        case "Violet": value = 7
        case "Grey": value = 8
        case "White": value = 9
        default:
            break
        }
        
        return value
    }//fine valueBandFromColor
    
    //restituisce il valore del picker in STRING (da mostrare a video) in base al colore, valido per picker 1, 2 e 3!
    func valueBandFromColorString (color: String) -> String {
        
        var value: String = "0"
        
        switch color {
        case "Black": value = "0"
        case "Brown": value = "1"
        case "Red": value = "2"
        case "Orange": value = "3"
        case "Yellow": value = "4"
        case "Green": value = "5"
        case "Blue": value = "6"
        case "Violet": value = "7"
        case "Grey": value = "8"
        case "White": value = "9"
        default:
            break
        }
        
        return value
    }//fine valueBandFromColorString
    
    //restituisce il valore del picker in DOUBLE in base al colore, valido per il picker Multiplier
    func valueMultiplierFromColor (color: String) -> Double
    {
        var value: Double = 0.01
        
        switch color {
        case "Black": value = 1
        case "Brown": value = 10
        case "Red": value = 100
        case "Orange": value = 1000
        case "Yellow": value = 10000
        case "Green": value = 100000
        case "Blue": value = 1000000
        case "Violet": value = 10000000
        case "Grey": value = 100000000
        case "White": value = 1000000000
        case "Gold": value = 0.1
        case "Silver": value = 0.01
        default:
            break
        }
        
        return value
    }//fine valueMultiplierFromColor
    
    //restituisce il valore del picker in STRING in base al colore, valido per il picker Multiplier
    func valueMultiplierFromColorString (color: String) -> String
    {
        var value: String = "0.01"
        
        switch color {
        case "Black": value = "1"
        case "Brown": value = "10"
        case "Red": value = "100"
        case "Orange": value = "10^3"
        case "Yellow": value = "10^4"
        case "Green": value = "10^5"
        case "Blue": value = "10^6"
        case "Violet": value = "10^7"
        case "Grey": value = "10^8"
        case "White": value = "10^9"
        case "Gold": value = "0.1"
        case "Silver": value = "0.01"
        default:
            break
        }
        
        return value
    }//fine valueMultiplierFromColorString
    
    //restituisce il valore del picker in STRING in base al colore, valido per il picker Tolerance
    func valueToleranceFromColor (color: String) -> String
    {
        var value: String = "± 10%"
        
        switch color {
        case "Brown": value = "± 1%"
        case "Red": value = "± 2%"
        case "Green": value = "± 0.5%"
        case "Blue": value = "± 0.25%"
        case "Violet": value = "± 0.10%"
        case "Grey": value = "± 0.05%"
        case "Gold": value = "± 5%"
        case "Silver": value = "± 10%"
        default:
            break
        }
        
        return value
    }//fine valueToleranceFromColor
    
    //restituisce il valore del picker in STRING (per la stampa in label) in base al colore, valido per il picker Tolerance
    func valueToleranceFromColorString (color: String) -> String
    {
        var value: String = "10%"
        
        switch color {
        case "Brown": value = "1%"
        case "Red": value = "2%"
        case "Green": value = "0.5%"
        case "Blue": value = "0.25%"
        case "Violet": value = "0.10%"
        case "Grey": value = "0.05%"
        case "Gold": value = "5%"
        case "Silver": value = "10%"
        default:
            break
        }
        
        return value
    }//fine valueToleranceFromColorString
    
    //restituisce il valore del picker in STRING in base al colore, valido per il picker Tolerance
    func valueTCRFromColor (color: String) -> String{
        
        var value: String = "250 ppm/°C"
        
        switch color {
        case "Black": value = "250 ppm/°C"
        case "Brown": value = "100 ppm/°C"
        case "Red": value = "50 ppm/°C"
        case "Yellow": value = "25 ppm/°C"
        case "Green": value = "20 ppm/°C"
        case "Orange": value = "15 ppm/°C"
        case "Blue": value = "10 ppm/°C"
        case "Violet": value = "5 ppm/°C"
        case "Grey": value = "1 ppm/°C"

        default:
            break
        }
        
        return value
    }//fine valueTCRFromColor
    
    //restituisce il valore del picker in STRING (per la stampa in label) in base al colore, valido per il picker Tolerance
    func valueTCRFromColorString (color: String) -> String{
        
        var value: String = "250"
        
        switch color {
        case "Black": value = "250"
        case "Brown": value = "100"
        case "Red": value = "50"
        case "Yellow": value = "25"
        case "Green": value = "20"
        case "Orange": value = "15"
        case "Blue": value = "10"
        case "Violet": value = "5"
        case "Grey": value = "1"
            
        default:
            break
        }
        
        return value
    }//fine valueTCRFromColorString
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.accessibilityIdentifier == "Picker4")
        {
            return pickerDataMultiplier.count
        }
        if (pickerView.accessibilityIdentifier == "Picker5")
        {
            return pickerDataTolerance.count
        }
        if (pickerView.accessibilityIdentifier == "Picker6")
        {
            return pickerDataTCR.count
        }
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.accessibilityIdentifier == "Picker4")
        {
            return pickerDataMultiplier[row].name
        }
        if (pickerView.accessibilityIdentifier == "Picker5")
        {
            return pickerDataTolerance[row].name
        }
        if (pickerView.accessibilityIdentifier == "Picker6")
        {
            return pickerDataTCR[row].name
        }
        return pickerData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(pickerView.accessibilityIdentifier!)
        {
            
        case "Picker1": selectedPicker1 = pickerData[row].name
                    print(selectedPicker1)
                    calculateValue()//aggiorna il valore appena scrollo il picker
                    self.digit1.text = valueBandFromColorString(color: selectedPicker1)
            
        case "Picker2": selectedPicker2 = pickerData[row].name
                    print(selectedPicker2)
                    calculateValue()//aggiorna il valore appena scrollo il picker
                    self.digit2.text = valueBandFromColorString(color: selectedPicker2)
            
        case "Picker3": selectedPicker3 = pickerData[row].name
                    print(selectedPicker3)
                    calculateValue()//aggiorna il valore appena scrollo il picker
                    self.digit3.text = valueBandFromColorString(color: selectedPicker3)
            
        case "Picker4": selectedPicker4 = pickerDataMultiplier[row].name
                    print(selectedPicker4)
                    calculateValue()//aggiorna il valore appena scrollo il picker
                    self.labelMultiplier.text = valueMultiplierFromColorString(color: selectedPicker4)
            
        case "Picker5": selectedPicker5 = pickerDataTolerance[row].name
                    print(selectedPicker5)
                    calculateValue()//aggiorna il valore appena scrollo il picker
                    self.labelTolerance.text = valueToleranceFromColorString(color: selectedPicker5)
            
        case "Picker6": selectedPicker6 = pickerDataTCR[row].name
                    print(selectedPicker6)
                    calculateValue()//aggiorna il valore appena scrollo il picker
                    self.labelTCR.text = valueTCRFromColorString(color: selectedPicker6)
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row].name
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 26.0)!,NSAttributedStringKey.foregroundColor:UIColor.blue])
        return myTitle
    }

    
    /* better memory management version */
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        var color: UIColor
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
            if (pickerView.accessibilityIdentifier == "Picker4")
            {
                color = pickerDataMultiplier[row].color
            }
            else if (pickerView.accessibilityIdentifier == "Picker5")
            {
                color = pickerDataTolerance[row].color
            }
            else if (pickerView.accessibilityIdentifier == "Picker6")
            {
                color = pickerDataTCR[row].color
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
    
    
    func disablePickers(bands: Int){
        
            //controllo outputTCR e outputTolerance
            if(bands == 6){
                    self.outputTCR.alpha = 0
                    self.outputTCR.isHidden = false
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        self.outputTCR.alpha = 1
                    }, completion: {
                        finished in
                        self.outputTCR.isHidden = false
                    })
            }//fine if 6 bande
            
            if(bands == 5){
                self.outputTCR.alpha = 1
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.outputTCR.alpha = 0
                }, completion: {
                    finished in
                    self.outputTCR.isHidden = true
                })
            }//fine if 5 bande
            
            if(bands == 4){
                self.outputTCR.isHidden = true
                self.outputTolerance.isHidden = false
                //self.outputTolerance.alpha = 0

                UIView.animate(withDuration: 0.5, animations: {
                    self.outputTolerance.alpha = 1
                }, completion: {
                    finished in
                    self.outputTolerance.isHidden = false
                })
            }//fine if 4 bande
            
            if(bands == 3){
                self.outputTCR.isHidden = true
                self.outputTolerance.alpha = 1
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.outputTolerance.alpha = 0
                }, completion: {
                    finished in
                    self.outputTolerance.isHidden = true
                })
            }//fine if 3 bande
        
        //if per tutte le label ed etichette
        if(bands == 6){
            //self.outputTCR.isHidden = false
            self.picker6.isHidden = false
            self.picker3.isHidden = false
            self.picker5.isHidden = false
            self.digit3.isHidden = false
            self.labelMultiplier.isHidden = false
            self.labelTolerance.isHidden = false
            self.labelTCR.isHidden = false
            self.etichettaMultiplier.isHidden = false
            self.etichettaTolerance.isHidden = false
            self.etichettaTCR.isHidden = false
            self.etichettaD3.isHidden = false
            self.resetPickers()
        }
        
        if(bands == 5){
            //self.outputTCR.isHidden = true
            self.picker6.isHidden = true
            self.picker3.isHidden = false
            self.picker5.isHidden = false
            self.digit3.isHidden = false
            self.labelMultiplier.isHidden = false
            self.labelTolerance.isHidden = false
            self.labelTCR.isHidden = true
            self.etichettaMultiplier.isHidden = false
            self.etichettaTolerance.isHidden = false
            self.etichettaTCR.isHidden = true
            self.etichettaD3.isHidden = false
            self.resetPickers()

        }
        if(bands == 4){
            //self.outputTCR.isHidden = true
            self.picker6.isHidden = true
            self.picker3.isHidden = true
            self.picker5.isHidden = false
            self.labelMultiplier.isHidden = false
            self.labelTolerance.isHidden = false
            self.labelTCR.isHidden = true
            self.digit3.isHidden = true
            self.etichettaMultiplier.isHidden = false
            self.etichettaTolerance.isHidden = false
            self.etichettaTCR.isHidden = true
            self.etichettaD3.isHidden = true
            self.resetPickers()
        }
        
        if(bands == 3){
            //self.outputTCR.isHidden = true
            self.picker6.isHidden = true
            self.picker3.isHidden = true
            self.picker5.isHidden = true
            self.labelMultiplier.isHidden = false
            self.labelTolerance.isHidden = true
            self.labelTCR.isHidden = true
            self.digit3.isHidden = true
            self.etichettaMultiplier.isHidden = false
            self.etichettaTolerance.isHidden = true
            self.etichettaTCR.isHidden = true
            self.etichettaD3.isHidden = true
            self.resetPickers()
        }
    
    }//fine disablePickers
    
    func resetPickers(){
        selectedPicker1.removeAll()
        picker1.selectRow(0, inComponent: 0, animated: true)
        self.digit1.text = valueBandFromColorString(color: selectedPicker1)

        
        selectedPicker2.removeAll()
        picker2.selectRow(0, inComponent: 0, animated: true)
        self.digit2.text = valueBandFromColorString(color: selectedPicker2)

        
        selectedPicker3.removeAll()
        picker3.selectRow(0, inComponent: 0, animated: true)
        self.digit3.text = valueBandFromColorString(color: selectedPicker3)

        
        selectedPicker4.removeAll()
        picker4.selectRow(0, inComponent: 0, animated: true)
        self.labelMultiplier.text = valueMultiplierFromColorString(color: selectedPicker4)
        
        selectedPicker5.removeAll()
        picker5.selectRow(0, inComponent: 0, animated: true)
        self.labelTolerance.text = valueToleranceFromColorString(color: selectedPicker5)
        
        selectedPicker6.removeAll()
        picker6.selectRow(0, inComponent: 0, animated: true)
        self.labelTCR.text = valueTCRFromColorString(color: selectedPicker6)
        
        calculateValue()
    }
    
    func calculateValue(){
        let band1 = valueBandFromColor(color: selectedPicker1)
        let band2 = valueBandFromColor(color: selectedPicker2)
        let band3 = valueBandFromColor(color: selectedPicker3)
        let band4 = valueMultiplierFromColor(color: selectedPicker4)
        let band5 = valueToleranceFromColor(color: selectedPicker5)
        let band6 = valueTCRFromColor(color: selectedPicker6)
        
        let n = Double ("\(band1)\(band2)\(band3)")!
        let finalVal = n*band4
        
        if (finalVal < 1000)
        {
            outputValue.text = String (format: "%g", finalVal) + " Ω"
            outputTolerance.text = "\(band5)"
            outputTCR.text = "\(band6)"
        }
        else
            if (finalVal >= 1000) && (finalVal < 1000000)
            {
                outputValue.text = String (format: "%g", finalVal/1000) + " KΩ"
                outputTolerance.text = "\(band5)"
                outputTCR.text = "\(band6)"
            }
            else
                if (finalVal >= 1000000)
                {
                    outputValue.text = String (format: "%g", finalVal/1000000) + " MΩ"
                    outputTolerance.text = "\(band5)"
                    outputTCR.text = "\(band6)"
        }
    }

    

}//fine class resistor

