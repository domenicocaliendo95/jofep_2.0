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

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
 

    @IBOutlet var cameraLayer: UIImageView!//collegamento nel main storyboard
    @IBOutlet var flashButton: UIButton!//bottone flash
    
    let filter = AdaptiveTreshold()

    
    var automaticView: Bool = false
    
    var image: UIImage?//la foto scattata
    
    var imagePicker: UIImagePickerController!
    let screenScale = UIScreen.main.nativeScale//SCALE NATIVO
    
    let dataOutput = AVCaptureVideoDataOutput()
    let photoOutput = AVCapturePhotoOutput()
    var i = 0
    var performanceVal = 0

    
    

    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "showSettings_Segue", sender: nil)
    }
    
    @IBOutlet var rect: UIView!{
        didSet{
            self.rect.layer.cornerRadius = 10
            self.rect.layer.backgroundColor = nil
            self.rect.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            self.rect.layer.borderWidth = 2
            //self.rect.frame.origin = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
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
    
    
    
    @IBOutlet var asseX: UIImageView!{
        didSet{
            self.asseX.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.asseX.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.asseX.layer.borderWidth = 1
        }
    }//rettangolo nero

    @IBOutlet var asseY: UIImageView!{
        didSet{
            self.asseY.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.asseY.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.asseY.layer.borderWidth = 1
        }
    }//rettangolo nero

    var testoPredizione = ""
    var pivotPinchScale: CGFloat!//fattore di zoom
    var captureDevice: AVCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!//Imposta il device di acquisizione

    

    
    /*######################################################*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.automaticView = true
        
        flashButton.setBackgroundImage(UIImage(named: "flash_off"), for: UIControlState.normal)
    }//fine viewWillAppear
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

    }//fine viewDidAppear
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
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
        
    }//viewWillDisappear() spegne flash
    

    //############################################## viewDidLoad() ###################################################
    override func viewDidLoad() {
        
        super.viewDidLoad()

        viewWidth = cameraLayer.bounds.width * screenScale
        viewHeight = cameraLayer.bounds.height * screenScale
        effectiveWidth = self.rect.layer.frame.size.width
        effectiveHeight = self.rect.layer.frame.size.height
        
        effectiveRect = CGRect(origin: CGPoint(x: ((1080/2)-((1080*effectiveWidth*screenScale/viewWidth)/2)), y: ((1920/2)-((1920*effectiveHeight*screenScale/viewHeight)/2))), size: CGSize(width: (1080*effectiveWidth*screenScale/viewWidth), height: (1920*effectiveHeight*screenScale/viewHeight)))

        print("")//riga vuota
        print("effectiveWidth (rettangolo arancione) = " + String(describing: effectiveWidth))//in pixel
        print("effectiveHeight (rettangolo arancione) = " + String(describing: effectiveHeight))//in pixel
        print("effectiveRect (rettangolo nero) = " + String(describing: effectiveRect))
        print("cameraLayer (WIDTH) = " + String(describing: viewWidth))
        print("cameraLayer (HEIGHT) = " + String(describing: viewHeight))
        print(screenScale)
        print("")//riga vuota
        
        /*
        print(self.cameraLayer.layer.frame.size.width)
        print(self.cameraLayer.layer.frame.size.height)
        print(UIScreen.main.bounds.width)
        print(UIScreen.main.bounds.height)*/
    
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .hd1920x1080
        //guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }//##########ATTENZIONE! ABBIAMO GIA' UN captureDevice sopra!!!###########
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame //View per anteprima
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds//si adatta perfettamente ad ogni dispositivo, più FORTE dei constraint, da lasciare
        self.cameraLayer?.layer.addSublayer(previewLayer)//mette la fotocamera sulla view
        

        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        captureSession.addOutput(photoOutput)
        
        /*
         VNImageRequestHandler(cgImage: <#T##CGImage#>, options: <#T##[VNImageOption : Any]#>).perform(<#T##requests: [VNRequest]##[VNRequest]#>)// Responsible for analyzing the camera, CGImage is a translation from camera to this method.
         */
        
        
         /*do{
            inputCamera = try AVCaptureDeviceInput(device: captureDevice)
        }catch{
            print(error)
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //captureSession.sessionPreset = .photo // serve a ridimensionare per le foto
        self.Camera?.layer.addSublayer(self.videoPreviewLayer!)
        captureSession?.startRunning()
        Camera.isUserInteractionEnabled=true  // Grazie a максимальний комп'ютер
        */
        
        cameraLayer.isUserInteractionEnabled=true
        
    }//fine viewDidLoad
    
    
    
    @IBAction func takePhoto(_ sender: UIButton) {
        //performSegue(withIdentifier: "showPhoto_Segue", sender: nil)//va in errore di gerarchia
        let settings = AVCapturePhotoSettings()
        self.photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        i = i+1
        //print(performanceVal)
        if(i >= 10){ //rallentata acquisizione del 10%
        //print("Camera captured a frame", Date())
        
        //while(self.automaticView == true)
        if(self.automaticView == false){
            return
        }
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let uiImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
        DispatchQueue.main.async {
            //self.croppedView.image = uiImage
        }

        
            
        guard let model = try? VNCoreMLModel(for: InspectronModelOne().model) else { return }
        let request = VNCoreMLRequest(model: model){
            (finishedReq, err) in
            
           //print(finishedReq.results)
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            guard let firstObservation = results.first else { return }
            guard let secondObservation = results.last else { return }
            if((firstObservation.confidence >= 0.800000 || secondObservation.confidence >= 0.80000) && (String(firstObservation.identifier) != "Not a resistor")){
                //print(firstObservation.identifier, firstObservation.confidence)//stampa RESISTOR || SMD
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                    self.debugLabel.text! = String(firstObservation.identifier) + ": " + String(firstObservation.confidence) + "\n" + String(secondObservation.identifier) + ": " + String(secondObservation.confidence)
                    //self.croppedView.image = uiImage
                    self.rect.layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                        
                    }
                }
                //print(secondObservation.identifier, secondObservation.confidence)//stampa RESISTOR || SMD
            }else{
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        self.debugLabel.text! = "Not a resistor"
                        self.rect.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                    }
                }
            }
        }
            
            var ciImageCropped = CIImage(image: uiImage)
            
            //try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])//richiesta sulla view intera, non ci serve!
            try? VNImageRequestHandler(ciImage: ciImageCropped!, options: [:]).perform([request])//faccio la richiesta di analisi sull'immagine già croppata!! Non sulla view intera

            
            //##### threshold tipo 1
            //self.filter.inputImage = ciImageCropped//mando in input l'immagine al treshold
            
            //#### threshold tipo 2 with option kCIImageColorSpace
            var cgImageCropped = context.createCGImage(ciImageCropped!, from: (ciImageCropped?.extent)!)
