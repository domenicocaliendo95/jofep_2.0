//
//  ViewController.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico & Gemito Gennaro on 24/03/18.
//  Copyright © 2018 Caliendo Domenico - Gemito Gennaro. All rights reserved.
//

import UIKit
import AVFoundation //Framework, cercare uso.
import Vision
import CoreImage
import AVKit
import CoreGraphics
import CoreML



class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, passPerformanceValue, passDebugValue {

    
    var mostraRegolazioneColore: Bool = false
    var coloursRGB_string = [String]()
    
    var numberOfBands: Int?
    
    var resistorHasBeenCaught: Bool = false
    
    @IBOutlet var resistor_result_label: UILabel!
    @IBOutlet var whiteColorView_bottom: UIView!
    var safe_image = UIImage(named: "black_view")
    
    @IBOutlet var sliderEV_outlet: UISlider!
    @IBOutlet var left_debug_outlet: UIBarButtonItem!
    
    @IBAction func reverseButton(_ sender: UIButton) {
        self.coloursRGB_string = reverseArray(array: self.coloursRGB_string)
        
        printBands(coloursRGB_string: self.coloursRGB_string)

    }
    
    
    struct colorAndPosition{
        var r: Int
        var g: Int
        var b: Int
        var x: CGFloat
        var y: CGFloat
    }
    
    var arrayColorAndPosition = [colorAndPosition]()
    
    @IBOutlet var resultColorView_outlet: UIView!
    
    @IBOutlet var band1_colorOutlet: UIImageView!
    @IBOutlet var band2_colorOutlet: UIImageView!
    @IBOutlet var band3_colorOutlet: UIImageView!
    @IBOutlet var band4_colorOutlet: UIImageView!
    @IBOutlet var band5_colorOutlet: UIImageView!
    @IBOutlet var band6_colorOutlet: UIImageView!
    
    struct standardColor {
        var name: String
        var color: CIColor
    }
    
    @IBAction func longPress6_action(_ sender: UILongPressGestureRecognizer) {
        
        if(sender.state == .began){
        
            if(self.numberOfBands! > 3){
                
                self.band1_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band2_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band3_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band4_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band5_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band6_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
            
                self.coloursRGB_string.remove(at: self.coloursRGB_string.count-1)
        
                self.numberOfBands = self.numberOfBands! - 1
        
                printBands(coloursRGB_string: self.coloursRGB_string)
        }//se sono 3 bande non rimuove nulla perchè va in errore
            
        }//fine sender began
        
    }
    
    @IBAction func longPress5_action(_ sender: UILongPressGestureRecognizer) {
       
        if(sender.state == .began){
            
            if(self.numberOfBands! > 3){
                
                self.band1_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band2_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band3_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band4_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band5_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band6_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                
                self.coloursRGB_string.remove(at: 4)
                
                self.numberOfBands = self.numberOfBands! - 1
                
                printBands(coloursRGB_string: self.coloursRGB_string)
            }//se sono 3 bande non rimuove nulla perchè va in errore
            
        }//fine sender began
    }

    
    @IBAction func longPress4_action(_ sender: UILongPressGestureRecognizer) {
        if(sender.state == .began){
            
            if(self.numberOfBands! > 3){
                
                self.band1_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band2_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band3_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band4_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band5_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band6_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                
                self.coloursRGB_string.remove(at: 3)
                
                self.numberOfBands = self.numberOfBands! - 1
                
                printBands(coloursRGB_string: self.coloursRGB_string)
            }//se sono 3 bande non rimuove nulla perchè va in errore
            
        }//fine sender began
    }
    
    
    @IBAction func longPress3_action(_ sender: UILongPressGestureRecognizer) {
        if(sender.state == .began){
            
            if(self.numberOfBands! > 3){
                
                self.band1_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band2_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band3_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band4_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band5_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band6_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                
                self.coloursRGB_string.remove(at: 2)
                
                self.numberOfBands = self.numberOfBands! - 1
                
                printBands(coloursRGB_string: self.coloursRGB_string)
            }//se sono 3 bande non rimuove nulla perchè va in errore
            
        }//fine sender began
    }
    
    
    
    @IBAction func longPress2_action(_ sender: UILongPressGestureRecognizer) {
        
        if(sender.state == .began){
            
            if(self.numberOfBands! > 3){
                
                self.band1_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band2_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band3_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band4_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band5_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band6_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                
                self.coloursRGB_string.remove(at: 1)
                
                self.numberOfBands = self.numberOfBands! - 1
                
                printBands(coloursRGB_string: self.coloursRGB_string)
            }//se sono 3 bande non rimuove nulla perchè va in errore
            
        }//fine sender began
    }
    
    
    
    @IBAction func longPress1_action(_ sender: UILongPressGestureRecognizer) {
        
        if(sender.state == .began){
            
            if(self.numberOfBands! > 3){
                
                self.band1_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band2_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band3_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band4_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band5_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                self.band6_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
                
                self.coloursRGB_string.remove(at: 0)
                
                self.numberOfBands = self.numberOfBands! - 1
                
                printBands(coloursRGB_string: self.coloursRGB_string)
            }//se sono 3 bande non rimuove nulla perchè va in errore
            
        }//fine sender began
    }
    
    
    
    
    
    @IBOutlet var longPress1_outlet: UILongPressGestureRecognizer!
    @IBOutlet var longPress2_outlet: UILongPressGestureRecognizer!
    @IBOutlet var longPress3_outlet: UILongPressGestureRecognizer!
    @IBOutlet var longPress4_outlet: UILongPressGestureRecognizer!
    @IBOutlet var longPress6_outlet: UILongPressGestureRecognizer!
    
    @IBOutlet var longPress5_outlet: UILongPressGestureRecognizer!
    /*__________________________________ SLIDER EV _________________________________*/
    /*__________________________________ SLIDER EV _________________________________*/
    /*__________________________________ SLIDER EV _________________________________*/
    /*__________________________________ SLIDER EV _________________________________*/

    var modificaSlider: Bool = false
    
    @IBAction func sliderEV(_ sender: UISlider) {
        
        self.manualEV = sender.value

            if(sender.isTracking){
        
                do{
                    try self.captureDevice.lockForConfiguration()
                    self.modificaSlider = true
                    self.captureDevice.exposureMode = AVCaptureDevice.ExposureMode.custom
                    self.captureDevice.setExposureModeCustom(duration: AVCaptureDevice.currentExposureDuration, iso: manualEV, completionHandler: nil)
            
                    self.captureDevice.unlockForConfiguration()
                }   catch{
                    print(error)
                }
            } else {
                self.modificaSlider = false
            }
        
       
        
        
    }
    
    
    @IBOutlet var errorImage_label: UILabel!
    @IBOutlet var outletColor: UIView!
    @IBOutlet var outletClose: UIButton!
    @IBOutlet var outletResultColor: UIView!
    
    @IBOutlet var changeView_buttonOutlet: UIButton!
    @IBOutlet var arrowOutlet: UIImageView!
    var manualEV: Float = 0.0
    
    var mostraThreshold: Bool = true
    
    
    @IBAction func changeViewAction(_ sender: UIButton) {
        
        if (self.mostraThreshold == true){
            self.mostraThreshold = false
        } else {
            self.mostraThreshold = true
        }
        
    }
    
