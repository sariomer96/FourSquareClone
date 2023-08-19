//
//  DetailsVC.swift
//  FourSquareClone
//
//  Created by Omer on 18.08.2023.
//

import UIKit
import MapKit

class DetailsVC: UIViewController {
    @IBOutlet weak var detailsImageView: UIImageView!
    
    @IBOutlet weak var detailsPlaceNameLabel: UILabel!
    @IBOutlet weak var detailsPlaceTypeLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    @IBOutlet weak var detailsPlaceAtmosphereLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
