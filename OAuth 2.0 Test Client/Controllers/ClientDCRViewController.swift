//
//  ClientDCRViewController.swift
//  OAuth 2.0 Test Client
//
//  Created by Thorin on 2018-01-19.
//  Copyright © 2018 SOA Architects Inc. All rights reserved.
//

import UIKit
import Alamofire
import Eureka

class ClientDCRViewController: FormViewController {

    let oauth2APIManager = OAuth2APIManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        form +++ Section("Client Information")
            <<< TextRow() { row in
                row.title = "Client Name"
                row.placeholder = "Human-readable display name"
                row.tag = "name"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnBlur
            }
            .cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            <<< TextRow() { row in
                row.title = "Client URI"
                row.placeholder = "Client's homepage"
                row.tag = "clientURI"
            }
            <<< URLRow() { row in
                row.title = "Redirect URI"
                row.placeholder = "URI"
                row.tag = "redirectURI"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnBlur
            }
            .cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        +++ Section("OAuth 2.0 Configuration")
            <<< MultipleSelectorRow<String>() {
                $0.title = "Grant Types"
                $0.selectorTitle = "Select the supported grant types"
                $0.options = ["Authorization Code", "Implicit", "client_credentials", "Refresh Token"]
                $0.tag = "grantTypes"
            }
            <<< SegmentedRow<String>() {
                $0.title = "Response Types"
                $0.options = ["code", "token"]
                $0.value = "Code"
                $0.tag = "responseType"
            }
            <<< MultipleSelectorRow<String>() {
                $0.title = "Token Endpoint Authentication"
                $0.selectorTitle = "Select the authentication type"
                $0.options = ["client_secret_basic", "Client Secret Post"]
                $0.tag = "endpointAuth"
            }
            <<< TextRow() { row in
                row.title = "Scope"
                row.placeholder = "Space-separated values"
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        print("Processign form data...")
        let valuesDictionary = form.values()
        var dcrData: Parameters = [:]
        dcrData["client_name"] = valuesDictionary["name"]!
        let redirectURL = valuesDictionary["redirectURI"]! as! URL
        dcrData["redirect_uris"] = [redirectURL.absoluteString]
        dcrData["grant_types"] = Array(valuesDictionary["grantTypes"] as! Set<String>) as Any
        dcrData["response_type"] = valuesDictionary["responseType"]!
        let authArray = Array(valuesDictionary["endpointAuth"] as! Set<String>)
        dcrData["token_endpoint_auth_method"] = authArray.first
        for (rowTag, value) in dcrData {
            print("\(rowTag) - \(value)")
        }
        oauth2APIManager.dynamicallyRegisterClient(dcrData: dcrData) { clientResponse in
            print(clientResponse)
        }
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
