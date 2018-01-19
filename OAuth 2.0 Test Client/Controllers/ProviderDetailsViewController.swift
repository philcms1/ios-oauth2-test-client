//
//  ProviderDetailsViewController.swift
//  OAuth 2.0 Test Client
//
//  Created by Thorin on 2018-01-10.
//  Copyright © 2018 SOA Architects Inc. All rights reserved.
//

import UIKit

class ProviderDetailsViewController: UIViewController {

    var provider: ProviderMO?
    
    @IBOutlet var providerNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        providerNameLabel.text = provider?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
