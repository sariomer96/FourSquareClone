//
//  File.swift
//  FourSquareClone
//
//  Created by Omer on 19.08.2023.
//

import Foundation
import UIKit

class PlaceModel {
    
    
     static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init(){
        
    }

}
