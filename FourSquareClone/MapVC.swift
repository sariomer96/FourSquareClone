//
//  MapVC.swift
//  FourSquareClone
//
//  Created by Omer on 18.08.2023.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem =
        UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem=UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        // Do any additional setup after loading the view.
    }
    
    @objc func backButtonClicked(){
        self.dismiss(animated: true)
    }
    
    @objc func saveButtonClicked()
    {
        //PARSE
    }
    


}
