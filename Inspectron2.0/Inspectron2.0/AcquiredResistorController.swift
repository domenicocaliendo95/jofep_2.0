//
//  AcquiredResistorController.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico on 13/06/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import UIKit

class AcquiredResistorController: UIViewController {

    @IBAction func backButton(_ sender: UIBarButtonItem) {
        print("Back Button Clicked")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        print("salvato")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
