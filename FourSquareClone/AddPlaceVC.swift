//
//  AddPlaceVC.swift
//  FourSquareClone
//
//  Created by Omer on 16.08.2023.
//

import UIKit

class AddPlaceVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeAtmosphereText: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeNameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled=true
        
        let gestureRecognize=UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognize)
        // Do any additional setup after loading the view.
    }
    
    @objc func chooseImage(){
            let picker=UIImagePickerController()
        
        picker.delegate=self
        picker.sourceType = .photoLibrary
        self.present(picker, animated:true)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
   
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if placeNameText.text != "" && placeType.text != "" && placeAtmosphereText.text != "" {
            if let chosenImage = placeImageView.image {
                
                let placeModel = PlaceModel.sharedInstance
                
                placeModel.placeName = placeNameText.text!
                placeModel.placeType = placeType.text!
                placeModel.placeAtmosphere = placeAtmosphereText.text!
                placeModel.placeImage = chosenImage
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        }else{
            let alert = UIAlertController(title: "Error", message: "Place Name/type/atmosphere??", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
            present(alert, animated: true)
        }
        
       
    }
    
}
