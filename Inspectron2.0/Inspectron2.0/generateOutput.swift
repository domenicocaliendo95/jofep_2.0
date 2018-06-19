//
//  generateOutput.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico on 10/06/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import Foundation
import CoreImage

class GenerateOutput: ViewController{
    
    
    
    func resistorBody(colours_string: [String]) -> String{ //Ho una funzione che prende in ingresso un array di colori (di tipo String), ovvero quello generato dalla funzione whatColorIsIt
//        Inizio ad analizzare l'array, ottenendo la sua dimensione, settando così i contatori di inizio e di fine
        var arrayOfColours = colours_string
        let first = 0
        let last = arrayOfColours.count-1
        
//         inizializzo dei contatori per i colori che potrebbero essere presenti sulla resistenza. Inizializzo il body color
        
        var countBlue = 0
        var countBlack = 0
        var countYellow = 0
        var countRed = 0
        var countBrown = 0
        var countPurple = 0
        var countGreen = 0
        var countWhite = 0
        var countOrange = 0
        var countSilver = 0
        var countGold = 0
        var countGrey = 0
        

        var countTurquoise = 0
        var countBeige = 0

        

        var bodyColor: String
        
//        con un ciclo for scorro tutto l'array di colori e inserisco ogni colore nel proprio contatore, così da avere una mappatura completa
        for i in stride(from: first, to: last, by: 1){
            if(arrayOfColours[i] == "blue"){
                countBlue = countBlue + 1
            }else if(arrayOfColours[i] == "black"){
                countBlack = countBlack + 1
            }else if(arrayOfColours[i] == "green"){
                countGreen = countGreen + 1
            }else if(arrayOfColours[i] == "yellow"){
                countYellow = countYellow + 1
            }else if(arrayOfColours[i] == "red"){
                countRed = countRed + 1
            }else if(arrayOfColours[i] == "brown"){
                countBrown = countBrown + 1
            }else if(arrayOfColours[i] == "purple"){
                countPurple = countPurple + 1
            }else if(arrayOfColours[i] == "grey"){
                countGrey = countGrey + 1
            }else if(arrayOfColours[i] == "white"){
                countWhite = countWhite + 1
            }else if(arrayOfColours[i] == "orange"){
                countOrange = countOrange + 1
            }else if(arrayOfColours[i] == "silver"){
                countSilver = countSilver + 1
            }else if(arrayOfColours[i] == "gold"){
                countGold = countGold + 1
            }else if(arrayOfColours[i] == "turquoise"){
                countTurquoise = countTurquoise + 1
            }else if(arrayOfColours[i] == "beige"){
                countBeige = countBeige + 1
            }else{
                
            }
        }
   
        
//        Metto i valori in un array, poi trovo il massimo ed il relativo indice, poi ritorno il valore in stringa del colore con maggiori occorrenze
        let bodyArray = [countBlack, countBrown, countRed, countOrange, countYellow, countGreen, countBlue, countPurple, countGrey, countWhite, countSilver, countGold, countTurquoise, countBeige]
        let bodyColorCount = bodyArray.max()
        switch bodyArray.index(of: bodyColorCount!)!+1 {
        case 1:
            return "black"
        case 2:
            return "brown"
        case 3:
            return "red"
        case 4:
            return "orange"
        case 5:
            return "yellow"
        case 6:
            return "green"
        case 7:
            return "blue"
        case 8:
            return "purple"
        case 9:
            return "grey"
        case 10:
            return "white"
        case 11:
            return "silver"
        case 12:
            return "gold"//gold
        case 13:
            return "turquoise"
        case 14:
            return "beige"
        default:
            return "null"
        }
} // fine bodyCalculus
        

        

        

//               ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
//                ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
//                                                                      FLATTENER
//                ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
//                ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
        
        
//        a partire dal secondo elemento, fino al penultimo, effettuo un controllo di "appiattimento" del colore.
//        Se il colore NON è uguale al colore precedente, nè al successivo, prende il colore della banda, dato che mi trovo in situazione di disturbo

    
    func flattener(arrayOfColours: [String], bodyColor: String) -> [String]{
        var arrayOfColours = arrayOfColours
        

        for i in stride(from: arrayOfColours.count-1, to: -1, by: -1){ //All'inverso, perchè se elimino l'elemento corrente avrò sempre un successivo
            if(arrayOfColours[i] == "unknown"){
                arrayOfColours.remove(at: i)
            }
        }
        
      
        
        var last = arrayOfColours.count-1
        
        
        
        for i in stride(from: 2, to: last-1, by: 1){
   
            if((arrayOfColours[i] != arrayOfColours[i-1]) && (arrayOfColours[i] != arrayOfColours[i+1])){
                if(arrayOfColours[i-1] == bodyColor){
                    arrayOfColours[i] = arrayOfColours[i+1]
//                    oppure posso decidere di eliminare quel colore (non saprei, forse così eliminerei un pixel fondamentale)
//                   arrayOfColours.remove(at: i)

                } else if(arrayOfColours[i-1] == arrayOfColours[i-1]){
                   arrayOfColours[i] = arrayOfColours[i-1]
                }
            }


        }
            
        return arrayOfColours
    }//fine flattener
        
        
        
        
        
        
        
//       ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
//        ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
//                                                            INIZIO CONTEGGIO BANDE
//        ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
//        ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
        
        
        
    func bandsCount(arrayOfColours: [String], bodyColor: String) -> [String]{
        
        var arrayOfColours = arrayOfColours
        let first = 0
        let last = arrayOfColours.count-1
        var bandsArray = [String]()//array che verrà restituito, con un elemento per ogni banda colorata che viene trovata
        var curr_colors = [String]() // il colore corrente, con tutti i pixel NON sfondo che vengono inseriti
        var body_counter = 0
        var body_counter_max = 0
        var body_counter_avg = 0

//        Scorro di nuovo tutto l'array
        for i in stride(from: first, to: last, by: 1){
//        Se il mio colore attuale è quello di sfondo, conto le bande di sfondo.
            if(arrayOfColours[i] == bodyColor){
                if(arrayOfColours[i+1] == bodyColor){
                    body_counter = body_counter + 1
                }else{
                    if(body_counter_avg == 0){
                        body_counter_avg = body_counter
                    }else{
                        if(body_counter > 2*body_counter_avg){
                            
                            for i in 1...5{
                                curr_colors.append(bodyColor)
                            }
                            
                        }else{
                            body_counter_avg = (body_counter_avg+body_counter)/2
                        }
                            
                    }
                }
            }else{
                
                curr_colors.append(arrayOfColours[i])
            }
            
            if(arrayOfColours[i+1] == bodyColor && arrayOfColours[i] != bodyColor){
                
                let countedSet = NSCountedSet(array: curr_colors)
                print("ARRAY CONTIENE:")
                print(curr_colors)
                let mostFrequent = countedSet.max{countedSet.count(for: $0) < countedSet.count(for: $1)}
                print("MOST FREQUENT:")
                print(mostFrequent)
                

                
                if(curr_colors.count >= 3){

                    bandsArray.append(mostFrequent as! String)
                    
                }
                curr_colors.removeAll()
                    
                    
            }
        }
        
        for i in stride(from: 0, to: bandsArray.count, by: 1){
            if(bandsArray[i] == "turquoise"){
                bandsArray[i] = "blue"
            }else if(bandsArray[i] == "beige"){
                bandsArray[i] = "gold"
            }
        }
        return bandsArray
    }
    
    

    
}
