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

    var captureSession: AVCaptureSession? //Avvia sessione fotocamera con tutti i dispositivi I/O Audio Video
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?  //inizializzo due variabili da poter riutilizzare nel codice. Aiuta a renderizzare il cameraViewFinder nella View Controller
    var inputCamera: AVCaptureInput?
    
    
@IBOutlet weak var Camera: UIImageView! // Collegato a UIImageView
        
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) //Imposta il device di acquisizione
        
        do{
        inputCamera = try AVCaptureDeviceInput(device: captureDevice!)
        }catch{
            print(error)
        }
        
        
        captureSession = AVCaptureSession() // Inizializza la variabile di CaptureSession (Coordina stream di coordinate e dati di immagine
        captureSession?.addInput(inputCamera!)
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        //videoPreviewLayer?.frame = self.Camera!.layer.bounds
        self.Camera?.layer.addSublayer(self.videoPreviewLayer!)
        self.videoPreviewLayer?.frame = UIScreen.main.bounds // quello che ci ha salvato la vita con la dimensione della fotocamera
        
        captureSession?.startRunning()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    

    
}

