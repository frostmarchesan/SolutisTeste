//
//  KeyChainModel.swift
//  SolutisTeste
//
//  Created by Virtual Machine on 22/10/21.
//

import Foundation
import KeychainSwift

struct KeyChainModel {
    
    func storeData (data: String, key: String) {
        let userKeychain = KeychainSwift()
        userKeychain.set(data, forKey: key)
    }
    
    func getData (key: String) -> String {
        let userKeychain = KeychainSwift()
        return userKeychain.get(key) ?? ""
    }
    
    func eraseData(key: String) {
        let userKeychain = KeychainSwift()
        userKeychain.delete(key)
    }
}
