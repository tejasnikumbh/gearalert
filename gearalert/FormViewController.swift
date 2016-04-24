//
//  FormViewController.swift
//  gearalert
//
//  Created by Tejas Nikumbh on 4/24/16.
//  Copyright © 2016 Personal. All rights reserved.
//

import UIKit
import CoreLocation

class FormViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var fishgearTypeTextField: UITextField!
    @IBOutlet weak var fishgearLocationTextField: UITextField!
    @IBOutlet weak var backgroundDarkImage: UIImageView!
    
    var completionBlock: (()->())?
    var locationManager: CLLocationManager = CLLocationManager()
    var lat: Double?
    var long: Double?
    override func viewDidLoad() {
        setupAndStyleViews()
        setupGestureRecognizers()
        configureLocationManager()
    }
    
    func configureLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setupGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: Selector("resignKeyboard:"))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func dismissButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveButton(sender: AnyObject) {
        if(fishgearTypeTextField.text == "") {
            let dialog = getDisplayDialog(message: "Please enter some gear type")
            self.presentViewController(dialog, animated: true, completion: nil)
            return
        }
        
        if(fishgearLocationTextField.text == "") {
            let dialog = getDisplayDialog(message: "Please enter a location name. If you don't know it, type 'Unknown'")
            self.presentViewController(dialog, animated: true, completion: nil)
            return
        }
        CurrentFishGear.title = fishgearTypeTextField.text
        CurrentFishGear.locationName = fishgearLocationTextField.text
        CurrentFishGear.lat = lat
        CurrentFishGear.long = long
        self.dismissViewControllerAnimated(true, completion: {
            self.completionBlock!()
        })
    }
    
    func setupAndStyleViews() {
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame.origin = CGPointMake(0, 0)
        blurView.frame.size.width = UIScreen.mainScreen().bounds.width
        blurView.frame.size.height = UIScreen.mainScreen().bounds.height
        backgroundDarkImage.addSubview(blurView)
    }
    
    func resignKeyboard(gestureRecognizer: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation = locations[locations.count - 1]
        lat = latestLocation.coordinate.latitude
        long = latestLocation.coordinate.longitude
        print(lat)
        print(long)
        
    }
    
    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!) {
            
    }
    
    func getDisplayDialog(title: String? = "Gear Alert",
        message: String?) -> UIAlertController
    {
        let alertDialog = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default,
            handler: nil)
        alertDialog.addAction(okAction)
        return alertDialog
    }

}
