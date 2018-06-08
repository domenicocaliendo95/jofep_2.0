//
//  PreviewViewController.swift
//  Inspectron2.0
//
//  Created by Gemito Gennaro on 24/05/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    var image: UIImage!
    
    @IBOutlet var photo: UIImageView!
    
    
    @IBOutlet var bottoneCancel: UIButton!
    @IBOutlet var bottoneSave: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bottoneSave.layer.cornerRadius = 3
        self.bottoneSave.layer.borderWidth = 1
        self.bottoneSave.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        
        self.bottoneCancel.layer.cornerRadius = 3
        self.bottoneCancel.layer.borderWidth = 1
        self.bottoneCancel.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        photo.image = self.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)//ritorna alla view controller
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
