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
    let oauth2Config = OAUth2Config.sharedInstance
    var viewModel: ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        form +++ Section("Client Information")
            <<< TextRow() {
                $0.title = "Client Name"
                $0.placeholder = "Human-readable display name"
                $0.onChange { [unowned self] row in
                    if let name = row.value {
                        self.viewModel.name = name
                    }
                }
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                $0.cellUpdate { (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            }
            <<< URLRow() {
                $0.title = "Client URI"
                $0.placeholder = "Client's homepage"
            }
            <<< URLRow() {
                $0.title = "Redirect URI"
                $0.placeholder = "URI"
                $0.onChange { [unowned self] row in
                    if let theURL = row.value {
                        self.viewModel.redirectURIs = [theURL.absoluteString]
                    }
                }
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                $0.cellUpdate { (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            }
        +++ Section("OAuth 2.0 Configuration")
            <<< MultipleSelectorRow<String>() {
                $0.title = "Grant Types"
                $0.selectorTitle = "Select the supported grant types"
                $0.options = ["Authorization Code", "Implicit", "Client Credentials", "Refresh Token"]
                $0.onChange { [unowned self] row in
                    if let grantTypes = row.value {
                        self.viewModel.grantTypes = Array(grantTypes)
                    }
                }
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnBlur
            }
            <<< SegmentedRow<String>() {
                $0.title = "Response Types"
                $0.options = ["Code", "Token"]
                $0.onChange { [unowned self] row in
                    if let responseType = row.value {
                        self.viewModel.responseType = responseType
                    }
                }
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnBlur
            }
            <<< PushRow<String>() {
                $0.title = "Token Endpoint Authentication"
                $0.selectorTitle = "Select the authentication type"
                $0.options = ["Client Secret Basic", "Client Secret Post"]
                $0.onChange { [unowned self] row in
                    if let endpointAuth = row.value {
                        self.viewModel.tokenEndpointAuthMethod = endpointAuth
                    }
                }
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnBlur
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
        print("Client name: \(String(describing: self.viewModel.name))")
        print("Redirect URIs: \(self.viewModel.redirectURIs)")
        print("Grant Types: \(self.viewModel.grantTypes)")
        print("Response Type: \(String(describing: self.viewModel.responseType))")
        print("Token Endpoint Auth: \(String(describing: self.viewModel.tokenEndpointAuthMethod))")
        // TODO: handle optional values:
        // if let foo = dcrData.foo { parameters["bar"] = foo }
        let parameters: Parameters = [
            "client_name" : viewModel.name,
            "redirect_uris" : viewModel.redirectURIs,
            "grant_types" : viewModel.grantTypes,
            "response_type" : viewModel.responseType,
            "token_endpoint_auth_method" : viewModel.tokenEndpointAuthMethod,
            ]
        
        oauth2APIManager.dynamicallyRegisterClient(url: (self.oauth2Config.selectedProvider.registrationEndpoint?.absoluteString)!, dcrData: parameters) { json in
            print("JSON: \(json)")
//            let statusCode = json["statusCode"].int
//            if let statusCode = statusCode {
//                if (statusCode != 200) {
//                    print("Something wrong happened... \(statusCode)")
//                } else {
//                    
//                }
//            }
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let client = ClientMO(context: context)
//                print("ID: \(json["client_id"].string!)")
//                let theUUID = UUID(uuidString: json["client_id"].string! as String)
//                print(theUUID!)
                client.id = UUID()
                print(client.id!)
                print("Secret: \(json["client_secret"].string!)")
                client.secret = json["client_secret"].string!
                print(client.secret!)
                client.isActive = true
                print(client.isActive)
                client.name = self.viewModel.name
                print(client.name!)
//                print(self.viewModel.redirectURIs[0])
                client.redirectURI = URL(string: self.viewModel.redirectURIs[0])
                print(client.redirectURI!)
                client.grantType = self.viewModel.grantTypes[0]
                print(client.grantType!)
                client.responseType = self.viewModel.responseType
                print(client.responseType!)
                client.tokenEndpointAuthMethod = self.viewModel.tokenEndpointAuthMethod
                print(client.tokenEndpointAuthMethod!)
                print(client)
                if let currentProvider = self.oauth2Config.selectedProvider {
                    print("Saving the client...")
                    currentProvider.addToClients(client)
                    appDelegate.saveContext()
                }
            }
            
            self.dismiss(animated: true, completion: nil)
            
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
