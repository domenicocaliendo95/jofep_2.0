//
//  ColorClassification.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico on 08/06/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import Foundation
import CoreImage
import UIKit
import CoreML
import Vision


class ColorClassification: ViewController{
    
    private let context = CIContext()
    
    func whatColorIsIt(Red: Int, Green: Int, Blue: Int) -> String{
        let R: Int = Red
        let G: Int = Green
        let B: Int = Blue
        
        print(String(R) + " " + String(G) + " " + String(B))
        print(" ")
        
        
        if(R < 50 && ((R < (G+5)) && ( R > (G-5))) && ((G<(B+5) && (G>B-5)))){
            return "black"
        }else if(R >= 50 && R < 230 && ((R < (G+5)) && ( R > (G-5))) && ((G<(B+5) && (G>B-5)))){
            return "grey"
        }else if(R>=0&&R<26){
            if(G>=0&&G<26){
                if(B>=0&&B<26){
                    return "black"
                }else if(B>=26&&B<77){
                    return "black" //midnight blue
                }else if(B>=77&&B<128){
                    return "blue" //navy
                }else if(B>=128&&B<179){
//                    return "new midnight blue"
                    return "blue"
                }else if(B>=179&&B<230){
//                    return "medium blue"
                    return "blue"
                }else if(B>=230&&B<256){
                    return "blue"
                }
            }else if(G>=26&&G<77){
                if(B>=0&&B<26){
//                    return "myrtle" NON SAPPIAMO CHE COLORE E'
                    return "black"
                }else if(B>=26&&B<77){
//                    return "cyprus"
                    return "black"
                }else if(B>=77&&B<128){
//                    return "prussian blue"
                    return "blue"
                }else if(B>=128&&B<179){
//                    return "smalt"
                    return "blue"
                }else if(B>=179&&B<230){
//                    return "persian blue"
                    return "blue"
                }else if(B>=230&&B<256){
                    return "blue"
                }
            }else if(G>=77&&G<128){
                if(B>=0&&B<26){
                    return "green"
                }else if(B>=26&&B<77){
//                    return "fun green"
                    return "green"
                }else if(B>=77&&B<128){
//                    return "mosque" Non sappiamo che colore è
                    return "blue"
                }else if(B>=128&&B<179){
//                    return "cerulean"
                    return "blue"
                }else if(B>=179&&B<230){
//                    return "navy blue"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "navy blue"
                    return "blue"
                }
            }else if(G>=128&&G<179){
                if(B>=0&&B<26){
//                    return "islamic green"
                    return "green"
                }else if(B>=26&&B<77){
//                    return "pigment green"
                    return "green"
                }else if(B>=77&&B<128){
//                    return "shamrick green"
                    return "green"
                }else if(B>=128&&B<179){
//                    return "persian green" NON SAPPIAMO CHE COLORE E'
                    return "blue"
                }else if(B>=179&&B<230){
//                    return "pacific blue"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "dodger blue"
                    return "blue"
                }
            }else if(G>=179&&G<230){
                if(B>=0&&B<26){
//                    return "free speech green"
                    return "green"
                }else if(B>=26&&B<77){
//                    return "dark pastel green"
                    return "green"
                }else if(B>=77&&B<128){
//                    return "malachite"
                    return "green"
                }else if(B>=128&&B<179){
//                    return "carribbean green"
                    return "green"
                }else if(B>=179&&B<230){
//                    return "robin's egg blue"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "deep sky blue"
                    return "blue"
                }
            }else if(G>=230&&G<256){
                if(B>=0&&B<26){
//                    return "lime"
                    return "green"
                }else if(B>=26&&B<77){
//                    return "free speech green"
                    return "green"
                }else if(B>=77&&B<128){
//                    return "spring green"
                    return "green"
                }else if(B>=128&&B<179){
//                    return "medium spring green"
                    return "green"
                }else if(B>=179&&B<230){
//                    return "bright turquoise"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "aqua"
                    return "blue"

                }
            }
        }else if(R>=26&&R<77){
            if(G>=0&&G<26){
                if(B>=0&&B<26){
//                    return "seal bruwn"
                    return "brown"
                }else if(B>=26&&B<77){
//                    return "mardi gras" NON SAPPIAMO COSA E'
                    return "black"
                }else if(B>=77&&B<128){
//                    return "persian indigo"
                    return "blue"
                }else if(B>=128&&B<179){
//                    return "persian indigo"
                    return "blue"
                }else if(B>=179&&B<230){
//                    return "medium blue"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "han purple"
                    return "blue"
                }
            }else if(G>=26&&G<77){
                if(B>=0&&B<26){
//                    return "karaka"
                    return "brown"
                }else if(B>=26&&B<77){
                    if(G>B){
//                        return "seaweed"
                        return "brown"
                    }else if(G<B){
//                        return "violent violet"
                        return "black"
                    }
                }else if(B>=77&&B<128){
//                    return "deep koamaru"
                    return "blue"
                }else if(B>=128&&B<179){
//                    return "dark slate blue"
                    return "blue"
                }else if(B>=179&&B<230){
//                    return "persian blue"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "neon blue"
                    return "blue"
                }
            }else if(G>=77&&G<128){
                if(B>=0&&B<26){
//                    return "verdun green"
                    return "green"
                }else if(B>=26&&B<77){
//                    return "san felix"
                    return "green"
                }else if(B>=77&&B<128){
//                    return "tax break"
                    return "blue"
                }else if(B>=128&&B<179){
//                    return "lochmara"
                    return "blue"
                }else if(B>=179&&B<230){
//                    return "royal blue"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "royal blue"
                    return "blue"
                }
            }else if(G>=128&&G<179){
                if(B>=0&&B<26){
//                    return "la palma"
                    return "green"
                }else if(B>=26&&B<77){
//                    return "forest green"
                    return "blue"
                }else if(B>=77&&B<128){
//                    return "eucalyptus"
                    return "blue"
                }else if(B>=128&&B<179){
//                    return "java"
                    return "blue"
                }else if(B>=179&&B<230){
//                    return "summer sky"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "dodger blue"
                    return "blue"
                }
            }else if(G>=179&&G<230){
                if(B>=0&&B<26){
//                    return "kelly green"
                    return "green"
                }else if(B>=26&&B<77){
//                    return "lime green"
                    return "green"
                }else if(B>=77&&B<128){
//                    return "medium sea green"
                    return "green"
                }else if(B>=128&&B<179){
//                    return "shamrock"
                    return "green"
                }else if(B>=179&&B<230){
//                    return "medium turquoise"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "summer sky"
                    return "blue"
                }
            }else if(G>=230&&G<256){
                if(B>=0&&B<26){
//                    return "harlequin"
                    return "green"
                }else if(B>=26&&B<77){
//                    return "lime green"
                    return "green"
                }else if(B>=77&&B<128){
//                    return "screamin'green"
                    return "green"
                }else if(B>=128&&B<179){
//                    return "medium spring green"
                    return "green"
                }else if(B>=179&&B<230){
//                    return "turquoise"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "aqua"
                    return "blue"
                }
            }
        }else if(R>=77&&R<128){
            if(G>=0&&G<26){
                if(B>=0&&B<25){
                    //  Aggiunto noi
                    return "brown"
                }
                else if(B>=26&&B<52){
//                    return "maroon"
                    return "red"
                }else if(B>=53&&B<77){
//                    return "tyrian purple"
                    return "red"
                }else if(B>=77&&B<128){
                    return "purple"
                }else if(B>=128&&B<179){
//                    return "indigo"
                    return "purple"
                }else if(B>=179&&B<230){
//                    return "purple heart"
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "electric indigo"
                    return "purple"
                }
            }else if(G>=26&&G<77){
                if(B>=0&&B<26){
//                    return "baker's chocolate"
                    return "brown"
                }else if(B>=26&&B<66){
//                    return "persian plum"
                    return "brown"
                }else if(B>=66&&B<86){
                    return "brown"
                }else if(B>=86&&B<128){
//                    return "seance"
                    return "purple"
                }else if(B>=128&&B<179){
//                    return "royal purple"
                    return "purple"
                }else if(B>=179&&B<230){
//                    return "purple heart"
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "han purple"
                    return "purple"
                }
            }else if(G>=77&&G<128){
                if(B>=0&&B<26){
//                    return "olive"
                    return "brown"
                }else if(B>=26&&B<77){
//                    return "verdigris"
                    return "brown"
                    
                }else if(B>=77&&B<128){
                    if(G>B){
//                        return "dingley"
                        return "grey"
                    }else if(G<B){
//                        return "affair"
                        return "brown"
                    }
                }else if(B>=128&&B<179){
//                    return "scampi"
                    return "purple"
                }else if(B>=179&&B<230){
//                    return "slate blue"
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "medium slate blue"
                    return "purple"
                }
            }else if(G>=128&&G<179){
                if(B>=0&&B<26){
//                    return "christi"
                    return "brown"
                }else if(B>=26&&B<77){
//                    return "limeade"
                    return "brown"
                }else if(B>=77&&B<128){
//                    return "laurel"
                    return "blue"
                }else if(B>=128&&B<179){
//                    return "cadet blue"
                    return "blue"
                }else if(B>=179&&B<230){
//                    return "picton blue"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "cornflower blue"
                    return "blue"
                }
            }else if(G>=179&&G<230){
                if(B>=0&&B<26){
//                    return "kelly green"
                    return "green"
                }else if(B>=26&&B<77){
//                    return "apple"
                    return "green"
                }else if(B>=77&&B<128){
//                    return "fern"
                    return "green"
                }else if(B>=128&&B<179){
//                    return "silver tree"
                    return "green"
                }else if(B>=179&&B<230){
//                    return "downy" NON SAPPIAMO
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "maya blue"
                    return "blue"
                }
            }else if(G>=230&&G<256){
                if(B>=0&&B<26){
//                    return "bright green"
                    return "green"
                }else if(B>=26&&B<77){
//                    return "bright green"
                    return "green"
                }else if(B>=77&&B<128){
//                    return "screamin'green"
                    return "green"
                }else if(B>=128&&B<179){
//                    return "light green green"
                    return "green"
                }else if(B>=179&&B<230){
//                    return "acquamarine"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "baby blue"
                    return "blue"
                }
            }
        }else if(R>=128&&R<179){
            if(G>=0&&G<26){
                if(B>=0&&B<26){
//                    return "dark red"
                    return "red"
                }else if(B>=26&&B<77){
//                    return "carmine"
                    return "red"
                }else if(B>=77&&B<128){
//                    return "eggplant"
                    return "red"
                }else if(B>=128&&B<179){
//                    return "dark magenta"
                    return "purple"
                }else if(B>=179&&B<230){
//                    return "dark violet"
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "electric purple"
                    return "purple"
                }
            }else if(G>=26&&G<77){
                if(B>=0&&B<26){
//                    return "saddle brown"
                    return "brown"
                }else if(B>=26&&B<77){
//                    return "milano red"
                    return "red"
                }else if(B>=77&&B<108){
//                    return "lipstick"
                    return "red"
                }else if(B>=108&&B<128){
                    return "purple"
                }else if(B>=128&&B<179){
//                    return "vivid violet"
                    return "purple"
                }else if(B>=179&&B<230){
//                    return "dark orchid"
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "blue violet"
                    return "purple"
                }
            }else if(G>=77&&G<128){
                if(B>=0&&B<26){
//                    return "golden brown"
                    return "brown"
                }else if(B>=26&&B<77){
//                    return "mai tai"
                    return "brown"
                }else if(B>=77&&B<128){
//                    return "copper rose" CHIST PUR O'LEVAMM
                    return "brown"
                }else if(B>=128&&B<179){
//                    return "violet blue" CHIST PUR
                    return "purple"
                }else if(B>=179&&B<230){
//                    return "amethyst"
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "light slate blue"
                    return "purple"
                }
            }else if(G>=128&&G<179){
                if(B>=0&&B<26){
//                    return "citrus"
                    return "gold"
                }else if(B>=26&&B<77){
//                    return "highball"
                    return "gold"
                }else if(B>=77&&B<128){
//                    return "avocado"
                    return "grey"
                }else if(B>=128&&B<179){
                    if(G>B){
//                        return "olivine"
                        return "grey"
                    }else if(G<B){
//                        return "purple mountain's majestry"
                        return "grey"
                    }
                }else if(B>=179&&B<230){
//                    return "blue bell"
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "portage"
                    return "purple"
                }
            }else if(G>=179&&G<230){
                if(B>=0&&B<26){
//                    return "citrus"
                    return "green"
                }else if(B>=26&&B<77){
//                    return "yellow green"
                    return "green"
                }else if(B>=77&&B<128){
//                    return "olivine"
                    return "green"
                }else if(B>=128&&B<179){
//                    return "dark sea green"
                    return "green"
                }else if(B>=179&&B<230){
//                    return "morning glory"
                    return "blue"
                }else if(B>=230&&B<256){
//                    return "light sky blue"
                    return "blue"
                    
                }
            }else if(G>=230&&G<256){
                if(B>=0&&B<26){
//                    return "spring bud"
                    return "green"
                }else if(B>=26&&B<77){
//                    return "green yellow"
                    return "green"
                }else if(B>=77&&B<128){
//                    return "feijoa"
                    return "green"
                }else if(B>=128&&B<179){
//                    return "mint green"
                    return "green"
                }else if(B>=179&&B<230){
//                    return "magic mint" LEV LEV
                }else if(B>=230&&B<256){
//                    return "electric blue"
                    return "blue"
                }
            }
        }else if(R>=179&&R<230){
            if(G>=0&&G<26){
                if(B>=0&&B<26){
//                    return "free speech red"
                    return "red"
                }else if(B>=26&&B<77){
//                    return "crimson"
                    return "red"
                }else if(B>=77&&B<128){
//                    return "ruby"
                    return "red"
                }else if(B>=128&&B<179){
//                    return "medium violet red"
                    return "purple"
                }else if(B>=179&&B<230){
//                    return "deep magenta"
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "electric purple"
                    return "purple"
                }
            }else if(G>=26&&G<77){
                if(B>=0&&B<26){
//                    return "harley davidson orange"
                    return "brown"
                }else if(B>=26&&B<77){
//                    return "persian red"
                    return "red"
                }else if(B>=77&&B<128){
//                    return "cerise"
                    return "red"
                }else if(B>=128&&B<179){
//                    return "deep cerise"
                    return "purple"
                }else if(B>=179&&B<230){
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "electric purple"
                    return "purple"
                }
            }else if(G>=77&&G<128){
                if(B>=0&&B<26){
//                    return "tenne"
                    return "orange"
                }else if(B>=26&&B<77){
//                    return "ecstasy"
                    return "orange"
                }else if(B>=77&&B<88){
//                    return "indian red"
                    return "red"
                }else if(B>=89&&B<128){
//                    return "indian red"
                    return "red"
                }else if(B>=128&&B<179){
//                    return "hopbush"
                    return "red"
                }else if(B>=179&&B<230){
//                    return "orchid"
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "heliotrope"
                    return "purple"
                }
            }else if(G>=128&&G<179){
                if(B>=0&&B<26){
//                    return "gamboge"
                    return "gold"
                }else if(B>=26&&B<77){
//                    return "fuel yellow"
                    return "gold"
                }else if(B>=77&&B<128){
//                    return "fallow"
                    return "brown"
                }else if(B>=128&&B<179){
//                    return "petite orchid"
                    return "red"
                }else if(B>=179&&B<230){
//                    return "lilac"
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "mauve"
                    return "purple"
                }
            }else if(G>=179&&G<230){
                if(B>=0&&B<26){
//                    return "la rioja"
                    return "yellow"
                }else if(B>=26&&B<77){
//                    return "wattle"
                    return "yellow"
                }else if(B>=77&&B<128){
//                    return "wild willow"
                    return "yellow"
                }else if(B>=128&&B<179){
//                    return "green mist"
                    return "grey"
                }else if(B>=179&&B<230){
                    if(G>B){
//                        return "tea green"
                        return "grey"
                    }else if(G<B){
//                        return "perfume"
                        return "grey"
                    }
                }else if(B>=230&&B<256){
//                    return "lavender blue"
                    return "purple"
                }
            }else if(G>=230&&G<256){
                if(B>=0&&B<26){
//                    return "electric lime"
                    return "yellow"
                }else if(B>=26&&B<77){
//                    return "pear"
                    return "yellow"
                }else if(B>=77&&B<128){
//                    return "mindaro"
                    return "yellow"
                }else if(B>=128&&B<179){
//                    return "reef"
                    return "green"
                }else if(B>=179&&B<230){
//                    return "blue romance"
                    return "green"
                }else if(B>=230&&B<256){
//                    return "light cyan"
                    return "blue"
                }
            }
        }else if(R>=230&&R<256){
            if(G>=0&&G<26){
                if(B>=0&&B<26){
                    return "red"
                }else if(B>=26&&B<77){
//                    return "torch red"
                    return "red"
                }else if(B>=77&&B<128){
//                    return "razzmatass"
                    return "red"
                }else if(B>=128&&B<179){
//                    return "hollywood cerise"
                    return "red"
                }else if(B>=179&&B<230){
//                    return "hot magenta"
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "fuchsia"
                    return "purple"
                }
            }else if(G>=26&&G<77){
                if(B>=0&&B<26){
//                    return "scarlet"
                    return "red"
                }else if(B>=26&&B<77){
//                    return "red orange"
                    return "red"
                }else if(B>=77&&B<128){
//                    return "radical red"
                    return "red"
                }else if(B>=128&&B<179){
//                    return "wild strawberry"
                    return "red"
                }else if(B>=179&&B<230){
//                    return "razzle dazzle rose"
                    return "purple"
                }else if(B>=230&&B<256){
//                    return "magenta"
                    return "purple"
                }
            }else if(G>=77&&G<128){
                if(B>=0&&B<26){
//                    return "safety orange"
                    return "orange"
                }else if(B>=26&&B<77){
//                    return "outrangeous orange"
                    return "orange"
                }else if(B>=77&&B<128){
//                    return "bittersweet"
                    return "red"
                }else if(B>=128&&B<179){
//                    return "brillant rose"
                    return "red"
                }else if(B>=179&&B<230){
//                    return "neon pink"
                    return "red"
                }else if(B>=230&&B<256){
//                    return "pink flamingo"
                    return "purple"
                }
            }else if(G>=128&&G<179){
                if(B>=0&&B<26){
//                    return "orange peel"
                    return "orange"
                }else if(B>=26&&B<77){
//                    return "neon carrot"
                    return "orange"
                }else if(B>=77&&B<128){
//                    return "atomic tangerine"
                    return "orange"
                }else if(B>=128&&B<179){
//                    return "mona lisa"
                    return "red"
                }else if(B>=179&&B<230){
//                    return "carnation pink"
                    return "red"
                }else if(B>=230&&B<256){
                    return "purple"
                }
            }else if(G>=179&&G<230){
                if(B>=0&&B<26){
//                    return "tangerine yellow"
                    return "yellow"
                }else if(B>=26&&B<77){
//                    return "sunglow"
                    return "yellow"
                }else if(B>=77&&B<128){
//                    return "grandis"
                    return "yellow"
                }else if(B>=128&&B<179){
//                    return "peach-orange" NUN CIO METT
                    return "beige"
                }else if(B>=179&&B<230){
//                    return "cosmos"
                    return "red"
                }else if(B>=230&&B<256){
//                    return "snuff"
                    return "purple"
                }
            }else if(G>=230&&G<256){
                if(B>=0&&B<26){
                    return "yellow"
                }else if(B>=26&&B<77){
//                    return "gorse"
                    return "yellow"
                }else if(B>=77&&B<128){
//                    return "laser lemon"
                    return "yellow"
                }else if(B>=128&&B<179){
//                    return "canary"
                    return "yellow"
                }else if(B>=179&&B<230){
//                    return "cream"
                    return "white"
                }else if(B>=230&&B<256){
                    return "white"
                }
            }
        }
        
        return "unknown"
//        return (String(describing: R) + " " + String(describing: G) + " " + String(describing: B))
    
    } // chiusura funzione
    
    
    
