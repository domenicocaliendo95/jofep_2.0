//
//  ColorClassification.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico on 08/06/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import Foundation


class ColorClassification: ViewController{
    
    func whatColorIsIt(Red: Int, Green: Int, Blue: Int) -> String{
        var R: Int = Red
        var G: Int = Green
        var B: Int = Blue
        
        if(R > 25 && R < 230 && R==G && G==B){
            return "grigio"
        }else if(R>=0&&R<26){
            if(G>=0&&G<26){
                if(B>=0&&B<26){
                    return "nero"
                }else if(B>=26&&B<77){
                    return "midnight blue"
                }else if(B>=77&&B<128){
                    return "navy"
                }else if(B>=128&&B<179){
                    return "new midnight blue"
                }else if(B>=179&&B<230){
                    return "medium blue"
                }else if(B>=230&&B<256){
                    return "blu"
                }
            }else if(G>=26&&G<77){
                if(B>=0&&B<26){
                    return "myrtle"
                }else if(B>=26&&B<77){
                    return "cyprus"
                }else if(B>=77&&B<128){
                    return "prussian blue"
                }else if(B>=128&&B<179){
                    return "smalt"
                }else if(B>=179&&B<230){
                    return "persian blue"
                }else if(B>=230&&B<256){
                    return "blue"
                }
            }else if(G>=77&&G<128){
                if(B>=0&&B<26){
                    return "green"
                }else if(B>=26&&B<77){
                    return "fun green"
                }else if(B>=77&&B<128){
                    return "mosque"
                }else if(B>=128&&B<179){
                    return "cerulean"
                }else if(B>=179&&B<230){
                    return "navy blue"
                }else if(B>=230&&B<256){
                    return "navy blue"
                }
            }else if(G>=128&&G<179){
                if(B>=0&&B<26){
                    return "islamic green"
                }else if(B>=26&&B<77){
                    return "pigment green"
                }else if(B>=77&&B<128){
                    return "shamrick green"
                }else if(B>=128&&B<179){
                    return "persian green"
                }else if(B>=179&&B<230){
                    return "pacific blue"
                }else if(B>=230&&B<256){
                    return "dodger blue"
                }
            }else if(G>=179&&G<230){
                if(B>=0&&B<26){
                    return "free speech green"
                }else if(B>=26&&B<77){
                    return "dark pastel green"
                }else if(B>=77&&B<128){
                    return "malachite"
                }else if(B>=128&&B<179){
                    return "carribbean green"
                }else if(B>=179&&B<230){
                    return "robin's egg blue"
                }else if(B>=230&&B<256){
                    return "deep sky blue"
                }
            }else if(G>=230&&G<256){
                if(B>=0&&B<26){
                    return "lime"
                }else if(B>=26&&B<77){
                    return "free speech green"
                }else if(B>=77&&B<128){
                    return "spring green"
                }else if(B>=128&&B<179){
                    return "medium spring green"
                }else if(B>=179&&B<230){
                    return "bright turquoise"
                }else if(B>=230&&B<256){
                    return "aqua"
                }
            }
        }else if(R>=26&&R<77){
            if(G>=0&&G<26){
                if(B>=0&&B<26){
                    return "seal bruwn"
                }else if(B>=26&&B<77){
                    return "mardi gras"
                }else if(B>=77&&B<128){
                    return "persian indigo"
                }else if(B>=128&&B<179){
                    return "persian indigo"
                }else if(B>=179&&B<230){
                    return "medium blue"
                }else if(B>=230&&B<256){
                    return "han purple"
                }
            }else if(G>=26&&G<77){
                if(B>=0&&B<26){
                    return "karaka"
                }else if(B>=26&&B<77){
                    if(G>B){
                        return "seaweed"
                    }else if(G<B){
                        return "violent violet"
                    }
                }else if(B>=77&&B<128){
                    return "deep koamaru"
                }else if(B>=128&&B<179){
                    return "dark slate blue"
                }else if(B>=179&&B<230){
                    return "persian blue"
                }else if(B>=230&&B<256){
                    return "neon blue"
                }
            }else if(G>=77&&G<128){
                if(B>=0&&B<26){
                    return "verdun green"
                }else if(B>=26&&B<77){
                    return "san felix"
                }else if(B>=77&&B<128){
                    return "tax break"
                }else if(B>=128&&B<179){
                    return "lochmara"
                }else if(B>=179&&B<230){
                    return "royal blue"
                }else if(B>=230&&B<256){
                    return "royal blue"
                }
            }else if(G>=128&&G<179){
                if(B>=0&&B<26){
                    return "la palma"
                }else if(B>=26&&B<77){
                    return "forest green"
                }else if(B>=77&&B<128){
                    return "eucalyptus"
                }else if(B>=128&&B<179){
                    return "java"
                }else if(B>=179&&B<230){
                    return "summer sky"
                }else if(B>=230&&B<256){
                    return "dodger blue"
                }
            }else if(G>=179&&G<230){
                if(B>=0&&B<26){
                    return "kelly green"
                }else if(B>=26&&B<77){
                    return "lime green"
                }else if(B>=77&&B<128){
                    return "medium sea green"
                }else if(B>=128&&B<179){
                    return "shamrock"
                }else if(B>=179&&B<230){
                    return "medium turquoise"
                }else if(B>=230&&B<256){
                    return "summer sky"
                }
            }else if(G>=230&&G<256){
                if(B>=0&&B<26){
                    return "harlequin"
                }else if(B>=26&&B<77){
                    return "lime green"
                }else if(B>=77&&B<128){
                    return "screamin'green"
                }else if(B>=128&&B<179){
                    return "medium spring green"
                }else if(B>=179&&B<230){
                    return "turquoise"
                }else if(B>=230&&B<256){
                    return "aqua"
                }
            }
        }else if(R>=77&&R<128){
            if(G>=0&&G<26){
                if(B>=0&&B<26){
                    return "maroon"
                }else if(B>=26&&B<77){
                    return "tyrian purple"
                }else if(B>=77&&B<128){
                    return "purple"
                }else if(B>=128&&B<179){
                    return "indigo"
                }else if(B>=179&&B<230){
                    return "purple heart"
                }else if(B>=230&&B<256){
                    return "electric indigo"
                }
            }else if(G>=26&&G<77){
                if(B>=0&&B<26){
                    return "baker's chocolate"
                }else if(B>=26&&B<77){
                    return "persian plum"
                }else if(B>=77&&B<128){
                    return "seance"
                }else if(B>=128&&B<179){
                    return "royal purple"
                }else if(B>=179&&B<230){
                    return "purple heart"
                }else if(B>=230&&B<256){
                    return "han purple"
                }
            }else if(G>=77&&G<128){
                if(B>=0&&B<26){
                    return "olive"
                }else if(B>=26&&B<77){
                    return "verdigris"
                }else if(B>=77&&B<128){
                    if(G>B){
                        return "dingley"
                    }else if(G<B){
                        return "affair"
                    }
                }else if(B>=128&&B<179){
                    return "scampi"
                }else if(B>=179&&B<230){
                    return "slate blue"
                }else if(B>=230&&B<256){
                    return "medium slate blue"
                }
            }else if(G>=128&&G<179){
                if(B>=0&&B<26){
                    return "christi"
                }else if(B>=26&&B<77){
                    return "limeade"
                }else if(B>=77&&B<128){
                    return "laurel"
                }else if(B>=128&&B<179){
                    return "cadet blue"
                }else if(B>=179&&B<230){
                    return "picton blue"
                }else if(B>=230&&B<256){
                    return "cornflower blue"
                }
            }else if(G>=179&&G<230){
                if(B>=0&&B<26){
                    return "kelly green"
                }else if(B>=26&&B<77){
                    return "apple"
                }else if(B>=77&&B<128){
                    return "fern"
                }else if(B>=128&&B<179){
                    return "silver tree"
                }else if(B>=179&&B<230){
                    return "downy"
                }else if(B>=230&&B<256){
                    return "maya blue"
                }
            }else if(G>=230&&G<256){
                if(B>=0&&B<26){
                    return "bright green"
                }else if(B>=26&&B<77){
                    return "bright green"
                }else if(B>=77&&B<128){
                    return "screamin'green"
                }else if(B>=128&&B<179){
                    return "light green green"
                }else if(B>=179&&B<230){
                    return "acquamarine"
                }else if(B>=230&&B<256){
                    return "baby blue"
                }
            }
        }else if(R>=128&&R<179){
            if(G>=0&&G<26){
                if(B>=0&&B<26){
                    return "dark red"
                }else if(B>=26&&B<77){
                    return "carmine"
                }else if(B>=77&&B<128){
                    return "eggplant"
                }else if(B>=128&&B<179){
                    return "dark magenta"
                }else if(B>=179&&B<230){
                    return "dark violet"
                }else if(B>=230&&B<256){
                    return "electric purple"
                }
            }else if(G>=26&&G<77){
                if(B>=0&&B<26){
                    return "saddle brown"
                }else if(B>=26&&B<77){
                    return "milano red"
                }else if(B>=77&&B<128){
                    return "lipstick"
                }else if(B>=128&&B<179){
                    return "vivid violet"
                }else if(B>=179&&B<230){
                    return "dark orchid"
                }else if(B>=230&&B<256){
                    return "blue violet"
                }
            }else if(G>=77&&G<128){
                if(B>=0&&B<26){
                    return "golden brown"
                }else if(B>=26&&B<77){
                    return "mai tai"
                }else if(B>=77&&B<128){
                    return "copper rose"
                }else if(B>=128&&B<179){
                    return "violet blue"
                }else if(B>=179&&B<230){
                    return "amethyst"
                }else if(B>=230&&B<256){
                    return "light slate blue"
                }
            }else if(G>=128&&G<179){
                if(B>=0&&B<26){
                    return "citrus"
                }else if(B>=26&&B<77){
                    return "highball"
                }else if(B>=77&&B<128){
                    return "avocado"
                }else if(B>=128&&B<179){
                    if(G>B){
                        return "olivine"
                    }else if(G<B){
                        return "purple mountain's majestry"
                    }
                }else if(B>=179&&B<230){
                    return "blue bell"
                }else if(B>=230&&B<256){
                    return "portage"
                }
            }else if(G>=179&&G<230){
                if(B>=0&&B<26){
                    return "citrus"
                }else if(B>=26&&B<77){
                    return "yellow green"
                }else if(B>=77&&B<128){
                    return "olivine"
                }else if(B>=128&&B<179){
                    return "dark sea green"
                }else if(B>=179&&B<230){
                    return "morning glory"
                }else if(B>=230&&B<256){
                    return "light sky blue"
                }
            }else if(G>=230&&G<256){
                if(B>=0&&B<26){
                    return "spring bud"
                }else if(B>=26&&B<77){
                    return "green yellow"
                }else if(B>=77&&B<128){
                    return "feijoa"
                }else if(B>=128&&B<179){
                    return "mint green"
                }else if(B>=179&&B<230){
                    return "magic mint"
                }else if(B>=230&&B<256){
                    return "electric blue"
                }
            }
        }else if(R>=179&&R<230){
            if(G>=0&&G<26){
                if(B>=0&&B<26){
                    return "free speech red"
                }else if(B>=26&&B<77){
                    return "crimson"
                }else if(B>=77&&B<128){
                    return "ruby"
                }else if(B>=128&&B<179){
                    return "medium violet red"
                }else if(B>=179&&B<230){
                    return "deep magenta"
                }else if(B>=230&&B<256){
                    return "electric purple"
                }
            }else if(G>=26&&G<77){
                if(B>=0&&B<26){
                    return "harley davidson orange"
                }else if(B>=26&&B<77){
                    return "persian red"
                }else if(B>=77&&B<128){
                    return "cerise"
                }else if(B>=128&&B<179){
                    return "deep cerise"
                }else if(B>=179&&B<230){
                    return "fuchsia"
                }else if(B>=230&&B<256){
                    return "electric purple"
                }
            }else if(G>=77&&G<128){
                if(B>=0&&B<26){
                    return "tenne"
                }else if(B>=26&&B<77){
                    return "ecstasy"
                }else if(B>=77&&B<128){
                    return "indian red"
                }else if(B>=128&&B<179){
                    return "hopbush"
                }else if(B>=179&&B<230){
                    return "orchid"
                }else if(B>=230&&B<256){
                    return "heliotrope"
                }
            }else if(G>=128&&G<179){
                if(B>=0&&B<26){
                    return "gamboge"
                }else if(B>=26&&B<77){
                    return "fuel yellow"
                }else if(B>=77&&B<128){
                    return "fallow"
                }else if(B>=128&&B<179){
                    return "petite orchid"
                }else if(B>=179&&B<230){
                    return "lilac"
                }else if(B>=230&&B<256){
                    return "mauve"
                }
            }else if(G>=179&&G<230){
                if(B>=0&&B<26){
                    return "la rioja"
                }else if(B>=26&&B<77){
                    return "wattle"
                }else if(B>=77&&B<128){
                    return "wild willow"
                }else if(B>=128&&B<179){
                    return "green mist"
                }else if(B>=179&&B<230){
                    if(G>B){
                        return "tea green"
                    }else if(G<B){
                        return "perfume"
                    }
                }else if(B>=230&&B<256){
                    return "lavender blue"
                }
            }else if(G>=230&&G<256){
                if(B>=0&&B<26){
                    return "electric lime"
                }else if(B>=26&&B<77){
                    return "pear"
                }else if(B>=77&&B<128){
                    return "mindaro"
                }else if(B>=128&&B<179){
                    return "reef"
                }else if(B>=179&&B<230){
                    return "blue romance"
                }else if(B>=230&&B<256){
                    return "light cyan"
                }
            }
        }else if(R>=230&&R<256){
            if(G>=0&&G<26){
                if(B>=0&&B<26){
                    return "red"
                }else if(B>=26&&B<77){
                    return "torch red"
                }else if(B>=77&&B<128){
                    return "razzmatass"
                }else if(B>=128&&B<179){
                    return "hollywood cerise"
                }else if(B>=179&&B<230){
                    return "hot magenta"
                }else if(B>=230&&B<256){
                    return "fuchsia"
                }
            }else if(G>=26&&G<77){
                if(B>=0&&B<26){
                    return "scarlet"
                }else if(B>=26&&B<77){
                    return "red orange"
                }else if(B>=77&&B<128){
                    return "radical red"
                }else if(B>=128&&B<179){
                    return "wild strawberry"
                }else if(B>=179&&B<230){
                    return "razzle dazzle rose"
                }else if(B>=230&&B<256){
                    return "magenta"
                }
            }else if(G>=77&&G<128){
                if(B>=0&&B<26){
                    return "safety orange"
                }else if(B>=26&&B<77){
                    return "outrangeous orange"
                }else if(B>=77&&B<128){
                    return "bittersweet"
                }else if(B>=128&&B<179){
                    return "brillant rose"
                }else if(B>=179&&B<230){
                    return "neon pink"
                }else if(B>=230&&B<256){
                    return "pink flamingo"
                }
            }else if(G>=128&&G<179){
                if(B>=0&&B<26){
                    return "orange peel"
                }else if(B>=26&&B<77){
                    return "neon carrot"
                }else if(B>=77&&B<128){
                    return "atomic tangerine"
                }else if(B>=128&&B<179){
                    return "mona lisa"
                }else if(B>=179&&B<230){
                    return "carnation pink"
                }else if(B>=230&&B<256){
                    return "violet"
                }
            }else if(G>=179&&G<230){
                if(B>=0&&B<26){
                    return "tangerine yellow"
                }else if(B>=26&&B<77){
                    return "sunglow"
                }else if(B>=77&&B<128){
                    return "grandis"
                }else if(B>=128&&B<179){
                    return "peach-orange"
                }else if(B>=179&&B<230){
                    return "cosmos"
                }else if(B>=230&&B<256){
                    return "snuff"
                }
            }else if(G>=230&&G<256){
                if(B>=0&&B<26){
                    return "yellow"
                }else if(B>=26&&B<77){
                    return "gorse"
                }else if(B>=77&&B<128){
                    return "laser lemon"
                }else if(B>=128&&B<179){
                    return "canary"
                }else if(B>=179&&B<230){
                    return "cream"
                }else if(B>=230&&B<256){
                    return "white"
                }
            }
        }
        
        
    return "unknown"
    
    } // chiusura funzione
    
    
}//chiusura classe
