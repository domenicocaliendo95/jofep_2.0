//
//  ViewController.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico & Gemito Gennaro on 24/03/18.
//  Copyright © 2018 Caliendo Domenico & Gemito Gennaro. All rights reserved.
//

import UIKit
import AVFoundation //Framework, cercare uso.
import Vision
import CoreImage

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

@IBOutlet weak var Camera: UIImageView!//collegamento a UIImageView
    @IBOutlet var flashButton: UIButton!//bottone flash
    
    @IBOutlet var rect: UIView!{
        didSet{
            self.rect.layer.cornerRadius = 10
            self.rect.layer.backgroundColor = nil
            self.rect.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            self.rect.layer.borderWidth = 2
            }
    }
    
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?//vedo l'acquisizione della fotocamera nel mio ViewController
    var captureSession: AVCaptureSession!//avvia la fotocamera, cattura le immagini
    var inputCamera: AVCaptureDeviceInput!
    var pivotPinchScale: CGFloat!//fattore di zoom
    var captureDevice: AVCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!//Imposta il device di acquisizione

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        flashButton.setBackgroundImage(UIImage(named: "flash_off"), for: UIControlState.normal)
        

    }//fine viewWillAppear
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer!.frame = UIScreen.main.bounds
        
    }//fine viewDidAppear
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do{
            inputCamera = try AVCaptureDeviceInput(device: captureDevice)
        }catch{
            print(error)
        }
        
        captureSession = AVCaptureSession()//inizializza la variabile di CaptureSession
        captureSession?.addInput(inputCamera!)
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        self.Camera?.layer.addSublayer(self.videoPreviewLayer!)
        captureSession?.startRunning()
        
        viewWillAppear(true)//animated true
        viewDidAppear(true)//animated true
        Camera.isUserInteractionEnabled=true  // Grazie a максимальний комп'ютер
        
        
        
    }//fine viewDidLoad
    
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
            
            //let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) //Imposta il device di acquisizione
           
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
            try captureDevice.lockForConfiguration()
            switch sender.state {
            case .began:
                self.pivotPinchScale = captureDevice.videoZoomFactor
            case .changed:
                var factor = self.pivotPinchScale * (sender.scale * 1.001)
                factor = max(1, min(factor, captureDevice.activeFormat.videoMaxZoomFactor))
                captureDevice.videoZoomFactor = factor
            default:
                break
            }
            captureDevice.unlockForConfiguration()
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
                            sender.transform = CGAffineTransform(scaleX: 0.98, y: 0.94)
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
                            sender.transform = CGAffineTransform(scaleX: 0.98, y: 0.94)
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
        
    }
    

 //gesture flashON -> swipe verso destra
    @IBAction func flashON(_ sender: UISwipeGestureRecognizer) {
        
        if (captureDevice.hasTorch) {
            do {
                try captureDevice.lockForConfiguration()
                switch sender.direction
                {
                case UISwipeGestureRecognizerDirection.right:
                    print("Swipe right")
                    captureDevice.torchMode = .on
                    self.flashButton.setBackgroundImage(UIImage(named: "flash_on"), for: UIControlState.normal)
                    //bottone flash animato
                    UIView.animate(withDuration: 0.07,
                                   animations: {
                                    self.flashButton.transform = CGAffineTransform(scaleX: 0.98, y: 0.94)
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
                    print("Swipe left")
                    captureDevice.torchMode = .off
                    self.flashButton.setBackgroundImage(UIImage(named: "flash_off"), for: UIControlState.normal)
                    UIView.animate(withDuration: 0.07,
                                   animations: {
                                    self.flashButton.transform = CGAffineTransform(scaleX: 0.98, y: 0.94)
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
    

