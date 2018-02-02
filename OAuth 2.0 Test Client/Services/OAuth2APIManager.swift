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
    
    func dynamicallyRegisterClient(url: String, dcrData: Parameters, completion: @escaping (JSON) -> Void) {
        TestSessionManager.Manager.request(url, method: .post, parameters: dcrData, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
