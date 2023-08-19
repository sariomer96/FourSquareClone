//
//  DetailsVC.swift
//  FourSquareClone
//
//  Created by Omer on 18.08.2023.
//

import UIKit
import Parse
import MapKit

class DetailsVC: UIViewController,MKMapViewDelegate{
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
        detailsMapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation){ (placemarks,error) in
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailsPlaceNameLabel.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
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
