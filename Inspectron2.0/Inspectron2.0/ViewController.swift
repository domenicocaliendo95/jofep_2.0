//
//  ViewController.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico on 24/03/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import UIKit
import AVFoundation // Framework, cercare uso.
import Vision
import CoreImage


class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    var captureSession: AVCaptureSession?//avvia sessione fotocamera con tutti i dispositivi I/O Audio Video
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?//inizializzo due variabili da poter riutilizzare nel codice. Aiuta a renderizzare il cameraViewFinder nella View Controller
    var inputCamera: AVCaptureInput?
    private var captureDevice: AVCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!//Imposta il device di acquisizione
    var pivotPinchScale: CGFloat!

    
@IBOutlet weak var Camera: UIImageView! //collegato a UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
        inputCamera = try AVCaptureDeviceInput(device: captureDevice)
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
        
    }//fine viewDidLoad
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let screenSize = Camera.bounds.size //dimensioni cornice
        
        if let tounchPoint = touches.first {
            let x = tounchPoint.location(in: Camera).x / screenSize.width
            let y = 1.0 - tounchPoint.location(in: Camera).y / screenSize.height
            let focusPoint = CGPoint (x: x, y: y)
            
            //let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) //Imposta il device di acquisizione
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
 */
    
    @IBAction func pinchZoom(_ sender: UIPinchGestureRecognizer) {
        
        /*
        do{
            try captureDevice.lockForConfiguration()//richiede l'accesso alla camera, restituisce un valore true se il lock è stato acquisito
            switch sender.state {
            case .began:
                self.pivotPinchScale = captureDevice.videoZoomFactor
            case .changed:
                var factor = self.pivotPinchScale * sender.scale
                factor = max(1.0, min(factor, captureDevice.activeFormat.videoMaxZoomFactor))
                captureDevice.videoZoomFactor = factor
            default:
                self.pivotPinchScale = captureDevice.videoZoomFactor
            }
            captureDevice.unlockForConfiguration()
        } catch { /*lo ignora*/ }*/
        
        let minimumZoom: CGFloat = 1.0
        let maximumZoom: CGFloat = 3.0
        var lastZoomFactor: CGFloat = 1.0
        
            
            // Return zoom value between the minimum and maximum zoom values
            func minMaxZoom(_ factor: CGFloat) -> CGFloat {
                return min(min(max(factor, minimumZoom), maximumZoom), captureDevice.activeFormat.videoMaxZoomFactor)
            }
            
            func update(scale factor: CGFloat) {
                do {
                    try captureDevice.lockForConfiguration()
                    defer { captureDevice.unlockForConfiguration() }
                    captureDevice.videoZoomFactor = factor
                } catch {
                    print("\(error.localizedDescription)")
                }
            }
            
            let newScaleFactor = minMaxZoom(sender.scale * lastZoomFactor)
            
            switch sender.state {
            case .began: fallthrough
            case .changed: update(scale: newScaleFactor)
            case .ended:
                lastZoomFactor = minMaxZoom(newScaleFactor)
                update(scale: lastZoomFactor)
            default: break
            }
        }
        
 
    }

    
    
    

