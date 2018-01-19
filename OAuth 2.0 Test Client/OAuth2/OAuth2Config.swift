//
//  File.swift
//  OAuth 2.0 Test Client
//
//  Created by Thorin on 2018-01-17.
//  Copyright © 2018 SOA Architects Inc. All rights reserved.
//

import Foundation

class OAUth2Config {
    static let sharedInstance = OAUth2Config()
    // MARK - Properties
    var selectedProvider: ProviderMO!
    var selectedClient: ClientMO!
//    let selectedClient: ClientMO = nil
    func setProvider(provider: ProviderMO) {
        self.selectedProvider = provider
    }
    
    func removeProvider() {
        // TODO: remove client and token if exist
        self.selectedProvider = nil
    }
    
}