    func inspectColor(Red: Int, Green: Int, Blue: Int) -> String{
        
        let r = CGFloat(Red)
        let g = CGFloat(Green)
        let b = CGFloat(Blue)
        let color = CIColor(red: r/255, green: g/255, blue: b/255)
        var result: String = ""
        
        let filter = CIFilter(name: "CIConstantColorGenerator")!
        filter.setValue(color, forKey: "inputColor")
        let pixelImage: UIImage = getImageWithColor(color: UIColor(ciColor: color), size: CGSize(width: CGFloat(10), height: CGFloat(10)), origin_x: 0, origin_y: 0)
        
        
        
        
        guard let model = try? VNCoreMLModel(for: ColorClassificationModel().model) else { return "error"}
        let request = VNCoreMLRequest(model: model){
            (finishedReq, err) in
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
//            guard let firstObservation = results.first else { return }
//            guard let secondObservation = results.last else { return }
            
            
            /*if((firstObservation.confidence >= 10.980000 || secondObservation.confidence >= 10.98000) && (String(firstObservation.identifier) != "Not a resistor")){
                
            }*/
            result = (results.first?.identifier)!
        }
        try? VNImageRequestHandler(ciImage: CIImage(image: pixelImage)!, options: [:]).perform([request])
            

        return result
    }
    
    

    
    
    
}//chiusura classe
