//
//  DynamicClientRequest.swift
//  OAuth 2.0 Test Client
//
//  Created by Thorin on 2018-01-22.
//  Copyright © 2018 SOA Architects Inc. All rights reserved.
//

import Foundation

class DynamicClientRequest {
    
    var clientName: String
    var redirectURIs: [String]
    var grantTypes: [String]
    var responseType: String
    var tokenEndpointAuthMethod: String
    
    static var GrantTypes: [String:String] = [
        "Client Credentials": "client_credentials",
        "Authorization Code": "authorization_code",
        "Implicit": "implicit",
        "Refresh Token": "refresh_token"
    ]
    static var ResponseTypes: [String:String] = [
        "Code": "code",
        "Token": "token"
    ]
    static var TokenEndpointAuth: [String:String] = [
        "Client Secret Basic": "client_secret_basic",
        "Client Secret Post": "client_secret_post"
    ]
    
    init() {
        self.clientName = ""
        self.redirectURIs = []
        self.grantTypes = []
        self.responseType = ""
        self.tokenEndpointAuthMethod = ""
    }
}
