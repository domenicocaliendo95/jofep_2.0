//
//  Credits.swift
//  Inspectron2.0
//
//  Created by Gemito Gennaro on 16/05/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import Foundation
import UIKit

class Credits: UIViewController{
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var spritz: UIImageView!
    
    @IBAction func bottoneDomenico(_ sender: UIButton) {
        
        if let url = NSURL(string: "https://www.linkedin.com/in/domenico-caliendo-76b40a127/"){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
    }
    
    @IBAction func bottoneGennaro(_ sender: UIButton) {
        
        if let url = NSURL(string: "https://www.linkedin.com/in/gennaro-gemito-a609a9107"){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    
    let rotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 360))
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        self.spritz.alpha = 0.3
    }//fine viewDidLoad()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        rotate360Degrees()
    }
    
    func rotate360Degrees(duration: CFTimeInterval = 120.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * -(60.0))
        rotateAnimation.duration = duration
        rotateAnimation.autoreverses = false
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as? CAAnimationDelegate
        }
        self.logo.layer.add(rotateAnimation, forKey: nil)
    }
}