    var currentISOValue: Float?
    
    var acquiredWithFlash: Bool = false
    
    var playerCameraFocusing: AVAudioPlayer!
    
    var cameraFocusing: String?
    
    var numberOfColors: Int = 0
    
    @IBOutlet var outletLoading: UIActivityIndicatorView!
    
    var catchedResistorBackground: CIColor?
    
    
    @IBOutlet var outletSnap: UIButton!
   
    var outletColor_isHidden = true
    
    @IBAction func colorViewCloseButton(_ sender: UIButton) {
        
        
        //self.outletResultColor.subviews.forEach({ $0.removeFromSuperview() })
        self.outletResultColor.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.band1_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band2_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band3_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band4_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band5_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band6_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        
        //resetta label risultato
        self.resistor_result_label.text = ""
        
        self.blackArray.removeAll()
        self.coloursArray.removeAll()
        self.coloursRGB_string.removeAll()
        self.arrayColorAndPosition.removeAll()

        self.errorImage_label.isHidden = true
        self.rect.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)

        self.numberOfColors = 0
        self.outletColor.isHidden = true
        self.outletClose.isHidden = true
        self.outletResultColor.isHidden = true
        self.outletColor_isHidden = true
        
        
    }//chiude la schermata dei colori catturati
    
    
    @IBOutlet var cameraLayer: UIImageView!//collegamento nel main storyboard
    @IBOutlet var flashButton: UIButton!//bottone flash
    @IBOutlet var settingsOutlet: UIBarButtonItem!
    
    let filter = AdaptiveTreshold()
    let filterON = AdaptiveThreshold_flashON()
    
    var blackArray = [CGPoint]() //array con le posizioni in CGPoint dei pixel che hanno superato il treshold
    var coloursArray = [CIColor]() //array con il valore dei colori per i pixel che hanno superato il treshold
    
    var automaticView: Bool = false
    
    var image: UIImage?//la foto scattata
    
    var imagePicker: UIImagePickerController!
    let screenScale = UIScreen.main.nativeScale//SCALE NATIVO
    
    let dataOutput = AVCaptureVideoDataOutput()
    let photoOutput = AVCapturePhotoOutput()
    var i = 0
    var performanceVal: Int?
    var debugVal: Int?
    var persistentPerformance = UserDefaults.standard//settings persistenti
    var persistentDebug = UserDefaults.standard

 
    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        
        //let cameraSettings = self.storyboard?.instantiateViewController(withIdentifier: "CameraSettingsViewController") as! CameraSettingsViewController
        
        //cameraSettings.passValue = self
    
        //self.navigationController?.pushViewController(cameraSettings, animated: true)

    }
    
    
    @IBOutlet var rect: UIView!{
        didSet{
            self.rect.layer.cornerRadius = 10
            self.rect.layer.backgroundColor = nil
            self.rect.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            self.rect.layer.borderWidth = 2
            }
    }//rettangolo arancione centrale
    
    
    var effectiveWidth: CGFloat = 0
    var effectiveHeight: CGFloat = 0
    var effectiveRect: CGRect? = nil
    var viewWidth: CGFloat = 0
    var viewHeight: CGFloat = 0
   
    private let context = CIContext()
    @IBOutlet var debugLabel: UILabel!
    
    @IBOutlet var croppedView: UIImageView!{
        didSet{
            self.croppedView.layer.cornerRadius = 10
            self.croppedView.layer.backgroundColor = nil
            self.croppedView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.croppedView.layer.borderWidth = 2
        }
    }//rettangolo nero
    
    var standardColours_array = [standardColor]()

    var testoPredizione = ""
    var pivotPinchScale: CGFloat!//fattore di zoom
    
    var captureDevice: AVCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!
    //Imposta il device di acquisizione

    

    
    /*°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° viewWillAppear() °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°*/
    /*°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° viewWillAppear() °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°*/
    /*°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° viewWillAppear() °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°*/
    /*°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° viewWillAppear() °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°*/

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.outletResultColor.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.band1_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band2_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band3_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band4_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band5_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band6_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        
        
        //resetta label risultato
        self.resistor_result_label.text = ""
        
        
        
        self.errorImage_label.isHidden = true
        
        if (self.persistentDebug.object(forKey: "debugMode") as? Int == nil){
            self.persistentDebug.set(0, forKey: "debugMode")
        }
        
        
        self.debugVal = (self.persistentDebug.object(forKey: "debugMode") as! Int)
        
        if(persistentDebug.object(forKey: "debugMode") as! Int == 0){
            self.outletSnap.isHidden = true
            self.outletSnap.isEnabled = false
            self.debugLabel.isHidden = true
            self.debugLabel.isEnabled = false
            self.croppedView.isHidden = true
            self.changeView_buttonOutlet.isHidden = true
            self.arrowOutlet.isHidden = true
        }
        
        if(persistentDebug.object(forKey: "debugMode") as! Int == 1){
            self.outletSnap.isHidden = false
            self.outletSnap.isEnabled = true
            self.debugLabel.isHidden = false
            self.debugLabel.isEnabled = true
            self.croppedView.isHidden = false
            self.changeView_buttonOutlet.isHidden = false
            self.arrowOutlet.isHidden = false

        }

        
        
        if((persistentPerformance.object(forKey: "performanceLevel") == nil)){
            self.persistentPerformance.set(10, forKey: "performanceLevel")
        }
        
        
        
        self.outletLoading.isHidden = true
        self.outletColor.isHidden = true
        self.outletClose.isHidden = true
        self.outletResultColor.isHidden = true
        self.outletColor_isHidden = true
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white]
        
        
        if((persistentPerformance.object(forKey: "performanceLevel") as! Int ) == 2){
        self.settingsOutlet.setBackgroundImage(#imageLiteral(resourceName: "settings_warning"), for: [], barMetrics: .default)
        } else {
            self.settingsOutlet.setBackgroundImage(#imageLiteral(resourceName: "settings"), for: [], barMetrics: .default)
        } /*else {
            self.settingsOutlet.setBackgroundImage(#imageLiteral(resourceName: "settings_BUG_FINALE"), for: [], barMetrics: .default)

        }*/
        
        if(debugVal == 1){
            self.left_debug_outlet.setBackgroundImage(#imageLiteral(resourceName: "bug_icon_black"), for: [], barMetrics: .default)
        } else {
            self.left_debug_outlet.setBackgroundImage(#imageLiteral(resourceName: "vuota"), for: [], barMetrics: .default)
        }
        
        
        self.automaticView = true
        
        flashButton.setBackgroundImage(UIImage(named: "flash_off"), for: UIControlState.normal)
        
    }//fine viewWillAppear
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

    }//fine viewDidAppear
    
    
    
    
    
    
    
    
    /*.................................. viewWillDisappear() ...........................................*/
    /*.................................. viewWillDisappear() ...........................................*/
    /*.................................. viewWillDisappear() ...........................................*/
    /*.................................. viewWillDisappear() ...........................................*/

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //self.outletResultColor.subviews.forEach({ $0.removeFromSuperview() })
        self.outletResultColor.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.band1_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band2_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band3_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band4_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band5_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.band6_colorOutlet.image = #imageLiteral(resourceName: "vuota")//immagine vuota
        self.errorImage_label.isHidden = true
        
        //resetta label risultato
        self.resistor_result_label.text = ""
        
        self.blackArray.removeAll()
        self.coloursArray.removeAll()
        self.coloursRGB_string.removeAll()
        self.arrayColorAndPosition.removeAll()


        self.outletColor.isHidden = true
        self.outletClose.isHidden = true
        self.outletResultColor.isHidden = true
        self.outletColor_isHidden = true
        self.outletLoading.isHidden = true
        
        self.automaticView = false
        
        //spegne flash al cambio di schermata
        do{
            try captureDevice.lockForConfiguration()
            if(captureDevice.torchMode == .on){
                captureDevice.torchMode = .off
                flashButton.setBackgroundImage(UIImage(named: "flash_off"), for: UIControlState.normal)
            }
            
            captureDevice.unlockForConfiguration()
        }
        catch{
            print(error)
        }
        
        
        
    }//viewWillDisappear() -> spegne flash
    

    //############################################## viewDidLoad() ###################################################
    //############################################## viewDidLoad() ###################################################
    //############################################## viewDidLoad() ###################################################
    //############################################## viewDidLoad() ###################################################

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.resultColorView_outlet.backgroundColor = UIColor(white: 1, alpha: 1)
        
        self.standardColours_array = [
            standardColor(name: "black", color:CIColor(red: 0, green: 0, blue: 0)),
            standardColor(name: "brown", color:CIColor(red: 102/255, green: 51/255, blue: 0)),
            standardColor(name: "blue", color:CIColor(red: 0, green: 0, blue: 200/255)),
            standardColor(name: "turquoise", color:CIColor(red: 60/255, green: 140/255, blue: 200/255)),
            standardColor(name: "cyan", color:CIColor(red: 110/255, green: 230/255, blue: 255/255)),
            standardColor(name: "green", color:CIColor(red: 0, green: 150/255, blue: 0)),
            standardColor(name: "light_green", color:CIColor(red: 200/255, green: 255/255, blue: 200/255)),
            standardColor(name: "yellow", color:CIColor(red: 250/255, green: 250/255, blue: 50/255)),
            standardColor(name: "gold", color:CIColor(red: 220/255, green: 165/255, blue: 32/255)),
            standardColor(name: "grey", color:CIColor(red: 230/255, green: 230/255, blue: 230/255)),
            standardColor(name: "silver", color:CIColor(red: 192/255, green: 192/255, blue: 192/255)),
            standardColor(name: "white", color:CIColor(red: 255/255, green: 255/255, blue: 255/255)),
            standardColor(name: "bordeaux", color:CIColor(red: 153/255, green: 0, blue: 76/255)),
            standardColor(name: "beige", color:CIColor(red: 255/255, green: 222/255, blue: 173/255)),
            standardColor(name: "orange", color:CIColor(red: 255/255, green: 130/255, blue: 0)),
            standardColor(name: "purple", color:CIColor(red: 150/255, green: 100/255, blue: 230/255)),
            standardColor(name: "red", color:CIColor(red: 230/255, green: 0, blue: 0))
            ]
        
        self.whiteColorView_bottom.layer.borderWidth = 1
        self.whiteColorView_bottom.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        
        
        self.sliderEV_outlet.minimumValue = self.captureDevice.activeFormat.minISO
       
        self.sliderEV_outlet.maximumValue = self.captureDevice.activeFormat.maxISO
        
        self.sliderEV_outlet.value = self.captureDevice.iso
        
        self.sliderEV_outlet.setThumbImage(UIImage(named: "exposure_black"), for: UIControlState.normal)

        
        
        
       
        
        self.errorImage_label.isHidden = true
        self.errorImage_label.layer.cornerRadius = 3
        self.errorImage_label.layer.borderWidth = 1.0
        self.errorImage_label.layer.backgroundColor = UIColor.white.withAlphaComponent(0.7).cgColor
        

        
        cameraFocusing = Bundle.main.path(forResource: "Camera_focusing", ofType: "wav")
        
        
      
        
        
        self.outletResultColor.layer.cornerRadius = 10
        self.outletResultColor.layer.borderWidth = 1
        self.outletResultColor.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
       
        
        
        

        viewWidth = cameraLayer.bounds.width * screenScale
        viewHeight = cameraLayer.bounds.height * screenScale
        effectiveWidth = self.rect.layer.frame.size.width
        effectiveHeight = self.rect.layer.frame.size.height
        
        effectiveRect = CGRect(origin: CGPoint(x: ((1080/2)-((1080*effectiveWidth*screenScale/viewWidth)/2)), y: ((1920/2)-((1920*effectiveHeight*screenScale/viewHeight)/2))), size: CGSize(width: (1080*effectiveWidth*screenScale/viewWidth), height: (1920*effectiveHeight*screenScale/viewHeight)))

        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .hd1920x1080
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        captureSession.addInput(input)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame //View per anteprima
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds//si adatta perfettamente ad ogni dispositivo, più FORTE dei constraint, da lasciare perchè importante!
        self.cameraLayer?.layer.addSublayer(previewLayer)//mette la fotocamera sulla view
        

        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        captureSession.addOutput(photoOutput)
        
        cameraLayer.isUserInteractionEnabled=true
        
    }//fine viewDidLoad
    
    
    /*............................. SCATTA LA FOTO ...........................*/
    /*............................. SCATTA LA FOTO ...........................*/
    /*............................. SCATTA LA FOTO ...........................*/
    /*............................. SCATTA LA FOTO ...........................*/

    @IBAction func takePhoto(_ sender: UIButton) {
        //performSegue(withIdentifier: "showPhoto_Segue", sender: nil)//va in errore di gerarchia
        let settings = AVCapturePhotoSettings()
        self.photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

        
        DispatchQueue.main.async {
            if(self.modificaSlider == false){
            self.sliderEV_outlet.value = self.captureDevice.iso
            }
        }

        
        
        if(outletColor_isHidden){
        
        i = i+1
        
        if(self.automaticView == false){
            return
        }
        
        /*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ CROP E FILTRI @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
        /*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ CROP E FILTRI @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
        /*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ CROP E FILTRI @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
        /*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ CROP E FILTRI @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

        if(i >= (persistentPerformance.object(forKey: "performanceLevel") as! Int)){ //rallentata acquisizione
        
            
       
        guard let uiImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
            
        var ciImageCropped = CIImage(image: uiImage)
        
        ciImageCropped = noiseReduction(image: ciImageCropped!)
            
            
            
            
            //applico filtro blu freddo, se flash ON
            if(self.captureDevice.torchMode == .on){
                ciImageCropped = temperatureAndTint(image: ciImageCropped!)
            }
 
 


        
        //#### threshold tipo 2 with option kCIImageColorSpace
            let final_treshold: CIImage?
            
            if(self.captureDevice.torchMode == .off){
                let cgImageCropped = context.createCGImage(ciImageCropped!, from: (ciImageCropped?.extent)!)
                self.filter.inputImage = CIImage(cgImage: cgImageCropped!, options: [kCIImageColorSpace: NSNull()])
                //___________________________________________l'algoritmo calcola il treshold
                final_treshold = filter.outputImage!//salvo l'output del treshold CIImage
            } else {
                let cgImageCropped = context.createCGImage(ciImageCropped!, from: (ciImageCropped?.extent)!)
                self.filterON.inputImage = CIImage(cgImage: cgImageCropped!, options: [kCIImageColorSpace: NSNull()])
                //___________________________________________l'algoritmo calcola il treshold
                final_treshold = filterON.outputImage!//salvo l'output del treshold CIImage
            }
            
        
            let uiImage_tresholded = UIImage(ciImage: (final_treshold)!)
        

        guard let model = try? VNCoreMLModel(for: InspectronModelOne().model) else { return }
        let request = VNCoreMLRequest(model: model){
            (finishedReq, err) in
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            guard let firstObservation = results.first else { return }
            guard let secondObservation = results.last else { return }
            if((firstObservation.confidence >= 0.990000 || secondObservation.confidence >= 0.99000) && (String(firstObservation.identifier) != "Not a resistor")){
                
                
                DispatchQueue.main.async {
                    self.rect.layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                    self.outletLoading.isHidden = false
                    self.outletLoading.startAnimating()
                    self.settingsOutlet.isEnabled = false
                    
                }
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01){
                    
                    
                self.debugLabel.text! = String(firstObservation.identifier) + ": " + String(firstObservation.confidence) + "\n" + String(secondObservation.identifier) + ": " + String(secondObservation.confidence)
                    
                    
                    //spegne flash
                    do{
                        try self.captureDevice.lockForConfiguration()
                        if(self.captureDevice.torchMode == .on){
                            self.acquiredWithFlash = true
                            self.captureDevice.torchMode = .off
                            self.flashButton.setBackgroundImage(UIImage(named: "flash_off"), for: UIControlState.normal)
                        } else {
                            self.acquiredWithFlash = false
                            
                        }
                
                        
                        
                        self.captureDevice.unlockForConfiguration()
                    }
                    catch{
                        print(error)
                    }
                    
                    
                    
                    self.outletSnap.isEnabled = false
                    self.flashButton.isEnabled = false
                    self.outletColor.isHidden = false
                    self.outletClose.isHidden = false
                    self.outletResultColor.isHidden = false
                    self.outletColor_isHidden = false
                    self.cameraLayer.isUserInteractionEnabled=false
                    
                        
                    self.blackFromThreshold(image: final_treshold!, image_coloured: ciImageCropped!)
                    
                        
                    
                        
                    }
                
            }else{
                    DispatchQueue.main.async{
                        self.debugLabel.text! = "Not a resistor"
                        self.rect.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                        self.outletLoading.stopAnimating()
                        self.outletLoading.isHidden = true
                        self.settingsOutlet.isEnabled = true
                    }
            }
            
            DispatchQueue.main.async{
            self.cameraLayer.isUserInteractionEnabled=true
            self.outletSnap.isEnabled = true
            self.flashButton.isEnabled = true
            }
        }
            
            
            

            try? VNImageRequestHandler(ciImage: ciImageCropped!, options: [:]).perform([request])//faccio la richiesta di analisi sull'immagine già croppata!! Non sulla view intera

            
            
                DispatchQueue.main.async {
                    
                    if(self.mostraThreshold == true){
                    self.arrowOutlet.image = #imageLiteral(resourceName: "round_arrow_black")
                    self.croppedView.image = uiImage_tresholded
                        
                    } else {
                    self.croppedView.image = UIImage(ciImage: ciImageCropped!)
                    self.arrowOutlet.image = #imageLiteral(resourceName: "round_arrow_white")
                    }
                }
            
            
            i = 0
        }//fine if giganti
            

            
        } // fine if nascosto
        

    }//questa funzione viene richiamata automaticamente ogni volta che la camera cattura un frame, non bisogna richiamarla da nessuna parte, ecco perchè stampa ogni millesimo di secondo la data
    

    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage?{
        
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return nil}
        var ciImage = CIImage(cvPixelBuffer: imageBuffer)//nella variabile ciImage ci va un solo frame
        ciImage = ciImage.oriented(forExifOrientation: 6)
        var cgImage = context.createCGImage(ciImage, from: ciImage.extent)

        
        cgImage = cgImage?.cropping(to: self.effectiveRect!)
        
 
        return UIImage(cgImage: cgImage!)
    }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var touch_x: CGFloat = 0.0
    var touch_y: CGFloat = 0.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                
        let screenSize = cameraLayer.bounds.size//dimensioni cornice
         
         if let tounchPoint = touches.first {
         
         self.touch_x = tounchPoint.location(in: cameraLayer).x / screenSize.width
         self.touch_y = 1.0 - tounchPoint.location(in: cameraLayer).y / screenSize.height
         }
        
    }
    
    
    @IBAction func tapForFocus(_ sender: UITapGestureRecognizer) {
        
        
            let x = self.touch_x
            let y = self.touch_y
            let focusPoint = CGPoint (x: x, y: y)
            
            
            guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }//Imposta il device di acquisizione
            
  
            do{
                try captureDevice.lockForConfiguration()
                

                captureDevice.focusPointOfInterest = focusPoint
                captureDevice.focusMode = .autoFocus
                captureDevice.exposurePointOfInterest = focusPoint
                captureDevice.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                //self.sliderEV_outlet.value = self.captureDevice.iso
                captureDevice.whiteBalanceMode = AVCaptureDevice.WhiteBalanceMode.continuousAutoWhiteBalance
                
                
                captureDevice.unlockForConfiguration()
            } catch { /*nothing*/ }
            
            
        }


    

    @IBAction func longPressFocus(_ sender: UILongPressGestureRecognizer) {
        
        if(sender.state == .began){
        
        let x = self.touch_x
        let y = self.touch_y
        let focusPoint = CGPoint (x: x, y: y)

        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }//Imposta il device di acquisizione
        
        
        do{
            try captureDevice.lockForConfiguration()
            captureDevice.focusPointOfInterest = focusPoint
            captureDevice.focusMode = .locked
            captureDevice.exposurePointOfInterest = focusPoint
            //self.sliderEV_outlet.value = captureDevice.iso
            captureDevice.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
            captureDevice.whiteBalanceMode = AVCaptureDevice.WhiteBalanceMode.continuousAutoWhiteBalance

            
            
            if self.cameraFocusing != nil {
                let audioFileUrl = NSURL.fileURL(withPath: self.cameraFocusing!)
                
                do{
                    playerCameraFocusing = try AVAudioPlayer(contentsOf: audioFileUrl)
                } catch { print("error URL") }

                playerCameraFocusing.play()
 
            } else {
                print("audio file is not found")
            }
            
           
            
            
            captureDevice.unlockForConfiguration()
        } catch { /*nothing*/ }
            
        }// fine sender.state = .began

    
    }
 


    @IBAction func pinchToZoom(_ sender: UIPinchGestureRecognizer) {
    
    
        do {
            try self.captureDevice.lockForConfiguration()
            switch sender.state {
            case .began:
                self.pivotPinchScale = self.captureDevice.videoZoomFactor
            case .changed:
                var factor = self.pivotPinchScale * (sender.scale * 1.001)
                factor = max(1, min(factor, self.captureDevice.activeFormat.videoMaxZoomFactor))
                self.captureDevice.videoZoomFactor = factor
            default:
                break
            }
            self.captureDevice.unlockForConfiguration()
        } catch {
            print(error)
        }

    }
    
    
    
    
    /*================================== FLASH =====================================*/
    /*================================== FLASH =====================================*/
    /*================================== FLASH =====================================*/
    /*================================== FLASH =====================================*/


    @IBAction func flashButton(_ sender: UIButton) {
        do{
            try captureDevice.lockForConfiguration()
        if(captureDevice.torchMode == .on){
            captureDevice.torchMode = .off
            flashButton.setBackgroundImage(UIImage(named: "flash_off"), for: UIControlState.normal)
            
            //bottone flash animato
            UIView.animate(withDuration: 0.07,
                           animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                           completion: { finish in
                            UIView.animate(withDuration: 0.07, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
            })
            
        }else{
            try! captureDevice.setTorchModeOn(level: 0.1)
            flashButton.setBackgroundImage(UIImage(named: "flash_on"), for: UIControlState.normal)
            
            //bottone flash animato
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
        
        captureDevice.unlockForConfiguration()
        }
        catch{
            print(error)
        }
    }//bottone flash in alto a dx
    

    //gesture flashON -> swipe verso destra
    @IBAction func flashON(_ sender: UISwipeGestureRecognizer) {

        if (captureDevice.hasTorch) {
            do {
                try captureDevice.lockForConfiguration()
                switch sender.direction
                {
                case UISwipeGestureRecognizerDirection.right:
                    
                    //captureDevice.torchMode = .on
                    try! captureDevice.setTorchModeOn(level: 0.1)
                    self.flashButton.setBackgroundImage(UIImage(named: "flash_on"), for: UIControlState.normal)
                    //bottone flash animato
                    UIView.animate(withDuration: 0.07,
                                   animations: {
                                    self.flashButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.07, animations: {
                                        self.flashButton.transform = CGAffineTransform.identity
                                    })
                    })
                    break
                
                default: break
                }
                captureDevice.unlockForConfiguration()
            }
            catch {
                print(error)
            }
            
        }//fine if hasTorch
    }//fine flashON
    

    //gesture flashOFF -> swipe verso sinistra
    @IBAction func flashOFF(_ sender: UISwipeGestureRecognizer) {
    
        
        if (captureDevice.hasTorch) {
            do {
                try captureDevice.lockForConfiguration()
                switch sender.direction
                {
                case UISwipeGestureRecognizerDirection.left:
                    
                    captureDevice.torchMode = .off
                    self.flashButton.setBackgroundImage(UIImage(named: "flash_off"), for: UIControlState.normal)
                    UIView.animate(withDuration: 0.07,
                                   animations: {
                                    self.flashButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.07, animations: {
                                        self.flashButton.transform = CGAffineTransform.identity
                                    })
                    })
                    break
                    
                default: break
                }
                captureDevice.unlockForConfiguration()
            }
            catch {
                print(error)
            }
            
        }//fine if hasTorch
    }//fine flashOFF
    
    
    
    
    
    
    /*++++++++++++++++++++++++++++ SEGUE +++++++++++++++++++++++++++*/
    /*++++++++++++++++++++++++++++ SEGUE +++++++++++++++++++++++++++*/
    /*++++++++++++++++++++++++++++ SEGUE +++++++++++++++++++++++++++*/
    /*++++++++++++++++++++++++++++ SEGUE +++++++++++++++++++++++++++*/

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto_Segue" {
            let previewVC = segue.destination as! PreviewViewController//segue
            var immagine_da_passare = CIImage(image: self.image!)
            print("cast a CIImage OK")
            
            immagine_da_passare = noiseReduction(image: immagine_da_passare!)
            
            if(self.captureDevice.torchMode == .on){
                immagine_da_passare = temperatureAndTint(image: immagine_da_passare!)
            }
            
            immagine_da_passare = colorAdjust(image: immagine_da_passare!)!
            
            let immagine_finale = UIImage(ciImage: immagine_da_passare!)
            
            previewVC.image = immagine_finale
            

            //previewVC.image = self.image
        }
        
        
        
        if segue.identifier == "showSettings_Segue" {
            //let cameraSettings = self.storyboard?.instantiateViewController(withIdentifier: "CameraSettingsViewController") as! CameraSettingsViewController
            
            
            
            let secondViewController = segue.destination as! CameraSettingsViewController
            secondViewController.delegatePassValue = self
            
            let secondViewControllerDebug = segue.destination as! CameraSettingsViewController
            secondViewControllerDebug.delegateDebug = self
        }
        
        
        if segue.identifier == "showResistor_Segue" {
            
            let destinationNavigationController = segue.destination as! AcquiredResistorController

            //secondViewControllerDebug.delegateDebug = self
        }
        
    }
    
    
    func passPerformanceValue(performanceInt: Int) {
        self.performanceVal = performanceInt
        persistentPerformance.set(performanceInt, forKey: "performanceLevel")
    }
    
    func passDebugValue(debugInt: Int){
        self.debugVal = debugInt
        persistentDebug.set(debugInt, forKey: "debugMode")
    }
    
    
    
    
    
    
    
    
    
    /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FILTRI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FILTRI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FILTRI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FILTRI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    
    
    
    
    

    
    func noiseReduction(image: CIImage) -> CIImage?{
        
        let filter = CIFilter(name: "CINoiseReduction")!
        filter.setValue(0.03, forKey: "inputNoiseLevel")
        filter.setValue(0.60, forKey: "inputSharpness")
        filter.setValue(image, forKey: kCIInputImageKey)
        
        let result = filter.outputImage!
        
        return result
    }
    
    
    
    func exposureAdjust(image: CIImage) -> CIImage?{
        let filter = CIFilter(name: "CIExposureAdjust")!
        filter.setValue(1.150, forKey: "inputEV")
        filter.setValue(image, forKey: kCIInputImageKey)

        
        let result = filter.outputImage!
        
        return result
    }
    
    func sharpenLuminance(image: CIImage) -> CIImage?{
        let filter = CIFilter(name: "CISharpenLuminance")!
        filter.setValue(1, forKey: "inputSharpness")
        filter.setValue(image, forKey: kCIInputImageKey)
        
        let result = filter.outputImage!
        
        return result
    }
    
    
    
    func temperatureAndTint(image: CIImage) -> CIImage?{
        let filter = CIFilter(name: "CITemperatureAndTint")!
        
        let inputVector = CIVector(x:5000, y:0)//4000
        //let targetVector = CIVector(x:8000, y:0)
        
        filter.setValue(inputVector, forKey: "inputNeutral")
        //filter.setValue(targetVector, forKey: "inputTargetNeutral")
        
        filter.setValue(image, forKey: kCIInputImageKey)
        
        let result = filter.outputImage!
        
        return result
        
    }
    
    
    
    
    //AGGIUNGO UN ALTRO EXPOSURE PER MODIFICARE I COLORI IN USCITA
    //AGGIUNGO UN ALTRO EXPOSURE PER MODIFICARE I COLORI IN USCITA
    //AGGIUNGO UN ALTRO EXPOSURE PER MODIFICARE I COLORI IN USCITA
    //AGGIUNGO UN ALTRO EXPOSURE PER MODIFICARE I COLORI IN USCITA
    //AGGIUNGO UN ALTRO EXPOSURE PER MODIFICARE I COLORI IN USCITA
    //AGGIUNGO UN ALTRO EXPOSURE PER MODIFICARE I COLORI IN USCITA
    //AGGIUNGO UN ALTRO EXPOSURE PER MODIFICARE I COLORI IN USCITA
    //AGGIUNGO UN ALTRO EXPOSURE PER MODIFICARE I COLORI IN USCITA
    //AGGIUNGO UN ALTRO EXPOSURE PER MODIFICARE I COLORI IN USCITA
    //AGGIUNGO UN ALTRO EXPOSURE PER MODIFICARE I COLORI IN USCITA
    //AGGIUNGO UN ALTRO EXPOSURE PER MODIFICARE I COLORI IN USCITA

    
    
    
    
    
    
    
    
    func exposureAdjustOnColors(image: CIImage) -> CIImage?{
        
        let filter = CIFilter(name: "CIExposureAdjust")!
        
        if(self.acquiredWithFlash == false){
            filter.setValue(2, forKey: "inputEV")
        }
        
        filter.setValue(image, forKey: kCIInputImageKey)
        
        
        let result = filter.outputImage!
        
        return result
    }
    
    

    func colorAdjust(image: CIImage) -> CIImage?{
        let filter = CIFilter(name: "CIColorControls")!
        
        if(self.acquiredWithFlash == false){
            filter.setValue(1.30, forKey: "inputSaturation") //2.30
            filter.setValue(0.00, forKey: "inputBrightness") // 0.00
            filter.setValue(1.00, forKey: "inputContrast") //1.00
        }else {
            filter.setValue(1.50, forKey: "inputSaturation") //2.50
            filter.setValue(0.00, forKey: "inputBrightness") // 0.00
            filter.setValue(1.00, forKey: "inputContrast") //1.08
        }
        
        filter.setValue(image, forKey: kCIInputImageKey)
        let result = filter.outputImage!
        
        return result
    }
    

    

    
    
    /*£££££££££££££££££££££££££££££££££££££££££ GENERATE SOLID COLOR £££££££££££££££££££££££££££££*/
    /*£££££££££££££££££££££££££££££££££££££££££ GENERATE SOLID COLOR £££££££££££££££££££££££££££££*/
    /*£££££££££££££££££££££££££££££££££££££££££ GENERATE SOLID COLOR £££££££££££££££££££££££££££££*/
    /*£££££££££££££££££££££££££££££££££££££££££ GENERATE SOLID COLOR £££££££££££££££££££££££££££££*/

    
    func generateSolidColor(coloursArray: [CIColor]){
        
        for i in stride(from: 0, to: coloursArray.count, by: 1){
            
         
            //classifica i colori, scorre l'array con il for
            let colorClass = ColorClassification()
            self.coloursRGB_string.append(colorClass.inspectColor(Red: Int(coloursArray[i].red*255), Green: Int(coloursArray[i].green*255), Blue: Int(coloursArray[i].blue*255)))
            
        }
        
        
        let GenerateColorClass = GenerateOutput()
        let bodyColor: String = GenerateColorClass.resistorBody(colours_string: self.coloursRGB_string)
        
        
        
        print("BODY COLOOOOOR")
        print(bodyColor)
        
        var bodyColor_RGB: CIColor?
        

        if(bodyColor == "gold"){
            bodyColor_RGB = self.standardColours_array[13].color
        }else if(bodyColor == "red"){
            bodyColor_RGB = self.standardColours_array[12].color
        } else if(bodyColor == "green"){
            bodyColor_RGB = self.standardColours_array[6].color
        } else if(bodyColor == "silver"){
            bodyColor_RGB = self.standardColours_array[9].color
        } else if(bodyColor == "blue"){
            bodyColor_RGB = self.standardColours_array[3].color
        } else {
        for i in stride(from: 0, to: self.standardColours_array.count, by: 1){
            if(self.standardColours_array[i].name == bodyColor){
                bodyColor_RGB = self.standardColours_array[i].color
                print(bodyColor_RGB)
            }
        }
        }
        
        
        //stampo il colore di sfondo
        self.outletResultColor.backgroundColor = UIColor(ciColor: bodyColor_RGB!)
        
        print("Before flattener")
        print(coloursRGB_string)
        self.coloursRGB_string = GenerateColorClass.flattener(arrayOfColours: self.coloursRGB_string, bodyColor: bodyColor)
        print("FLATTENEEEEER")
        print(coloursRGB_string)
        
        self.coloursRGB_string = GenerateColorClass.bandsCount(arrayOfColours: self.coloursRGB_string, bodyColor: bodyColor)
        
        print("")
        print("")
        print("colori con bande")
        print(coloursRGB_string)
        
        printBands(coloursRGB_string: self.coloursRGB_string)
        
    }
    
    
    
    func printBands(coloursRGB_string: [String]){
            let filter = CIFilter(name: "CIConstantColorGenerator")!
        
            self.numberOfBands = coloursRGB_string.count
        
        
            var band1Color_RGB: CIColor?
            var band2Color_RGB: CIColor?
            var band3Color_RGB: CIColor?
            var band4Color_RGB: CIColor?
            var band5Color_RGB: CIColor?
            var band6Color_RGB: CIColor?
        
        
        if(self.numberOfBands == 6){
            self.longPress6_outlet.isEnabled = true
            self.longPress5_outlet.isEnabled = true
            self.longPress4_outlet.isEnabled = true
            self.longPress3_outlet.isEnabled = true
            self.longPress2_outlet.isEnabled = true
            self.longPress1_outlet.isEnabled = true
        } else if(self.numberOfBands == 5){
            self.longPress6_outlet.isEnabled = true
            self.longPress5_outlet.isEnabled = false
            self.longPress4_outlet.isEnabled = true
            self.longPress3_outlet.isEnabled = true
            self.longPress2_outlet.isEnabled = true
            self.longPress1_outlet.isEnabled = true
        } else if(self.numberOfBands == 4){
                self.longPress6_outlet.isEnabled = true
                self.longPress5_outlet.isEnabled = false
                self.longPress4_outlet.isEnabled = false
                self.longPress3_outlet.isEnabled = true
                self.longPress2_outlet.isEnabled = true
                self.longPress1_outlet.isEnabled = true
        } else if(self.numberOfBands == 3){
            self.longPress6_outlet.isEnabled = true
            self.longPress5_outlet.isEnabled = false
            self.longPress4_outlet.isEnabled = false
            self.longPress3_outlet.isEnabled = false
            self.longPress2_outlet.isEnabled = true
            self.longPress1_outlet.isEnabled = true
        }
        
        
        
        
        
        if(self.numberOfBands! >= 3){
        
            print(self.numberOfBands)
            
        //stampo l'ultima banda
        for i in stride(from: 0, to: self.standardColours_array.count, by: 1){
            if(self.standardColours_array[i].name == coloursRGB_string[self.numberOfBands!-1]){
                band6Color_RGB = self.standardColours_array[i].color
            }
        }
            
        
        
        filter.setValue(band6Color_RGB, forKey: "inputColor")
        let uiCurrentBand6 = UIColor(ciColor: band6Color_RGB!)
        let image_band6:UIImage = getImageWithColor(color: uiCurrentBand6, size: CGSize(width: CGFloat(15), height: CGFloat(79)), origin_x: 0, origin_y: 0)
        self.band6_colorOutlet.image = image_band6
        
        
        
        //stampo prima banda
        for i in stride(from: 0, to: self.standardColours_array.count, by: 1){
            if(self.standardColours_array[i].name == coloursRGB_string[0]){
                band1Color_RGB = self.standardColours_array[i].color
            }
        }
        
        filter.setValue(band1Color_RGB, forKey: "inputColor")
        let uiCurrentBand1 = UIColor(ciColor: band1Color_RGB!)
        let image_band1:UIImage = getImageWithColor(color: uiCurrentBand1, size: CGSize(width: CGFloat(15), height: CGFloat(79)), origin_x: 0, origin_y: 0)
        self.band1_colorOutlet.image = image_band1
        
        
        
        
        
        //stampo seconda banda
        for i in stride(from: 0, to: self.standardColours_array.count, by: 1){
            if(self.standardColours_array[i].name == coloursRGB_string[1]){
                band2Color_RGB = self.standardColours_array[i].color
            }
        }
        
        filter.setValue(band2Color_RGB, forKey: "inputColor")
        let uiCurrentBand2 = UIColor(ciColor: band2Color_RGB!)
        let image_band2:UIImage = getImageWithColor(color: uiCurrentBand2, size: CGSize(width: CGFloat(15), height: CGFloat(79)), origin_x: 0, origin_y: 0)
        self.band2_colorOutlet.image = image_band2
        
        
        
        if(self.numberOfBands! >= 4){
            //stampo terza banda
            for i in stride(from: 0, to: self.standardColours_array.count, by: 1){
                if(self.standardColours_array[i].name == coloursRGB_string[2]){
                    band3Color_RGB = self.standardColours_array[i].color
                }
            }
            
            filter.setValue(band3Color_RGB, forKey: "inputColor")
            let uiCurrentBand3 = UIColor(ciColor: band3Color_RGB!)
            let image_band3:UIImage = getImageWithColor(color: uiCurrentBand3, size: CGSize(width: CGFloat(15), height: CGFloat(79)), origin_x: 0, origin_y: 0)
            self.band3_colorOutlet.image = image_band3
        }
        
        if(self.numberOfBands! >= 5){
            //stampo quarta banda
            for i in stride(from: 0, to: self.standardColours_array.count, by: 1){
                if(self.standardColours_array[i].name == coloursRGB_string[3]){
                    band4Color_RGB = self.standardColours_array[i].color
                }
            }
            
            filter.setValue(band4Color_RGB, forKey: "inputColor")
            let uiCurrentBand4 = UIColor(ciColor: band4Color_RGB!)
            let image_band4:UIImage = getImageWithColor(color: uiCurrentBand4, size: CGSize(width: CGFloat(15), height: CGFloat(79)), origin_x: 0, origin_y: 0)
            self.band4_colorOutlet.image = image_band4
        }
        
        if(self.numberOfBands! == 6){
            //stampo quarta banda
            for i in stride(from: 0, to: self.standardColours_array.count, by: 1){
                if(self.standardColours_array[i].name == coloursRGB_string[4]){
                    band5Color_RGB = self.standardColours_array[i].color
                }
            }
            
            filter.setValue(band5Color_RGB, forKey: "inputColor")
            let uiCurrentBand5 = UIColor(ciColor: band5Color_RGB!)
            let image_band5:UIImage = getImageWithColor(color: uiCurrentBand5, size: CGSize(width: CGFloat(15), height: CGFloat(79)), origin_x: 0, origin_y: 0)
            self.band5_colorOutlet.image = image_band5
        }
            
            let outputValue = OutputValue()
            
            self.resistor_result_label.text = outputValue.generateOutputValue(arrayBands: coloursRGB_string)
        
    }//if gigante number of bands >= 3
        else{
            
            self.errorImage_label.isHidden = false
            self.outletLoading.stopAnimating()
            self.outletLoading.isHidden = true
            self.rect.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            return
        }
        
    
        
        
    }//fine funzione print_bands
    
    

    
    
    
    func getImageWithColor(color: UIColor, size: CGSize, origin_x: CGFloat, origin_y: CGFloat) -> UIImage {
        
        let rect = CGRect(x: origin_x, y: origin_y, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        color.setFill()
        UIRectFill(rect)
        
        //guard let image: UIImage = try (UIGraphicsGetImageFromCurrentImageContext()) else {return self.safe_image!}
        
       let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
    
   
    
    
    
    
    
    
  
    
    
    
    
    
    
    
    
    
    
    
    /*§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ COLORI ACQUISITI §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§*/
    /*§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ COLORI ACQUISITI §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§*/
    /*§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ COLORI ACQUISITI §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§*/
    /*§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ COLORI ACQUISITI §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§*/

    
    func printColors(image: CIImage){
        
        let arrayDim = Int(self.blackArray.count)
        print(arrayDim)
        
        for counter in 0..<arrayDim {
            let current_color = getPixelColor(image: image, pos: blackArray[counter])
            self.coloursArray.append(current_color)
            
            self.arrayColorAndPosition.append(colorAndPosition(r: Int(current_color.red*255), g: Int(current_color.green*255), b: Int(current_color.blue*255), x: CGFloat(blackArray[counter].x), y: CGFloat(CGFloat(blackArray[counter].y))))
        }
        
        
        self.coloursArray = colorAverageBy_x(colorsAndPositionArray: self.arrayColorAndPosition)
    
        generateSolidColor(coloursArray: self.coloursArray)
        
        
        DispatchQueue.main.async{
            self.outletLoading.stopAnimating()
            self.outletLoading.isHidden = true
        }
    }
    
    
    
    
    
    
    
    
    func blackFromThreshold(image: CIImage, image_coloured: CIImage){//final_threshold
        
        let ciBlackImage:CIImage = image
        let stepper_x: Int = Int((effectiveRect?.width)!)
        let stepper_y: Int = Int((effectiveRect?.height)!)
        
        let adaptiveStepper_x = Int((500/screenScale))  //originale 420/screenScale
        
        if(captureDevice.torchMode == .off){
            for point_x in stride(from: stepper_x/adaptiveStepper_x, to: Int((effectiveRect?.width)!), by: stepper_x/adaptiveStepper_x){
            for point_y in stride(from: (stepper_y/2)-Int(3*screenScale), to: (stepper_y/2)+Int(3*screenScale), by: Int(3*screenScale)){
            //scorre il rettangolo di interesse da sinistra verso destra, analizza colonna per colonna
            let pixel = CGPoint(x: CGFloat(point_x), y: CGFloat(point_y))
                let curr_color = getPixelColor_threshold(image: ciBlackImage, pos: pixel)
                
                    if(curr_color == CIColor.black){
                        self.blackArray.append(pixel)
                    }
                
                }
            }
        } else {
            for point_x in stride(from: stepper_x/adaptiveStepper_x, to: Int((effectiveRect?.width)!), by: stepper_x/adaptiveStepper_x){
                
                for point_y in stride(from: (6*stepper_y/12)-Int(4*stepper_y/12)-Int(screenScale), to: (6*stepper_y/12)-Int(5*stepper_y/12)-Int(screenScale), by: Int(stepper_y/12)){
                    //scorre il rettangolo di interesse da sinistra verso destra, analizza colonna per colonna
                    let pixel = CGPoint(x: CGFloat(point_x), y: CGFloat(point_y))
                    let curr_color = getPixelColor_threshold(image: ciBlackImage, pos: pixel)
                    
                    if(curr_color == CIColor.black){
                        self.blackArray.append(pixel)
                    }
                }
                
                
                for point_y in stride(from: (6*stepper_y/12)+Int(7*stepper_y/12)+Int(screenScale), to: (6*stepper_y/12)+Int(8*stepper_y/12)+Int(screenScale), by: Int(stepper_y/12)){
                    //scorre il rettangolo di interesse da sinistra verso destra, analizza colonna per colonna
                    let pixel = CGPoint(x: CGFloat(point_x), y: CGFloat(point_y))
                    let curr_color = getPixelColor_threshold(image: ciBlackImage, pos: pixel)
                    
                    if(curr_color == CIColor.black){
                        self.blackArray.append(pixel)
                    }
                }
                

                
                
            }
            
        }
        
        
        
        
        if(blackArray.count >= 420){
            print("HO ACQUISITO")
            print(blackArray.count)
            repeat{
                self.blackArray = arrayReduction_by10(passed_array: blackArray)
                print("Sto riducendo")
                
            } while (blackArray.count >= 420)
            print("Array ridotto")
            print(blackArray.count)
        }
        
        if(blackArray.count > 30 && blackArray.count < 420){
           
            self.printColors(image: image_coloured)//provare nella viewDidLoad
            } else {
            
            self.errorImage_label.isHidden = false
            self.outletLoading.stopAnimating()
            self.outletLoading.isHidden = true
            self.rect.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            return
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    func getPixelColor_threshold(image: CIImage, pos: CGPoint) -> CIColor{
        let ciImage: CIImage = image
        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)!
        let uiImage = UIImage(cgImage: cgImage)
        
        guard let pixelData = CGDataProvider(data: (cgImage.dataProvider?.data)!)?.data else { return CIColor.clear}
        var data:UnsafePointer<UInt8>?
        
        //data = CFDataGetBytePtr(pixelData as! CFData) //dava warning su as!
        data = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(uiImage.size.width)*Int(pos.y))+Int(pos.x))*4
        
        let r = CGFloat(data![pixelInfo])/CGFloat(255.0)
        let g = CGFloat(data![pixelInfo+1])/CGFloat(255.0)
        let b = CGFloat(data![pixelInfo+2])/CGFloat(255.0)
        let a = CGFloat(data![pixelInfo+3])/CGFloat(255.0)
        
        return CIColor(red: r, green: g, blue: b, alpha: a)
 
    }
    
    
    
    
    
    func getPixelColor(image: CIImage, pos: CGPoint) -> CIColor{
        
        var ciImage: CIImage = image
        
        
        //di nuovo altri filtri di colore
        //Invoco un filtro di vividezza sull'immagine da cui catturo i colori.
        
        
        /*(((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))*/
        /*(((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))*/
        /*(((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))*/
        /*(((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))*/
        /*(((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))*/
        /*(((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))*/
        /*(((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))*/
        /*(((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))*/
        
        //ciImage = exposureAdjustOnColors(image: image)!
        ciImage = colorAdjust(image: image)!
       
        
        
        
        
        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)!
        let uiImage = UIImage(cgImage: cgImage)
        
        
        guard let pixelData = CGDataProvider(data: (cgImage.dataProvider?.data)!)?.data else { return CIColor.clear}
        var data:UnsafePointer<UInt8>?
        
        //data = CFDataGetBytePtr(pixelData as! CFData)//dava warning, vediamo prima se funziona
        data = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(uiImage.size.width)*Int(pos.y))+Int(pos.x))*4
        
        let r = CGFloat(data![pixelInfo])/CGFloat(255.0)
        let g = CGFloat(data![pixelInfo+1])/CGFloat(255.0)
        let b = CGFloat(data![pixelInfo+2])/CGFloat(255.0)
        let a = CGFloat(data![pixelInfo+3])/CGFloat(255.0)
        
        return CIColor(red: r, green: g, blue: b, alpha: a)
        
    }

    
    
    
    
    
    
    
    func colorAverageBy_x(colorsAndPositionArray: [colorAndPosition]) -> [CIColor]{
        
        var mergedColorsArray = [CIColor]()
        
        let endOfArray = colorsAndPositionArray.count
        
        
        for counter in stride(from: 0, to: endOfArray-1, by: 1) {
            
            if(colorsAndPositionArray[counter+1].x == colorsAndPositionArray[counter].x){
                let averageRed = (colorsAndPositionArray[counter+1].r+colorsAndPositionArray[counter].r)/2
                let averageGreen = (colorsAndPositionArray[counter+1].g+colorsAndPositionArray[counter].g)/2
                let averageBlue = (colorsAndPositionArray[counter+1].b+colorsAndPositionArray[counter].b)/2
                
                mergedColorsArray.append(CIColor(red: CGFloat(averageRed)/255, green: CGFloat(averageGreen)/255, blue: CGFloat(averageBlue)/255))
                
            }
            
            
        }//for average_color
        
        
        self.numberOfColors = Int(mergedColorsArray.count)
        
        return mergedColorsArray
    }
    
    
    
    
    
    
    
    
    func arrayReduction_by10(passed_array: [CGPoint]) -> [CGPoint]{
        var array = passed_array
        let array_dim = array.count
        var j: Int = 0
        
        for counter in stride(from: array_dim, to: 0, by: -1){
            j += 1
            
            if (j >= 9){
                array.remove(at: counter)
                j = 0
            }
            
        }
        
        return array
        
        
    }
    
    
    
    func reverseArray(array: [String]) -> [String]{
        var curr_array = array
        var second_array = [String]()
        let array_dim = curr_array.count
        
        print("array prima del reverse")
        print(curr_array)
        
        for i in stride(from: array_dim-1, to: -1, by: -1)
        {
            second_array.append(curr_array[i])
            print("appendo")
            print(curr_array[i])
        }
        
        print("array dopo reverse")
        print(second_array)
        
        return second_array
    }
    
    
    
    
    

    
}//fine class ViewController










/*¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶ EXTENSION ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶*/
/*¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶ EXTENSION ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶*/
/*¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶ EXTENSION ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶*/
/*¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶ EXTENSION ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶*/


extension ViewController: AVCapturePhotoCaptureDelegate{
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(){
            
            let uiImage = UIImage(data: imageData)//non me lo zoomma
            var ciImage = CIImage(image: uiImage!)
            
            ciImage = ciImage?.oriented(forExifOrientation: 6)//orientamento orizzontale
            var cgImage = context.createCGImage(ciImage!, from: (ciImage?.extent)!)
            cgImage = cgImage?.cropping(to: effectiveRect!)
            image = UIImage(cgImage: cgImage!)
           
            //image = UIImage(data: imageData)
            
            performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
        }
    }
}



    

