//
//  MainViewController.swift
//  gearalert
//
//  Created by Tejas Nikumbh on 4/23/16.
//  Copyright © 2016 Personal. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = UIColor(red: 32 / 255.0, green: 32 / 255.0, blue: 32 / 255.0, alpha: 1.0)
        
        let selectedMap = UIImage(named: "map_selected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let unselectedMap = UIImage(named: "map_unselected")
        let customHomeBarItem = UITabBarItem(title: "Home", image: unselectedMap, selectedImage: selectedMap)
        
        let selectedUpload = UIImage(named: "upload_selected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let unselectedUpload = UIImage(named: "upload_unselected")
        let customUploadBarItem = UITabBarItem(title: "Upload", image: unselectedUpload, selectedImage: selectedUpload)
        
        let selectedSettings = UIImage(named: "settings_selected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let unselectedSettings = UIImage(named: "settings_unselected")
        let customSettingsBarItem = UITabBarItem(title: "Settings", image: unselectedSettings, selectedImage: selectedSettings)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.grayColor()], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.yellowColor()], forState:.Selected)
        
        let homeVC = viewControllers![0]
        homeVC.tabBarItem = customHomeBarItem
        let uploadVC = viewControllers![1]
        uploadVC.tabBarItem = customUploadBarItem
        let settingsVC = viewControllers![2]
        settingsVC.tabBarItem = customSettingsBarItem

    }
}
