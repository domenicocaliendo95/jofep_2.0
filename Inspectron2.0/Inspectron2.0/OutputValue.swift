//
//  OutputValue.swift
//  Inspectron2.0
//
//  Created by Gemito Gennaro on 13/06/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import Foundation

class OutputValue: ViewController{
//    ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
//    ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞Funzione di generazione output∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
//    ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
    
    
    func generateOutputValue(arrayBands: [String]) -> String {
        
        var arrayBands = arrayBands

        var valueResult: String = "" //setto una variabile di ritorno, string, vuota.
        let array = arrayBands // importo l'array nella funzione
        let numberOfBands = arrayBands.count //il numero di elementi nell'array di bande è uguale al numero di bande in resistenza
        let first = 0 //primo indice di array
        var color: String //colore attuale, usato nel for
        var digits: Int = 0 //contatore delle digits durante il calcolo.
        var values = [Int]() //array dei valori acquisiti
        var multiplierIndex: Int = 0
        var toleranceIndex: Int = 0
        var tcrIndex: Int = 0
        var multiplierValue: Double = 0.00
        var toleranceValue: String = ""
        var tcrValue: Double = 0.00
        
        
    
        
        
        //IMPOSTO TUTTI GLI INDICI CON I VALORI DELLE DIGITS, MULTIPLIER, TOLERANCE E TCR
        if(numberOfBands == 3){
            digits = 2
            multiplierIndex = 2
            toleranceIndex = 0
            tcrIndex = 0
        }else if(numberOfBands == 4){
            digits = 2
            multiplierIndex = 2
            toleranceIndex = 3
            tcrIndex = 0
        }else if(numberOfBands == 5){
            digits = 3
            multiplierIndex = 3
            toleranceIndex = 4
            tcrIndex = 0
        }else if(numberOfBands == 6){
            digits = 3
            multiplierIndex = 3
            toleranceIndex = 4
            tcrIndex = 5
        }else if (numberOfBands < 3 || numberOfBands > 6){
            return "ERROR"
        }
        
        

        
        //scorro tutto l'array di bande e inserisco il valore in ogni
        for i in stride(from: 0, to: digits, by: 1){
            
            color = array[i]
            
            switch color {
            case "black": values.append(0)
            case "brown": values.append(1)
            case "red": values.append(2)
            case "orange": values.append(3)
            case "yellow": values.append(4)
            case "green": values.append(5)
            case "blue": values.append(6)
            case "purple": values.append(7)
            case "grey": values.append(8)
            case "white": values.append(9)
            default:
                break
            
            }
        }
        //fine catalogazione array di digits
        
        
        var resistorValue: Double = 0.00
        
        //RENDO L'ARRAY DI VALORI UN SOLO VALORE
        if(values.count == 2){
//            resistorValue = Double(Int("\(values[0])\(values[1])")!)
            resistorValue = Double(String(values[0])+String(values[1]))!
        }else if(values.count == 3){
//            resistorValue = Double ("\(values[0])\(values[1])\(values[2])")!
            resistorValue = Double(String(values[0])+String(values[1])+String(values[2]))!
        }
        
        print("resistor value")
        print(resistorValue)
        print("values")
        print(values)
        
        //INIZIO CATALOGAZIONE MULTIPLIER
        
        var multiplierString = array[multiplierIndex]
        
        
        switch multiplierString {
        case "black": multiplierValue = 1
        case "brown": multiplierValue = 10
        case "red": multiplierValue = 100
        case "orange": multiplierValue = 1000
        case "yellow": multiplierValue = 10000
        case "green": multiplierValue = 100000
        case "blue": multiplierValue = 1000000
        case "purple": multiplierValue = 10000000
        case "grey": multiplierValue = 100000000
        case "white": multiplierValue = 1000000000
        case "gold": multiplierValue = 0.1
        case "silver": multiplierValue = 0.01
        default:
            break
        }
        //FINE INSERIMENTO MULTIPLIER
        
        
        
        
        
        
        //INIZIO CATALOGAZIONE TOLERANCE
        if(toleranceIndex != 0){
            var toleranceString = array[toleranceIndex]
            
        
            switch toleranceString{
            case "brown": toleranceValue = "± 1%"
            case "red": toleranceValue = "± 2%"
            case "green": toleranceValue = "± 0.5%"
            case "blue": toleranceValue = "± 0.25%"
            case "purple": toleranceValue = "± 0.10%"
            case "grey": toleranceValue = "± 0.05%"
            case "gold": toleranceValue = "± 5%"
            case "silver": toleranceValue = "± 10%"
            default:
                break
            }
        }
        //FINE CATALOGAZIONE TOLERANCE
        
        
        
        
        
        //INIZIO CATALOGAZIONE TCR
        if(tcrIndex != 0){
            var tcrString = array[tcrIndex]
            
            
            switch tcrString {
            case "black": tcrValue = 250
            case "brown": tcrValue = 100
            case "red": tcrValue = 50
            case "yellow": tcrValue = 25
            case "green": tcrValue = 20
            case "orange": tcrValue = 15
            case "blue": tcrValue = 10
            case "purple": tcrValue = 5
            case "grey": tcrValue = 1
            
            default:
                break
            }
        }
        //FINE CATALOGAZIONE TCR
        
        
        
        
        //ADESSO HO TRE VARIABILI DEL TIPO
//        resistorValue, multiplierValue, toleranceValue, tcrValue
        
        // DIVIDO IN CASI IL CALCOLO.
        
        tcrValue = tcrValue*0.000001
        var finalVal = resistorValue*multiplierValue
        var finalTCR = finalVal*Double(tcrValue)
        var toleranceResult: String = ""
        var stringFinalTCR = ""
        
        //RIDUZIONE IN UNITA' DI MISURA ADATTA
        
        
        
      
        // UNITA' DI MISURA PER LA FINALTCR
        if(tcrIndex != 0){
        if(finalTCR < 0.001){
            stringFinalTCR = String(format: "%g", finalTCR * 1000000) + " μΩ \n ppm/°C"
        }else if(finalTCR < 1 && finalTCR >= 0.001){
            stringFinalTCR = String(format: "%g", finalTCR * 1000) + " mΩ \n ppm/°C"
        }else if (finalTCR < 1000 && finalTCR >= 1){
            stringFinalTCR = String(format: "%g", finalTCR) + " Ω \n ppm/°C"
        }else if(finalTCR >= 1000 && finalTCR < 1000000){
            stringFinalTCR = String(format: "%g", finalTCR / 1000) + " KΩ \n ppm/°C"
        }else if(finalTCR >= 1000000 && finalTCR < 1000000000){
            stringFinalTCR = String(format: "%g", finalTCR / 1000000) + " MΩ \n ppm/°C"
        }else if(finalTCR > 1000000000){
            stringFinalTCR = String(format: "%g", finalTCR / 1000000000) + " GΩ \n ppm/°C"
        }
        }
        
       
        
        
        
        
        if (toleranceIndex == 0){
            toleranceValue = ""
        }
        
        
        
        
        
        if (finalVal < 1000)
        {
            valueResult = String(format: "%g", finalVal) + " Ω"
            toleranceResult = "\(toleranceValue)"
            stringFinalTCR = "± \(stringFinalTCR)"
        }
        else
            if (finalVal >= 1000) && (finalVal < 1000000)
            {
                valueResult = String (format: "%g", finalVal/1000) + " KΩ"
                toleranceResult = "\(toleranceValue)"
                stringFinalTCR = "± \(stringFinalTCR)"
            }
            else
                if (finalVal >= 1000000) && (finalVal < 1000000000)
                {
                    valueResult = String (format: "%g", finalVal/1000000) + " MΩ"
                    toleranceResult = "\(toleranceValue)"
                    stringFinalTCR = "± \(stringFinalTCR)"
                }
                else
                    if (finalVal >= 1000000000)
                    {
                        valueResult = String (format: "%g", finalVal/1000000000) + " GΩ"
                        toleranceResult = "\(toleranceValue)"
                        stringFinalTCR = "± \(stringFinalTCR)"
        }
        
        
        
        print(String(valueResult) + " " + String(toleranceResult) + " " + String(stringFinalTCR))
        if(finalTCR == 0){
            if(toleranceResult == ""){
                return String(valueResult)
            }
            return String(valueResult) + " " + String(toleranceResult)
        }
        
        return String(valueResult) + " " + String(toleranceResult) + "\n " + String(stringFinalTCR)
    }//fine funzione
    
    
    
}//Fine classe OutputValue
