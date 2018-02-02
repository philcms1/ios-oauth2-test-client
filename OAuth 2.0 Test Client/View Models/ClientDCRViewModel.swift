//
//  ClientDCRViewModel.swift
//  OAuth 2.0 Test Client
//
//  Created by Thorin on 2018-01-22.
//  Copyright © 2018 SOA Architects Inc. All rights reserved.
//

import UIKit

extension ClientDCRViewController {
    
    class ViewModel {
        
        private let dcrRequest: DynamicClientRequest = DynamicClientRequest()
        
        var name: String {
            get {
                return dcrRequest.clientName
            }
            set {
                dcrRequest.clientName = newValue
            }
        }
        
        var redirectURIs: [String] {
            get {
                return dcrRequest.redirectURIs
            }
            set {
                dcrRequest.redirectURIs = newValue
            }
        }
        
        var grantTypes: [String] {
            get {
                return dcrRequest.grantTypes
            }
            set {
                dcrRequest.grantTypes = self.convertGrantTypes(grantTypes: newValue)
            }
        }
        
        var responseType: String {
            get {
                return dcrRequest.responseType
            }
            set {
                if let formattedResponseType = DynamicClientRequest.ResponseTypes[newValue] {
                    dcrRequest.responseType = formattedResponseType
                }
            }
        }
        
        var tokenEndpointAuthMethod: String {
            get {
                return dcrRequest.tokenEndpointAuthMethod
            }
            set {
                if let formattedTokenEndpointAuth = DynamicClientRequest.TokenEndpointAuth[newValue] {
                    dcrRequest.tokenEndpointAuthMethod = formattedTokenEndpointAuth
                }
            }
        }
        
        // MARK - Actions and Utils
        private func convertGrantTypes(grantTypes: [String]) -> [String] {
            var arrayGrantTypes: [String] = []
            for type in grantTypes {
                if let formattedGrantType = DynamicClientRequest.GrantTypes[type] {
                    arrayGrantTypes.append(formattedGrantType)
                }
            }
            return arrayGrantTypes
        }
        
        func registerClient() {
            
        }
    }
}
