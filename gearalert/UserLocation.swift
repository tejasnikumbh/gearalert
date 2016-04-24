//
//  FishGear.swift
//  gearalert
//
//  Created by Tejas Nikumbh on 4/23/16.
//  Copyright © 2016 Personal. All rights reserved.
//

import MapKit

class UserLocation: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, locationName: String?, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    
}
