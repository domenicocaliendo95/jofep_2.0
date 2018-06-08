//
//  CameraSettingsViewController.swift
//  Inspectron2.0
//
//  Created by Gemito Gennaro on 27/05/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import UIKit

protocol passPerformanceValue{
    
    func passPerformanceValue(performanceInt: Int)
    //l'implementazione di tale funzione va fatta nel viewController
    
}

protocol passDebugValue {
    func passDebugValue(debugInt: Int)
}


class CameraSettingsViewController: UIViewController{
    
    
    var i = 0
    @IBOutlet var level25: UILabel!
    @IBOutlet var level50: UILabel!
    @IBOutlet var level75: UILabel!
    @IBOutlet var level100: UILabel!
    @IBOutlet var warningOutletImage: UIImageView!
    
    var persistentDebug = UserDefaults.standard//settings persistenti
    @IBOutlet var debugOutlet: UISwitch!
    var debug_isActive: Bool?
    
    @IBAction func debugSwitch(_ sender: UISwitch) {
        
        if(debug_isActive == false){
            self.persistentDebug.set(1, forKey: "debugMode")
            print(String(describing: persistentDebug.object(forKey: "debugMode")))
            self.debugOutlet.setOn(true, animated: true)
            self.debug_isActive = true
        } else {
            self.persistentDebug.set(0, forKey: "debugMode")
            print(String(describing: persistentDebug.object(forKey: "debugMode")))
            self.debugOutlet.setOn(false, animated: true)
            self.debug_isActive = false
        }
        
    }
    
    
    
    @IBAction func infoPerformance(_ sender: UIButton) {
        
            let infoPerformance = UIAlertController(title:"Performance", message: "This setting allows you to change the number of frames analyzed per second: high level of performance increases recognition precision level but may slow down your device. Recommended level: 50%", preferredStyle: UIAlertControllerStyle.alert)
            
            infoPerformance.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                action in
                switch action.style{
                case .default:
                    break
                case .cancel:
                    break
                case .destructive:
                    break
                }
            }))
            
            self.present(infoPerformance, animated: true, completion: nil)
            
            
        
    }
    
    var delegatePassValue: passPerformanceValue? = nil//variabile associata al protocollo -> delegate
    var performanceLevel = 0
    
    
    var persistentPerformance = UserDefaults.standard//settings persistenti
    var delegateDebug: passDebugValue? = nil
    
    
    @IBOutlet var performanceOutlet: UISlider!
    
    @IBAction func performanceSlider(_ sender: UISlider){
        
        
        
        sender.value = roundf(sender.value)
        switch sender.value {
        case 1.0:
            i = 0
            
            persistentPerformance.set(15, forKey: "performanceLevel")
            self.level25.isEnabled = true
            self.level25.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            self.level50.isEnabled = false
            self.level75.isEnabled = false
            self.level100.isEnabled = false
            self.warningOutletImage.isHidden = true

        case 2.0:
            i = 0
            
            persistentPerformance.set(10, forKey: "performanceLevel")
            self.level25.isEnabled = false
            self.level50.isEnabled = true
            self.level50.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            self.level75.isEnabled = false
            self.level100.isEnabled = false
            self.warningOutletImage.isHidden = true

            
        case 3.0:
            i = 0
            
            persistentPerformance.set(5, forKey: "performanceLevel")
            self.level25.isEnabled = false
            self.level50.isEnabled = false
            self.level75.isEnabled = true
            self.level75.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            self.level100.isEnabled = false
            self.warningOutletImage.isHidden = true

            
        case 4.0:
            if(i == 0){
            let warningPerformance = UIAlertController(title:"Warning", message: "Setting performance levet to 100% improves resistor detection but it may drain your battery, overheat your device and waste memory resources", preferredStyle: UIAlertControllerStyle.alert)
                
                warningPerformance.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                    action in
                    switch action.style{
                    case .default:
                        break
                    case .cancel:
                        break
                    case .destructive:
                        break
                    }
                }))
                
                self.present(warningPerformance, animated: true, completion: nil)
            
              i = 1
            }
            persistentPerformance.set(2, forKey: "performanceLevel")
            self.level25.isEnabled = false
            self.level50.isEnabled = false
            self.level75.isEnabled = false
            self.level100.isEnabled = true
            self.level100.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            self.warningOutletImage.isHidden = false
            
            
        default:
            break
        }


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if(persistentDebug.object(forKey: "debugMode") as? Int == nil){//inizializzazione switch primo lancio
            self.persistentDebug.set(0, forKey: "debugMode")
            self.debugOutlet.setOn(false, animated: true)
            self.debug_isActive = false
        }
        
        if(persistentDebug.object(forKey: "debugMode") as! Int == 0){
        self.debug_isActive = false
        self.debugOutlet.setOn(false, animated: true)
        } else {
            self.debug_isActive = true
            self.debugOutlet.setOn(true, animated: true)
        }
        
        
        switch persistentPerformance.object(forKey: "performanceLevel") as! Int {
        case 2:
            performanceOutlet.value = 4
            self.level25.isEnabled = false
            self.level50.isEnabled = false
            self.level75.isEnabled = false
            self.level100.isEnabled = true
            self.level100.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            self.warningOutletImage.isHidden = false
            i = 1

        case 5:
            performanceOutlet.value = 3
            self.level25.isEnabled = false
            self.level50.isEnabled = false
            self.level75.isEnabled = true
            self.level75.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            self.level100.isEnabled = false
            self.warningOutletImage.isHidden = true
            i = 0

        case 10:
            performanceOutlet.value = 2
            self.level25.isEnabled = false
            self.level50.isEnabled = true
            self.level50.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            self.level75.isEnabled = false
            self.level100.isEnabled = false
            self.warningOutletImage.isHidden = true
            i = 0

        case 15:
            performanceOutlet.value = 1
            self.level25.isEnabled = true
            self.level25.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            self.level50.isEnabled = false
            self.level75.isEnabled = false
            self.level100.isEnabled = false
            self.warningOutletImage.isHidden = true
            i = 0


        default:
            break
        }
        
    }
    

    @IBAction func backCamera(_ sender: UIBarButtonItem) {
        
        //questa è proprio l'informazione da passare
        if (delegatePassValue != nil){
            
            delegatePassValue!.passPerformanceValue(performanceInt: (persistentPerformance.object(forKey: "performanceLevel") as! Int))
            self.navigationController?.popViewController(animated: true)
        }
        
        if(delegateDebug != nil){
            delegateDebug!.passDebugValue(debugInt: (persistentDebug.object(forKey: "debugMode") as! Int))
            self.navigationController?.popViewController(animated: true)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
