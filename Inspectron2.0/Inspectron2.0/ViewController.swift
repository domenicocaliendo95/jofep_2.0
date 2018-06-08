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
    @IBOutlet var colorSettings_outlet: UIView!
    
    var mostraRegolazioneColore: Bool = false
    
    @IBOutlet var sliderEV_outlet: UISlider!
    @IBAction func colorSettings_button(_ sender: UIButton) {
        
        if(self.mostraRegolazioneColore == false){
            self.mostraRegolazioneColore = true
            self.colorSettings_outlet.isHidden = false
            self.flashButton.isEnabled = false
            self.outletSnap.isEnabled = false
            self.changeView_buttonOutlet.isHidden = true
            self.croppedView.isHidden = true
            self.arrowOutlet.isHidden = true
        } else {
            self.mostraRegolazioneColore = false
            self.colorSettings_outlet.isHidden = true
            self.flashButton.isEnabled = true
            self.outletSnap.isEnabled = true
            self.changeView_buttonOutlet.isHidden = false
            self.croppedView.isHidden = false
            self.arrowOutlet.isHidden = false
        }
        
    }
    
    
    
    /*__________________________________ SLIDER EV _________________________________*/
    /*__________________________________ SLIDER EV _________________________________*/
    /*__________________________________ SLIDER EV _________________________________*/
    /*__________________________________ SLIDER EV _________________________________*/

    @IBAction func sliderEV(_ sender: UISlider) {
        
        
        self.manualEV = sender.value
        
        
        do{
            try self.captureDevice.lockForConfiguration()
            
            self.captureDevice.exposureMode = AVCaptureDevice.ExposureMode.custom
            
            self.captureDevice.setExposureModeCustom(duration: AVCaptureDevice.currentExposureDuration, iso: manualEV, completionHandler: nil)
            
            self.captureDevice.unlockForConfiguration()
        }   catch{
            print(error)
        }
        
        
    }
    
    
    @IBOutlet var errorImage_label: UILabel!
    @IBOutlet var outletBody_label: UILabel!
    @IBOutlet var outletBody: UIView!
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
    
    var coloursArray_24bit = [CIColor]()
    
    var colours8bit_string = [String]()
    
    var playerCameraFocusing: AVAudioPlayer!
    
    var cameraFocusing: String?
    
    var array24_dim: Int?
    
    var numberOfColors: Int = 0
    
    @IBOutlet var outletLoading: UIActivityIndicatorView!
    
    var catchedResistorBackground: CIColor?
    
    
    struct color8bit{
        let r: UInt8?
        let g: UInt8?
        let b: UInt8?
    }
    
    var hashBlue = NSMutableSet()
    var hashGreen = NSMutableSet()
    var hashBlack = NSMutableSet()
    var hashBrown = NSMutableSet()
    var hashRed = NSMutableSet()
    
    
    @IBOutlet var outletSnap: UIButton!
   
    var outletColor_isHidden = true
    
    @IBAction func colorViewCloseButton(_ sender: UIButton) {
        
        self.outletResultColor.subviews.forEach({ $0.removeFromSuperview() })
        self.outletBody.subviews.forEach({ $0.removeFromSuperview() })
        
        self.colorSettings_outlet.isHidden = true
        self.mostraRegolazioneColore = false
        
        blackArray.removeAll()
        coloursArray.removeAll()
        coloursArray_8bit.removeAll()
        colours8bit_string.removeAll()

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
    var coloursArray_8bit = [color8bit]()
    
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
        } else if(debugVal == 0){
            self.settingsOutlet.setBackgroundImage(#imageLiteral(resourceName: "settings"), for: [], barMetrics: .default)
        } else {
            self.settingsOutlet.setBackgroundImage(#imageLiteral(resourceName: "settings_BUG_FINALE"), for: [], barMetrics: .default)

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
        self.outletResultColor.subviews.forEach({ $0.removeFromSuperview() })
        self.outletBody.subviews.forEach({ $0.removeFromSuperview() })
        self.errorImage_label.isHidden = true
        
        blackArray.removeAll()
        coloursArray.removeAll()
        coloursArray_8bit.removeAll()
        colours8bit_string.removeAll()
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
        
        let backgroundImage = UIImageView(frame: self.colorSettings_outlet.layer.bounds)
        backgroundImage.image = UIImage(named: "black_view.png")
        backgroundImage.alpha = 0.95
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFit
        self.colorSettings_outlet.insertSubview(backgroundImage, at: 0)
        self.colorSettings_outlet.isHidden = true
        
        
        
        self.sliderEV_outlet.minimumValue = self.captureDevice.activeFormat.minISO
        print(self.captureDevice.activeFormat.minISO)
        self.sliderEV_outlet.maximumValue = self.captureDevice.activeFormat.maxISO
        print(self.captureDevice.activeFormat.maxISO)
        
        print(AVCaptureDevice.currentISO)
       
        
        self.errorImage_label.isHidden = true
        self.errorImage_label.layer.cornerRadius = 3
        self.errorImage_label.layer.borderWidth = 1.0
        self.errorImage_label.layer.backgroundColor = UIColor.white.withAlphaComponent(0.7).cgColor
        
        
        // POPOLO LA HASHSET CON I BLUE
        self.hashBlue.add("001")
        self.hashBlue.add("011")
        self.hashBlue.add("002")
        self.hashBlue.add("012")
        self.hashBlue.add("022")
        self.hashBlue.add("032")
        self.hashBlue.add("042")
        self.hashBlue.add("003")
        self.hashBlue.add("013")
        self.hashBlue.add("023")
        self.hashBlue.add("033")
        self.hashBlue.add("043")
        self.hashBlue.add("053")
        self.hashBlue.add("063")
        self.hashBlue.add("073")
        self.hashBlue.add("101")
        self.hashBlue.add("111")
        self.hashBlue.add("102")
        self.hashBlue.add("112")
        self.hashBlue.add("122")
        self.hashBlue.add("132")
        self.hashBlue.add("142")
        self.hashBlue.add("103")
        self.hashBlue.add("113")
        self.hashBlue.add("123")
        self.hashBlue.add("133")
        self.hashBlue.add("143")
        self.hashBlue.add("153")
        self.hashBlue.add("163")
        self.hashBlue.add("173")
        self.hashBlue.add("203")
        self.hashBlue.add("213")
        self.hashBlue.add("223")
        self.hashBlue.add("233")
        self.hashBlue.add("243")
        self.hashBlue.add("253")
        self.hashBlue.add("263")
        self.hashBlue.add("273")
        self.hashBlue.add("332")
        self.hashBlue.add("342")
        self.hashBlue.add("333")
        self.hashBlue.add("343")
        self.hashBlue.add("352")
        self.hashBlue.add("353")
        self.hashBlue.add("363")
        self.hashBlue.add("373")
        
        
        //AGGIUNGO I VERDI IN HASHSET GREEN
        
        self.hashGreen.add("020")
        self.hashGreen.add("030")
        self.hashGreen.add("040")
        self.hashGreen.add("050")
        self.hashGreen.add("060")
        self.hashGreen.add("070")
        self.hashGreen.add("061")
        self.hashGreen.add("071")
        self.hashGreen.add("120")
        self.hashGreen.add("130")
        self.hashGreen.add("140")
        self.hashGreen.add("150")
        self.hashGreen.add("160")
        self.hashGreen.add("170")
        self.hashGreen.add("161")
        self.hashGreen.add("171")
        self.hashGreen.add("230")
        self.hashGreen.add("240")
        self.hashGreen.add("250")
        self.hashGreen.add("260")
        self.hashGreen.add("270")
        self.hashGreen.add("261")
        self.hashGreen.add("271")
        self.hashGreen.add("340")
        self.hashGreen.add("350")
        self.hashGreen.add("360")
        self.hashGreen.add("370")
        self.hashGreen.add("371")
        self.hashGreen.add("450")
        self.hashGreen.add("460")
        self.hashGreen.add("470")
        self.hashGreen.add("451")
        self.hashGreen.add("461")
        self.hashGreen.add("471")
        self.hashGreen.add("451")
        self.hashGreen.add("560")
        self.hashGreen.add("570")
        self.hashGreen.add("561")
        self.hashGreen.add("571")

        // POPOLO LA MAP DI NERI
        self.hashBlack.add("000")
        self.hashBlack.add("010")
        
        
        
        // POPOLO LA MAP DI MARRONI
        
        self.hashBrown.add("200")
        self.hashBrown.add("210")
        self.hashBrown.add("320")
        self.hashBrown.add("420")
        self.hashBrown.add("100")
        
        // POPOLO LA MAP DI ROSSI
        
        self.hashRed.add("400")
        self.hashRed.add("500")
        self.hashRed.add("510")
        self.hashRed.add("600")
        self.hashRed.add("610")
        self.hashRed.add("700")
        self.hashRed.add("710")
        self.hashRed.add("701")
        self.hashRed.add("711")
        self.hashRed.add("410")
        self.hashRed.add("601")
        self.hashRed.add("611")
        self.hashRed.add("300")
        self.hashRed.add("310")
        self.hashRed.add("401")

        

        
        
        
        cameraFocusing = Bundle.main.path(forResource: "Camera_focusing", ofType: "wav")
        
        
      
        
        
        self.outletResultColor.layer.cornerRadius = 10
        self.outletResultColor.layer.borderWidth = 1
        self.outletResultColor.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.outletBody.layer.cornerRadius = 10
        self.outletBody.layer.borderWidth = 1
        self.outletBody.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        

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

        //print(self.captureDevice.isAdjustingWhiteBalance)
        
        
        
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
            if((firstObservation.confidence >= 0.800000 || secondObservation.confidence >= 0.80000) && (String(firstObservation.identifier) != "Not a resistor")){
                
                
                DispatchQueue.main.async {
                    self.rect.layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                    self.outletLoading.isHidden = false
                    self.outletLoading.startAnimating()
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
                        
                        print(self.acquiredWithFlash)
                        
                        
                        
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
                
                //print(secondObservation.identifier, secondObservation.confidence)//stampa RESISTOR || SMD
            }else{
                    DispatchQueue.main.async{
                        self.debugLabel.text! = "Not a resistor"
                        self.rect.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                        self.outletLoading.stopAnimating()
                        self.outletLoading.isHidden = true
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
                
                /*
                if(captureDevice.torchMode == .on){
                let temperatureValue = self.captureDevice.whiteBalanceMode.rawValue
                    
                    
                //changeTemperature(value: Float(temperatureValue))
                changeTemperatureRaw(temperature: Float(temperatureValue))
                }*/
                
                
                
                self.captureDevice.focusPointOfInterest = focusPoint
                self.captureDevice.focusMode = .autoFocus
                self.captureDevice.exposurePointOfInterest = focusPoint
                self.captureDevice.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                self.captureDevice.whiteBalanceMode = AVCaptureDevice.WhiteBalanceMode.continuousAutoWhiteBalance
                
                
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
            self.captureDevice.focusPointOfInterest = focusPoint
            self.captureDevice.focusMode = .locked
            self.captureDevice.exposurePointOfInterest = focusPoint
            self.captureDevice.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
            self.captureDevice.whiteBalanceMode = AVCaptureDevice.WhiteBalanceMode.continuousAutoWhiteBalance

            
            
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
            captureDevice.torchMode = .on
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

    print(self.captureDevice.exposureMode.hashValue)
        print(self.captureDevice.exposureMode.rawValue)
        if (captureDevice.hasTorch) {
            do {
                try captureDevice.lockForConfiguration()
                switch sender.direction
                {
                case UISwipeGestureRecognizerDirection.right:
                    
                    captureDevice.torchMode = .on
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
    
        print(self.captureDevice.exposureMode.hashValue)
        print(self.captureDevice.exposureMode.rawValue)
        
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

            previewVC.image = self.image
        }
        
        
        
        if segue.identifier == "showSettings_Segue" {
            //let cameraSettings = self.storyboard?.instantiateViewController(withIdentifier: "CameraSettingsViewController") as! CameraSettingsViewController
            
            
            
            let secondViewController = segue.destination as! CameraSettingsViewController
            secondViewController.delegatePassValue = self
            
            let secondViewControllerDebug = segue.destination as! CameraSettingsViewController
            secondViewControllerDebug.delegateDebug = self
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
        
        let inputVector = CIVector(x:4000, y:0)
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
            filter.setValue(2.50, forKey: "inputSaturation") //2.00
            filter.setValue(0.09, forKey: "inputBrightness") // 0.09
            filter.setValue(1.30, forKey: "inputContrast") //1.20
        } /*else {
            filter.setValue(3.00, forKey: "inputSaturation") //2.00
            filter.setValue(0.00, forKey: "inputBrightness") // 0.09
            filter.setValue(1.20, forKey: "inputContrast") //1.20
        }*/
        
        filter.setValue(image, forKey: kCIInputImageKey)
        let result = filter.outputImage!
        
        return result
    }
    

    
    
    /*£££££££££££££££££££££££££££££££££££££££££ GENERATE SOLID COLOR £££££££££££££££££££££££££££££*/
    /*£££££££££££££££££££££££££££££££££££££££££ GENERATE SOLID COLOR £££££££££££££££££££££££££££££*/
    /*£££££££££££££££££££££££££££££££££££££££££ GENERATE SOLID COLOR £££££££££££££££££££££££££££££*/
    /*£££££££££££££££££££££££££££££££££££££££££ GENERATE SOLID COLOR £££££££££££££££££££££££££££££*/

    
    func generateSolidColor(coloursArray: [CIColor]){
        
        let filter = CIFilter(name: "CIConstantColorGenerator")!
        let colorPrint_width = Float((200/coloursArray.count))//stampa in base al numero di colori trovati
        
        print(coloursArray.count)
        for i in stride(from: 0, to: coloursArray.count, by: 1){
            let current_color = coloursArray[i]
            filter.setValue(current_color, forKey: "inputColor")
            
            let uiCurrent_color = UIColor(ciColor: current_color)
            let image:UIImage = getImageWithColor(color: uiCurrent_color, size: CGSize(width: CGFloat(colorPrint_width), height: CGFloat(85)), origin_x: 0, origin_y: 0)
            let imageView: UIImageView = UIImageView(image: image)
            
            
            imageView.frame = CGRect(x: CGFloat(i)*CGFloat(colorPrint_width), y: CGFloat(0), width: CGFloat(colorPrint_width), height: CGFloat(85))//tutti CGFloat
            
            
            self.outletResultColor.contentMode = .scaleAspectFit
            self.outletResultColor.addSubview(imageView)
            
            self.colours8bit_string.append(String(describing: Int(coloursArray[i].red*7))+String(describing: Int(coloursArray[i].green*7))+String(describing: Int(coloursArray[i].blue*3)))
            
            if(self.hashBlue.contains(colours8bit_string[i])){
                print("Blue" + String(i))
            }else if(self.hashGreen.contains(colours8bit_string[i])){
                print("Green" + String(i))
            }else if(self.hashRed.contains(colours8bit_string[i])){
                print("Red" + String(i))
            }else if(self.hashBrown.contains(colours8bit_string[i])){
                print("Brown" + String(i))
            }else if(self.hashBlack.contains(colours8bit_string[i])){
                print("Black" + String(i))
            }else{
                print(colours8bit_string[i] + "    pos: " + String(i))
            }
            
        }
        
      
    }
    
    

    
    
    
    func getImageWithColor(color: UIColor, size: CGSize, origin_x: CGFloat, origin_y: CGFloat) -> UIImage {
        
        let rect = CGRect(x: origin_x, y: origin_y, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = (UIGraphicsGetImageFromCurrentImageContext())!
        
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
        }
        
        
    
        self.coloursArray_8bit = self.convertArray_8bit(arrayRGB: self.coloursArray)//da RGB a 8 bit
        self.coloursArray_24bit = array8To24(array8bit: self.coloursArray_8bit)
        //print("prima del merge a 3, ora siamo in 24bit")
        print("merge a 3")
        self.coloursArray_24bit = colorAverageBy3(colorsArray: coloursArray_24bit)
        //print("secondo merge")
        //self.coloursArray_24bit = colorAverageBy2(colorsArray: coloursArray_24bit)
        
       

        
        //generateSolidColor(coloursArray: self.coloursArray_24bit)
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
        
        let adaptiveStepper_x = Int((250/screenScale))
        
        for point_x in stride(from: stepper_x/adaptiveStepper_x, to: Int((effectiveRect?.width)!), by: stepper_x/adaptiveStepper_x){
            for point_y in stride(from: (stepper_y/2)-Int(screenScale), to: (stepper_y/2)+Int(screenScale), by: Int(screenScale)){
            //scorre il rettangolo di interesse da sinistra verso destra, analizza colonna per colonna
            let pixel = CGPoint(x: CGFloat(point_x), y: CGFloat(point_y))
                let curr_color = getPixelColor_threshold(image: ciBlackImage, pos: pixel)
                if(curr_color == CIColor.black){
                self.blackArray.append(pixel)
                }
            }
        }
        
        
        let blackArrayDim = blackArray.count
        
        
        if(blackArrayDim > 5 && blackArrayDim < 400){
        //self.catchedResistorBackground = catchResistorBackground(firstPoint: blackArray[0], lastPoint: blackArray[blackArrayDim-1], image: image_coloured)
        
            /*
            //stampa il colore del corpo della resistenza
            let filter = CIFilter(name: "CIConstantColorGenerator")!
            let current_color = catchedResistorBackground
            filter.setValue(current_color, forKey: "inputColor")
            
            let uiCurrent_color = UIColor(ciColor: current_color!)
            let image:UIImage = getImageWithColor(color: uiCurrent_color, size: CGSize(width: 5, height: 5), origin_x: 0, origin_y: 0)
            let imageView: UIImageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: 5, height: 5 )
            self.outletBody.addSubview(imageView)
            //fine stampa body*/
            
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
        //ciImage = colorAdjust(image: image)!
        
        
        
        
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

    
    
    
    
    
    
    
    func colorAverageBy3(colorsArray: [CIColor]) -> [CIColor]{
        
        var mergedColorsArray = [CIColor]()
        
        let endOfArray = colorsArray.count
        
        for counter in stride(from: 0, to: endOfArray-3, by: 3) {
            
            
            let tempR1 = (colorsArray[counter].red*255)
            let tempR2 = (colorsArray[counter+1].red*255)
            let tempR3 = (colorsArray[counter+2].red*255)
            
            let tempG1 = (colorsArray[counter].green*255)
            let tempG2 = (colorsArray[counter+1].green*255)
            let tempG3 = (colorsArray[counter+2].green*255)
            
            let tempB1 = (colorsArray[counter].blue*255)
            let tempB2 = (colorsArray[counter+1].blue*255)
            let tempB3 = (colorsArray[counter+2].blue*255)
            
            let averageR = (tempR1+tempR2+tempR3)/3
            let averageG = (tempG1+tempG2+tempG3)/3
            let averageB = (tempB1+tempB2+tempB3)/3
            
            
            mergedColorsArray.append(CIColor(red: averageR/255, green: averageG/255, blue: averageB/255))

        }
        
        self.numberOfColors = Int(mergedColorsArray.count)
        
        print(mergedColorsArray.count)
        
        return mergedColorsArray
    }
    
    
    
    

    
    
    func catchResistorBackground(firstPoint: CGPoint, lastPoint: CGPoint, image: CIImage) -> CIColor{
        let first_x = firstPoint.x - 3*screenScale
        let last_x = lastPoint.x + 3*screenScale
        var color1: CIColor?
        var color2: CIColor?
        color1 = getPixelColor(image: image , pos: CGPoint(x: first_x, y: firstPoint.y))
        color2 = getPixelColor(image: image , pos: CGPoint(x: last_x, y: lastPoint.y))
        
        let catchedResistorBackground = CIColor(red: ((color1?.red)!+(color2?.red)!)/2, green: ((color1?.green)!+(color2?.green)!)/2, blue: ((color1?.blue)!+(color2?.blue)!)/2)
   
        
        return catchedResistorBackground
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func convertArray_8bit(arrayRGB: [CIColor]) -> [color8bit]{
        
        let arrayRGB_dim = arrayRGB.count
        var array_8bit = [color8bit]()
        
        for i in stride(from: 0, to: arrayRGB_dim, by: 1){
            let red_8bit: UInt8 = UInt8(roundf( Float((arrayRGB[i].red*7)) ))
            let green_8bit: UInt8 = UInt8(roundf( Float((arrayRGB[i].green*7)) ))
            let blue_8bit: UInt8 = UInt8(roundf( Float((arrayRGB[i].blue*3)) ))
            
            array_8bit.append(color8bit(r: red_8bit, g: green_8bit, b: blue_8bit))
            
        }//chiusura for
        
        return array_8bit
    }
    
    
    
    
    
    
    
    
    func array8To24 (array8bit: [color8bit]) -> [CIColor]{
        
       
        var array_24bit = [CIColor]()
        
        for i in stride(from: 0, to: array8bit.count, by: 1){
            let temp_red = CGFloat(array8bit[i].r!)/7
            
            let temp_green = CGFloat(array8bit[i].g!)/7
            
            let temp_blue = CGFloat(array8bit[i].b!)/3
            
            
            array_24bit.append(CIColor(red: CGFloat(temp_red), green: CGFloat(temp_green), blue: CGFloat(temp_blue)))
        }
        
        self.array24_dim = array_24bit.count
        return array_24bit
    }
    
    
    
    
    
    

    
}//fine class ViewController










/*¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶ EXTENSION ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶*/
/*¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶ EXTENSION ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶*/
/*¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶ EXTENSION ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶*/
/*¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶ EXTENSION ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶*/


extension ViewController: AVCapturePhotoCaptureDelegate{
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(){
            //print(imageData)
            
            let uiImage = UIImage(data: imageData)//non me lo zoomma
            var ciImage = CIImage(image: uiImage!)
            
            ciImage = ciImage?.oriented(forExifOrientation: 6)//orientamento orizzontale
            //print("Orientamento OK!")
            var cgImage = context.createCGImage(ciImage!, from: (ciImage?.extent)!)
            //print("Cast a CGImage OK!")
            cgImage = cgImage?.cropping(to: effectiveRect!)
            image = UIImage(cgImage: cgImage!)
            //print("Cast a UIImage OK!")
           
            //image = UIImage(data: imageData)
            
            performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
        }
    }
}



    

