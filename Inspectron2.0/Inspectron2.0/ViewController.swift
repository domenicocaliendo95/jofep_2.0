//
//  ViewController.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico on 24/03/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import UIKit
import AVFoundation // Framework, cercare uso.




class ViewController: UIViewController {

    var captureSession: AVCaptureSession? //avvia sessione fotocamera con tutti i dispositivi I/O Audio Video
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?  //inizializzo due variabili da poter riutilizzare nel codice. Aiuta a renderizzare il cameraViewFinder nella View Controller
    var inputCamera: AVCaptureInput?
    
@IBOutlet weak var Camera: UIImageView! //collegato a UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) //Imposta il device di acquisizione
        
        do{
        inputCamera = try AVCaptureDeviceInput(device: captureDevice!)
        }catch{
            print("Can't connect to the camera: \(error)")
        }
        
        captureSession = AVCaptureSession() //inizializza la variabile di CaptureSession (Coordina stream di coordinate e dati di immagine
        captureSession?.addInput(inputCamera!)
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        //videoPreviewLayer?.frame = self.Camera!.layer.bounds
        self.Camera?.layer.addSublayer(self.videoPreviewLayer!)
        self.videoPreviewLayer?.frame = UIScreen.main.bounds //quello che ci ha salvato la vita con la dimensione della fotocamera
        
        captureSession?.startRunning()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var zoom: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let screenSize = Camera.bounds.size //dimensioni cornice
        
        if let tounchPoint = touches.first {
            let x = tounchPoint.location(in: Camera).x / screenSize.width
            let y = 1.0 - tounchPoint.location(in: Camera).y / screenSize.height
            let focusPoint = CGPoint (x: x, y: y)
            
            let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) //Imposta il device di acquisizione
            if let device = captureDevice {
                do{
                    try device.lockForConfiguration()
                    device.focusPointOfInterest = focusPoint
                    device.focusMode = .autoFocus
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                    device.unlockForConfiguration()
                } catch { /*nothing*/ }
                
            }
        }
    }
    
   
    

    
}

