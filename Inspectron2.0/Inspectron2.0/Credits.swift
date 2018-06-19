//
//  Credits.swift
//  Inspectron2.0
//
//  Created by Gemito Gennaro on 16/05/18.
//  Copyright © 2018 Caliendo Domenico - Gemito Gennaro. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Credits: UIViewController{
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var spritz: UIImageView!
    @IBOutlet var outlet_Domenico: UIButton!
    @IBOutlet var outlet_Gennaro: UIButton!
    
    var playerRotationSound: AVAudioPlayer!
    
    var rotationSound: String?
    
    @IBAction func bottoneDomenico(_ sender: UIButton) {
        
        if let url = NSURL(string: "https://www.linkedin.com/in/domenico-caliendo-76b40a127/"){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        if self.rotationSound != nil {
            let audioFileUrl = NSURL.fileURL(withPath: self.rotationSound!)
            
            do{
                playerRotationSound = try AVAudioPlayer(contentsOf: audioFileUrl)
            } catch { print("error URL") }
            
            playerRotationSound.stop()
            
        } else {
            print("audio file is not found")
        }
        
    }
    
    @IBAction func bottoneGennaro(_ sender: UIButton) {
        
        if let url = NSURL(string: "https://www.linkedin.com/in/gennaro-gemito-a609a9107"){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        if self.rotationSound != nil {
            let audioFileUrl = NSURL.fileURL(withPath: self.rotationSound!)
            
            do{
                playerRotationSound = try AVAudioPlayer(contentsOf: audioFileUrl)
            } catch { print("error URL") }
            
            playerRotationSound.stop()
            
        } else {
            print("audio file is not found")
        }
    }
    
    
    let rotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 360))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
  
        rotationSound = Bundle.main.path(forResource: "rotation", ofType: "wav")

        
        rotate360Degrees(duration: 120.0, completionDelegate: nil)

        self.spritz.alpha = 0.3
        
        self.outlet_Domenico.layer.cornerRadius = 3
        self.outlet_Domenico.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.outlet_Domenico.layer.borderWidth = 1.0
        self.outlet_Domenico.layer.backgroundColor = UIColor.white.withAlphaComponent(0.7).cgColor
        
        self.outlet_Gennaro.layer.cornerRadius = 3
        self.outlet_Gennaro.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.outlet_Gennaro.layer.borderWidth = 1.0
        self.outlet_Gennaro.layer.backgroundColor = UIColor.white.withAlphaComponent(0.7).cgColor
        
    }//fine viewDidLoad()
    
    @IBAction func fastRotatione(_ sender: UILongPressGestureRecognizer) {
        
        if(sender.state == .began){
            rotate360Degrees(duration: 120.0, completionDelegate: nil)
        
        
        
        if self.rotationSound != nil {
            let audioFileUrl = NSURL.fileURL(withPath: self.rotationSound!)
            
            do{
                playerRotationSound = try AVAudioPlayer(contentsOf: audioFileUrl)
            } catch { print("error URL") }
            
            playerRotationSound.play()
            playerRotationSound.numberOfLoops = -1
            
        } else {
            print("audio file is not found")
        }

        }//sender.began
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.rotationSound != nil {
            let audioFileUrl = NSURL.fileURL(withPath: self.rotationSound!)
            
            do{
                playerRotationSound = try AVAudioPlayer(contentsOf: audioFileUrl)
            } catch { print("error URL") }
            
            
            playerRotationSound.stop()
            
        } else {
            print("audio file is not found")
        }
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        rotate360Degrees(duration: 1200.0, completionDelegate: nil)
    }
    
    override func loadView() {
        super.loadView()
        
        rotate360Degrees(duration: 1200.0, completionDelegate: nil)
    }
    
    func rotate360Degrees(duration: CFTimeInterval, completionDelegate: AnyObject?) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * -(600.0))
        rotateAnimation.duration = duration
        rotateAnimation.autoreverses = false
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as? CAAnimationDelegate
        }
        self.logo.layer.add(rotateAnimation, forKey: nil)
    }
}
