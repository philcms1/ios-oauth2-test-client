//
//  TabBarController.swift
//  OAuth 2.0 Test Client
//
//  Created by Thorin on 2018-01-18.
//  Copyright © 2018 SOA Architects Inc. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var oauth2Config = OAUth2Config.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController,
            shouldSelect viewController: UIViewController) -> Bool {
        if viewController == tabBarController.viewControllers?[1] {
            guard (self.oauth2Config.selectedProvider) != nil else {
                present(self.getAlertController(message: "You must select a provider first."), animated: true)
                return false
            }
        } else if viewController == tabBarController.viewControllers?[2] {
            guard (self.oauth2Config.selectedProvider != nil) && (self.oauth2Config.selectedClient != nil) else {
                present(self.getAlertController(message: "You must select a client first."), animated: true)
                return false
            }
        }
        
        return true
    }
    
    private func getAlertController(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Action required", message: message, preferredStyle: .alert)
        let ackAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ackAction)
        return alert
    }
}
