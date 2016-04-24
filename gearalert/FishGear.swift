//
//  FishGear.swift
//  gearalert
//
//  Created by Tejas Nikumbh on 4/23/16.
//  Copyright © 2016 Personal. All rights reserved.
//

import MapKit

class FishGear: NSObject, MKAnnotation {
    
    let title: String?
    let warning: String?
    let locationName: String?
    let image: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, locationName: String?, warning: String?,
        image: String?, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.warning = warning
        self.locationName = locationName
        self.image = image
        self.coordinate = coordinate
        super.init()
    }

    var subtitle: String? {
        return locationName
    }

}