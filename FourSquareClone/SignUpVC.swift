//
//  ViewController.swift
//  FourSquareClone
//
//  Created by Omer on 12.08.2023.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var usernameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // Do any additional setup after loading the view.
        
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) {
                (user,error) in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "error")
                }else{
                    
//                    SEGUE
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }else{
            makeAlert(titleInput:"Error", messageInput: "User-Password?")
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            let user=PFUser()
            
            user.password=passwordText.text!
            user.username=usernameText.text!
            
            user.signUpInBackground{
                (success,error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                }else{
//                    Segue
                    print("ok")
                }
            }
            
        }else{
            makeAlert(titleInput: "error", messageInput: "Username-password??")
        }
    }
    
    
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

