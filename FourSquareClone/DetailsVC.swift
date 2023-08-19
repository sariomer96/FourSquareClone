//
//  DetailsVC.swift
//  FourSquareClone
//
//  Created by Omer on 18.08.2023.
//

import UIKit
import Parse
import MapKit

class DetailsVC: UIViewController {
    @IBOutlet weak var detailsImageView: UIImageView!
    
    @IBOutlet weak var detailsPlaceNameLabel: UILabel!
    @IBOutlet weak var detailsPlaceTypeLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    @IBOutlet weak var detailsPlaceAtmosphereLabel: UILabel!
    var chosenPlaceId = ""
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    override func viewDidLoad() {
        super.viewDidLoad()

        getDataFromParse()
        // Do any additional setup after loading the view.
    }
    

    func getDataFromParse(){
        
        let query = PFQuery(className: "Places")
        
        // OBJECTS
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground {
            (objects,error) in
            if error != nil {
                
                
            }else{
                if objects != nil {
                    let chosenPlaceObject = objects![0]
                  
                    if let placeName = chosenPlaceObject.object(forKey:"name" ) as? String {
                        self.detailsPlaceNameLabel.text = placeName
                    }
                    if let placeType = chosenPlaceObject.object(forKey:"type" ) as? String {
                        self.detailsPlaceTypeLabel.text = placeType
                    }
                    if let placeAtmosp = chosenPlaceObject.object(forKey:"atmosphere" ) as? String {
                        self.detailsPlaceAtmosphereLabel.text = placeAtmosp
                    }
                    if let placeLatitude = chosenPlaceObject.object(forKey:"latitude" ) as? String {
                        if let placeLatitudeDouble = Double(placeLatitude){
                            self.chosenLatitude = placeLatitudeDouble
                        }
                    }
                    if let placeLongitude = chosenPlaceObject.object(forKey:"longitude" ) as? String {
                        if let placeLongitudeDouble = Double(placeLongitude){
                            self.chosenLongitude = placeLongitudeDouble
                        }
                    }
                    
                    if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject{
                        imageData.getDataInBackground{
                            (data,error) in
                            if error == nil {
                                if data != nil {
                                    self.detailsImageView.image = UIImage(data: data!)
                                }
                                
                            }
                        }
                    }
                    
                    //MAPS
                    
                    let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.detailsMapView.setRegion(region, animated : true)
                    let annotation = MKPointAnnotation()
                    
                    annotation.coordinate = location
                    annotation.title = self.detailsPlaceNameLabel.text!
                    annotation.subtitle = self.detailsPlaceTypeLabel.text!
                    self.detailsMapView.addAnnotation(annotation)
                }
            }
        }
    }
}
