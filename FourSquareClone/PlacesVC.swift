//
//  PlacesVC.swift
//  FourSquareClone
//
//  Created by Omer on 15.08.2023.
//

import UIKit
import Parse

class PlacesVC: UIViewController , UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNamerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNamerArray[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    var placeNamerArray = [String]()
    var placeIdArray = [String]()
    var selectedPlaceId = ""
    
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground{
            (objects,error) in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "ERROR")
            }else {
                if objects != nil{
                    
                    self.placeIdArray.removeAll()
                    self.placeNamerArray.removeAll()
                    
                    for object in objects!{
                        if let placeName = object.object(forKey: "name") as? String {
                            if let placeId = object.objectId{
                                
                                self.placeNamerArray.append(placeName)
                                self.placeIdArray.append(placeId)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromParse()
    }
    
    @objc func addButtonClicked() {
//         SEGUE
        performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
        
    }
    
    @objc func logoutButtonClicked(){
        PFUser.logOutInBackground{(error) in
            
            if error != nil {
                
                self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
            }else{
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationcVC = segue.destination as! DetailsVC
            
            destinationcVC.chosenPlaceId = selectedPlaceId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func makeAlert(titleInput:String,messageInput:String){
        let alert = UIAlertController(title: titleInput, message:messageInput, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler : nil)
        
        alert.addAction(okButton)
        self.present(alert,animated: true)
    }

}
