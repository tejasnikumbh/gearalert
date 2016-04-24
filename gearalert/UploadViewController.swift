//
//  UploadViewController.swift
//  gearalert
//
//  Created by Tejas Nikumbh on 4/23/16.
//  Copyright © 2016 Personal. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {
    
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var fishGearPhoto: UIImageView!
    @IBOutlet weak var editDetailsImageViewButton: UIImageView!
    
    
    @IBOutlet weak var gearNameLabel: UILabel!
    @IBOutlet weak var gearLocationLabel: UILabel!
    @IBOutlet weak var gearDescriptionLabel: UILabel!
    
    @IBOutlet weak var fishGearBackgroundImageView: UIImageView!
    @IBOutlet weak var fishGearMainImageView: UIImageView!
    
    @IBAction func uploadTapped(sender: UIButton) {
        
        // Uploading code
        
        // Thankyou code
        let dialog = getDisplayDialog(message: "You just saved a baby seal!")
        self.presentViewController(dialog, animated: true, completion: nil)
    }
    
    func tapOnCamera(gestureRecognizer: UITapGestureRecognizer) {
        let choosePictureController = UIAlertController(title: "PLEASE CHOOSE A METHOD",
            message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera",
            style: UIAlertActionStyle.Default, handler: {
                (action: UIAlertAction) -> Void in
                self.presentViewControllerWithSourceType(UIImagePickerControllerSourceType.Camera)
                choosePictureController.dismissViewControllerAnimated(true, completion: nil)
        })
        let galleryAction = UIAlertAction(title: "Gallery",
            style: UIAlertActionStyle.Default, handler: {
                (action: UIAlertAction) -> Void in
                self.presentViewControllerWithSourceType(UIImagePickerControllerSourceType.PhotoLibrary)
                choosePictureController.dismissViewControllerAnimated(true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel, handler: nil)
        
        choosePictureController.addAction(cameraAction)
        choosePictureController.addAction(galleryAction)
        choosePictureController.addAction(cancelAction)
        
        self.presentViewController(choosePictureController, animated: true, completion: nil)
    }
    
    func tapOnEditDetails(gestureRecognizer: UITapGestureRecognizer) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : FormViewController = storyboard
            .instantiateViewControllerWithIdentifier("FormViewController")
            as! FormViewController
        vc.completionBlock = {
            if(CurrentFishGear.title != nil && CurrentFishGear.locationName != nil) {
                self.gearNameLabel.text = CurrentFishGear.title
                self.gearLocationLabel.text = CurrentFishGear.locationName
                self.gearDescriptionLabel.text = CurrentFishGear.description()
            }
        }
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAndStyleViews()
        setupGestureRecognizers()
    }
    
    func setupGestureRecognizers() {
        var tapGR = UITapGestureRecognizer(target: self,
                action: Selector("tapOnCamera:"))
        cameraImageView.addGestureRecognizer(tapGR)
        tapGR = UITapGestureRecognizer(target: self,
            action: Selector("tapOnEditDetails:"))
        editDetailsImageViewButton.addGestureRecognizer(tapGR)
    }
    
    func setupAndStyleViews() {
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame.origin = CGPointMake(0, 0)
        blurView.frame.size.width = UIScreen.mainScreen().bounds.width
        blurView.frame.size.height = 384
        fishGearBackgroundImageView.addSubview(blurView)
    }
    
    func presentViewControllerWithSourceType(
        imagePickerSourceType: UIImagePickerControllerSourceType) {
        if(UIImagePickerController.isSourceTypeAvailable(imagePickerSourceType)) {
            let imagePickerView = UIImagePickerController()
            imagePickerView.allowsEditing = true
            imagePickerView.delegate = self
            imagePickerView.sourceType = imagePickerSourceType
            self.presentViewController(imagePickerView, animated: true, completion: nil)
        }
    }
    
    func saveUserProfilePic(image: UIImage!) {
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        let imageName = "current_gear.jpg"
        // Start saving image in background
        fishGearMainImageView.image = image!
        CurrentFishGear.image = image!
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

// Extension for picking photo
extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK:- UIIMagePickerControllerDelegate methods
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingImage image: UIImage,
        editingInfo: [String : AnyObject]?) {
            self.dismissViewControllerAnimated(true, completion: nil)
            self.saveUserProfilePic(image)
    }
}
