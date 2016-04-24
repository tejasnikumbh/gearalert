//
//  HomeViewController.swift
//  gearalert
//
//  Created by Tejas Nikumbh on 4/23/16.
//  Copyright © 2016 Personal. All rights reserved.
//

import UIKit
import MapKit
import AddressBook

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    let regionRadius:CLLocationDistance = 1000
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager = CLLocationManager()
    var lat: Double?
    var long: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Initial location for the map
        configureLocationManager()
        updateMap()
    }
    
    func updateMap() {
        let getEndpoint: String = "https://gear-alert.appspot.com/fishgears/json"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: getEndpoint)!
        
        // Make the GET call and handle it in a completion handler
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            // Read the JSON
            do {
                if let fishgearsString = NSString(data:data!, encoding: NSUTF8StringEncoding) {
                    // Print what we got from the call
                    print(fishgearsString)
                    
                    
                    // Parse the JSON to get the fishGears
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    // Empty Map Items
                    var fishgearObjs: [FishGear] = []
                    for item in jsonDictionary["fishgears"] as! NSArray {
                        let dict = item as! NSDictionary
                        let coordinate = CLLocationCoordinate2D(latitude: Double(dict["lat"]! as! NSNumber), longitude: Double(dict["long"]! as! NSNumber))
                        
                        let object = FishGear(title: dict["title"] as? String, locationName:dict["location_name"] as? String, warning: dict["warning"] as? String, image: dict["image"] as? String, coordinate: coordinate)
                        print(object)
                        fishgearObjs.append(object)
                    }
                    
                    // Update the label
                    self.performSelectorOnMainThread("updateMapWithGears:", withObject: fishgearObjs, waitUntilDone: false)
                }
            } catch {
                print("bad things happened")
            }
        }).resume()
    }
    
    
    
    func updateMapWithGears(fgs:[FishGear]){
        mapView.addAnnotations(fgs)
        let location = CLLocation(latitude: fgs[0].coordinate.latitude, longitude: fgs[0].coordinate.longitude)
        centerMapOnLocation(location)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            location.coordinate,
            regionRadius * 2.0,
            regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation = locations[locations.count - 1]
        lat = latestLocation.coordinate.latitude
        long = latestLocation.coordinate.longitude
        print(lat)
        print(long)
        let user = UserLocation(title: "You", locationName: "Your Location", coordinate: CLLocationCoordinate2D(latitude: lat!, longitude: long!))
        mapView.addAnnotation(user)
        
    }
    
    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!) {
            
    }
    
    func configureLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}


extension HomeViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation.isKindOfClass(FishGear)) {
            return nil
        }
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pins")
        if(annotation.isKindOfClass(UserLocation)) {
            annotationView.pinTintColor = UIColor.greenColor()
            print("Pin Color Set")
        } else {
            annotationView.pinTintColor = UIColor.redColor()
            print("Pin Color Set")
        }
        return annotationView
    }
}
