//
//  AddPlaceVC.swift
//  FourSquareClone
//
//  Created by Omer on 16.08.2023.
//

import UIKit

class AddPlaceVC: UIViewController {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeAtmosphereText: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeNameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func nextButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
}
