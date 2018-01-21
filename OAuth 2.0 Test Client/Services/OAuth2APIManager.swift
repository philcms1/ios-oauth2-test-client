//
//  OAuth2APIManager.swift
//  OAuth 2.0 Test Client
//
//  Created by Thorin on 2018-01-19.
//  Copyright © 2018 SOA Architects Inc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class OAuth2APIManager {
    static let sharedInstance: OAuth2APIManager = OAuth2APIManager()
    
    func dynamicallyRegisterClient(dcrData: Parameters, completion: @escaping (JSON) -> Void) {
        
//        let parameters: Parameters = [
//            "client_name" : "ios_123456",
//            "redirect_uris" : ["http://localhost:1234/dummy"],
//            "grant_types" : ["client_credentials"],
//            "response_type" : "token",
//            "token_endpoint_auth_method" : "client_secret_basic",
//            ]
        TestSessionManager.Manager.request("https://localhost:8443/oauth2/register", method: .post, parameters: dcrData, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                completion(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
