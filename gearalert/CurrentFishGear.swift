
import UIKit

class CurrentFishGear: NSObject {
    static var title: String?
    static var locationName: String?
    static var lat: Double?
    static var long: Double?
    static var image: UIImage?
    
    override static func description() -> String{
        return "Currently reporting a \(title!) found near \(locationName!)"
    }
}
