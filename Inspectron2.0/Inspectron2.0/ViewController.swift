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

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet var cameraLayer: UIImageView!//collegamento nel main storyboard
    @IBOutlet var flashButton: UIButton!//bottone flash
    
    @IBOutlet var rect: UIView!{
        didSet{
            self.rect.layer.cornerRadius = 10
            self.rect.layer.backgroundColor = nil
            self.rect.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            self.rect.layer.borderWidth = 2
            }
    }//rettangolo arancione centrale
    
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
        
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
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
        

        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        /*let request = VNCoreMLRequest(model: InspectronModelOne, completionHandler: <#T##VNRequestCompletionHandler?##VNRequestCompletionHandler?##(VNRequest, Error?) -> Void#>)
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
        
       /* let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "Video Queue"))
        captureSession.addOutput(dataOutput) */
        

        
        // --- ML & Vision ---
        
       /*let request = VNCoreMLRequest(model: InspectronModelOne, completionHandler: <#T##VNRequestCompletionHandler?##VNRequestCompletionHandler?##(VNRequest, Error?) -> Void#>)
        VNImageRequestHandler(cgImage: <#T##CGImage#>, options: <#T##[VNImageOption : Any]#>).perform(<#T##requests: [VNRequest]##[VNRequest]#>) // Responsible for analyzing the camera, CGImage is a translation from camera to this method.
        
        */
        
        // --- END ML & Vision ---
        
        
        
    }//fine viewDidLoad
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("Camera captured a frame", Date())
    }//questa funzione viene richiamata automaticamente ogni volta che la camera cattura un frame, non bisogna richiamarla da nessuna parte, ecco perchè stampa ongi millesimo di secondo la data
    
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
        /*do {
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
        */
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
                    print("Swipe right")
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
                    print("Swipe left")
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
    
/*
 _..._                      .-'''-.
 .-'_..._''.                  '   _    \
 .--.   _..._            _________   _...._            __.....__       .' .'      '.\               /   /` '.   \    _..._
 |__| .'     '.          \        |.'      '-.     .-''         '.    / .'                         .   |     \  '  .'     '.
 .--..   .-.   .          \        .'```'.    '.  /     .-''"'-.  `. . '               .|  .-,.--. |   '      |  '.   .-.   .
 |  ||  '   '  |           \      |       \     \/     /________\   \| |             .' |_ |  .-. |\    \     / / |  '   '  |
 |  ||  |   |  |       _    |     |        |    ||                  || |           .'     || |  | | `.   ` ..' /  |  |   |  |
 |  ||  |   |  |     .' |   |      \      /    . \    .-------------'. '          '--.  .-'| |  | |    '-...-'`   |  |   |  |
 |  ||  |   |  |    .   | / |     |\`'-.-'   .'   \    '-.____...---. \ '.          .|  |  | |  '-                |  |   |  |
 |__||  |   |  |  .'.'| |// |     | '-....-'`      `.             .'   '. `._____.-'/|  |  | |                    |  |   |  |
 |  |   |  |.'.'.-'  / .'     '.                 `''-...... -'       `-.______ / |  '.'| |                    |  |   |  |
 |  |   |  |.'   \_.''-----------'                                            `  |   / |_|                    |  |   |  |
 '--'   '--'                                                                     `'-'                         '--'   '--'
*/
    

    
    

}//fine class ViewController

    


//тупий, хто читає
    

