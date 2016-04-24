import UIKit
import MapKit

class ColorPointAnnotation: MKPointAnnotation {
    var pinColor: UIColor
    
    init(pinColor: UIColor) {
        self.pinColor = pinColor
        super.init()
    }
}