//            print("Cast a CGImage OK!")
            self.filter.inputImage = CIImage(cgImage: cgImageCropped!, options: [kCIImageColorSpace: NSNull()])
            
            //___________________________________________l'algoritmo calcola il treshold
            
            let final_treshold = filter.outputImage!//salvo l'output del treshold
            
            let uiImage_tresholded = UIImage(ciImage: final_treshold)
            
            DispatchQueue.main.async {
                self.croppedView.image = uiImage_tresholded
            }
            
            
            i = 0
        }//fine if giganti
    }//questa funzione viene richiamata automaticamente ogni volta che la camera cattura un frame, non bisogna richiamarla da nessuna parte, ecco perchè stampa ogni millesimo di secondo la data
    

    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage?{
        
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return nil}
        var ciImage = CIImage(cvPixelBuffer: imageBuffer)// nella variabile ciImage ci va un solo frame
        ciImage = ciImage.oriented(forExifOrientation: 6)
        var cgImage = context.createCGImage(ciImage, from: ciImage.extent)
    
        //print("cgImage.width BEFORE_CROPPING = " + String((cgImage?.width)!))
        //print("cgImage.height BEFORE_CROPPING = " + String((cgImage?.height)!))
        
        cgImage = cgImage?.cropping(to: self.effectiveRect!)
        
        //print("cgImage.width AFTER_CROPPING = " + String((cgImage?.width)!))
        //print("cgImage.height AFTER_CROPPING = " + String((cgImage?.height)!))
        
        /*
        let model = try? VNCoreMLModel(for: InspectronModelOne().model)
        let request = VNCoreMLRequest(model: model!){
            (finishedReq, err) in
            
            //print(finishedReq.results)
            let results = finishedReq.results as? [VNClassificationObservation]
            let firstObservation = (results!.first)
            let secondObservation = (results!.last)
            
            if(firstObservation!.confidence >= 0.700000 || secondObservation!.confidence >= 0.70000){
                //print(firstObservation.identifier, firstObservation.confidence)//stampa RESISTOR || SMD
               
                    DispatchQueue.main.async {
                        self.debugLabel.text! = String(firstObservation!.identifier) + ": " + String(firstObservation!.confidence) + "\n" + String(secondObservation!.identifier) + ": " + String(secondObservation!.confidence)
                    }
                
                //print(secondObservation.identifier, secondObservation.confidence)//stampa RESISTOR || SMD
            }else{
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        self.debugLabel.text! = "Not a resistor"
                    }
                }
            }
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        */
 
        
        return UIImage(cgImage: cgImage!)
    }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    var touch_x: CGFloat = 0.0
    var touch_y: CGFloat = 0.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TouchesBegan")
        
        
        let screenSize = cameraLayer.bounds.size//dimensioni cornice
         
         if let tounchPoint = touches.first {
         
         self.touch_x = tounchPoint.location(in: cameraLayer).x / screenSize.width
         self.touch_y = 1.0 - tounchPoint.location(in: cameraLayer).y / screenSize.height
         /*let focusPoint = CGPoint (x: x, y: y)
         
         
         guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }//Imposta il device di acquisizione
         
        
         
         
         
         do{
         try captureDevice.lockForConfiguration()
         captureDevice.focusPointOfInterest = focusPoint
         captureDevice.focusMode = .autoFocus
         captureDevice.exposurePointOfInterest = focusPoint
         captureDevice.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
         
         captureDevice.unlockForConfiguration()
         } catch { /*nothing*/ }
         
         */
         }
         
         
        
    }
    
    
    @IBAction func tapForFocus(_ sender: UITapGestureRecognizer) {
        
        print("La fregna di mammita")
        

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
                
                captureDevice.unlockForConfiguration()
            } catch { /*nothing*/ }
            
            
        }


    

    @IBAction func longPressFocus(_ sender: UILongPressGestureRecognizer) {
        
        print("Parente è una merda")
        
        
        let x = self.touch_x
        let y = self.touch_y
        let focusPoint = CGPoint (x: x, y: y)
        
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }//Imposta il device di acquisizione
        
        
        do{
            try captureDevice.lockForConfiguration()
            captureDevice.focusPointOfInterest = focusPoint
            captureDevice.focusMode = .locked
            captureDevice.exposurePointOfInterest = focusPoint
            captureDevice.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
            
            captureDevice.unlockForConfiguration()
        } catch { /*nothing*/ }
    
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto_Segue" {
            let previewVC = segue.destination as! PreviewViewController//segue

            previewVC.image = self.image
        }
        
    }
    
    
    




}//fine class ViewController

extension ViewController: AVCapturePhotoCaptureDelegate{
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(){
            print(imageData)
            
            let uiImage = UIImage(data: imageData)//non me lo zoomma
            var ciImage = CIImage(image: uiImage!)
            
            ciImage = ciImage?.oriented(forExifOrientation: 6)//orientamento orizzontale
            print("Orientamento OK!")
            var cgImage = context.createCGImage(ciImage!, from: (ciImage?.extent)!)
            print("Cast a CGImage OK!")
            cgImage = cgImage?.cropping(to: effectiveRect!)
            image = UIImage(cgImage: cgImage!)
            print("Cast a UIImage OK!")
           
            //image = UIImage(data: imageData)
            
            performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
        }
    }
}



    


//тупий, хто читає
    

