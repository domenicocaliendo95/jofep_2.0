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

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet var cameraLayer: UIImageView!//collegamento nel main storyboard
    @IBOutlet var flashButton: UIButton!//bottone flash
    
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
}//rettangolo arancione centrale
    
    var testoPredizione = "Mimmo Parente"
    
    //var videoPreviewLayer: AVCaptureVideoPreviewLayer?//vedo l'acquisizione della fotocamera nel mio ViewController
    //var captureSession: AVCaptureSession!//avvia la fotocamera, cattura le immagini
    //var inputCamera: AVCaptureDeviceInput!
    var pivotPinchScale: CGFloat!//fattore di zoom
    var captureDevice: AVCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!//Imposta il device di acquisizione

 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        flashButton.setBackgroundImage(UIImage(named: "flash_off"), for: UIControlState.normal)
    }//fine viewWillAppear
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }//fine viewDidAppear
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
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
        viewWidth = cameraLayer.bounds.width * UIScreen.main.scale
        viewHeight = cameraLayer.bounds.height * UIScreen.main.scale
        effectiveWidth = self.rect.layer.frame.size.width
        effectiveHeight = self.rect.layer.frame.size.height
        
       // effectiveRect = CGRect(x: ((UIScreen.main.bounds.width)/2), y: ((UIScreen.main.bounds.height)/2), width: effectiveWidth, height: effectiveHeight)
        //effectiveRect = CGRect(x: 0, y: 0, width: 250, height: 100)
        print(self.cameraLayer.layer.frame.size.width)
        print(self.cameraLayer.layer.frame.size.height)
        print(self.effectiveWidth)
        print(self.effectiveHeight)
        
        let captureSession = AVCaptureSession()
//        captureSession.sessionPreset = .photo
        //guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }//##########ATTENZIONE! ABBIAMO GIA' UN captureDevice sopra!!!###########
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        previewLayer.frame = self.cameraLayer.bounds
        
        
        
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame //View per anteprima
//        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        previewLayer.frame = UIScreen.main.bounds//si adatta perfettamente ad ogni dispositivo, più FORTE dei constraint, da lasciare
        self.cameraLayer?.layer.addSublayer(previewLayer)//mette la fotocamera sulla view
        

        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        /*
         VNImageRequestHandler(cgImage: <#T##CGImage#>, options: <#T##[VNImageOption : Any]#>).perform(<#T##requests: [VNRequest]##[VNRequest]#>)// Responsible for analyzing the camera, CGImage is a translation from camera to this method.
         */
        
        
         /*do{
            inputCamera = try AVCaptureDeviceInput(device: captureDevice)
        }catch{
            print(error)
        }
        
        captureSession = AVCaptureSession()//inizializza la variabile di CaptureSession
        captureSession?.addInput(inputCamera!)
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //captureSession.sessionPreset = .photo // serve a ridimensionare per le foto
        self.Camera?.layer.addSublayer(self.videoPreviewLayer!)
        captureSession?.startRunning()
        
        viewWillAppear(true)//animated true
        viewDidAppear(true)//animated true
        Camera.isUserInteractionEnabled=true  // Grazie a максимальний комп'ютер
        */
        
        
        cameraLayer.isUserInteractionEnabled=true
        
    }//fine viewDidLoad
    
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.preview
    }*/
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //print("Camera captured a frame", Date())
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let uiImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
        DispatchQueue.main.async {
            self.croppedView.image = uiImage
        }
        
        guard let model = try? VNCoreMLModel(for: InspectronModelOne().model) else { return }
        let request = VNCoreMLRequest(model: model){
            (finishedReq, err) in
            
           // print(finishedReq.results)
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            guard let firstObservation = results.first else { return }
            guard let secondObservation = results.last else { return }
            
            if(firstObservation.confidence >= 0.700000 || secondObservation.confidence >= 0.70000){
                print(firstObservation.identifier, firstObservation.confidence)
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                    self.debugLabel.text! = String(firstObservation.identifier) + ": " + String(firstObservation.confidence) + "\n" + String(secondObservation.identifier) + ": " + String(secondObservation.confidence)
                    }
                }
                print(secondObservation.identifier, secondObservation.confidence)
            }else{
                DispatchQueue.global(qos: .background).async {
                    
                    DispatchQueue.main.async {
                        self.debugLabel.text! = "Not a resistor"
                    }
                }
            }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }//questa funzione viene richiamata automaticamente ogni volta che la camera cattura un frame, non bisogna richiamarla da nessuna parte, ecco perchè stampa ogni millesimo di secondo la data
    

    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage?{
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return nil}
        var ciImage = CIImage(cvPixelBuffer: imageBuffer)// nella variabile ciImage ci va un solo frame
        ciImage = ciImage.oriented(forExifOrientation: 6)
        var cgImage = context.createCGImage(ciImage, from: ciImage.extent)
        
        var effectiveRect = CGRect(x: (UIScreen.main.bounds.size.height)/2, y: (UIScreen.main.bounds.size.width)/2, width: effectiveWidth, height: effectiveHeight)

        cgImage = cgImage?.cropping(to: effectiveRect)

        return UIImage(cgImage: cgImage!)
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       let screenSize = cameraLayer.bounds.size//dimensioni cornice
        
        if let tounchPoint = touches.first {
            let x = tounchPoint.location(in: cameraLayer).x / screenSize.width
            let y = 1.0 - tounchPoint.location(in: cameraLayer).y / screenSize.height
            let focusPoint = CGPoint (x: x, y: y)
            
            guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            else { return }//Imposta il device di acquisizione
           
                do{
                    try captureDevice.lockForConfiguration()
                    captureDevice.focusPointOfInterest = focusPoint
                    captureDevice.focusMode = .autoFocus
                    captureDevice.exposurePointOfInterest = focusPoint
                    captureDevice.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                    captureDevice.unlockForConfiguration()
                } catch { /*nothing*/ }
        }
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
                    //try captureDevice.setTorchModeOn(level: 1.0)
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

    
    
    
    
    

}//fine class ViewController

    


//тупий, хто читає
    

