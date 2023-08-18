//
//  PlacesVC.swift
//  FourSquareClone
//
//  Created by Omer on 15.08.2023.
//

import UIKit
import Parse

class PlacesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
        // Do any additional setup after loading the view.
    }
    
    @objc func addButtonClicked() {
//         SEGUE
        performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
        
    }
    
    @objc func logoutButtonClicked(){
        PFUser.logOutInBackground{(error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler : nil)
                
                alert.addAction(okButton)
                self.present(alert,animated: true)
            }else{
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
    }

}
