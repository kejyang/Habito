//
//  AccountKeyChain.swift
//  Habito
//
//  Created by admin on 2/12/25.
//

import Foundation

class AccountKeyChain {
    
    static var shared = AccountKeyChain()
    
    private init() {}
    
    let userDefault = UserDefaults.standard
    
    func saveRememberAccount(email: String, isRememberMe: Bool) {
        if isRememberMe {
            userDefault.set(email.lowercased(), forKey: "email")
        } else {
            userDefault.set("", forKey: "email")
        }
        
        userDefault.set(isRememberMe, forKey: "remember")
    }
    
    
    func getRememberAccount() -> (String, Bool){
        let userID = userDefault.string(forKey: "email")
        let state = userDefault.bool(forKey: "remember")
        
        if userID != nil {
            return (userID!, state)
        }
        return ("", false)
        
    }
    
    
    func saveKey(email: String, password: String) {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email.lowercased(),
            kSecValueData as String : password.data(using: .utf8)!]
        
        if SecItemAdd(attributes as CFDictionary, nil) == errSecSuccess {
            print("Data saved successfully")
        } else {
            print("Data not saved")
        }
    }
    
    
    func updateKey(email: String, password: String) {
        let req : [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : email.lowercased()
        ]
        let passwordAtt : [String : Any] = [kSecValueData as String : password.data(using: .utf8)!]
        
        if SecItemUpdate(req as CFDictionary, passwordAtt as CFDictionary) == noErr {
            print("Key has been updated")
        } else {
            print("Error")
        }
    }
    
    func deleteKey(email: String) {
        let req : [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String : email.lowercased()
        ]
        if SecItemDelete(req as CFDictionary) == noErr {
            print("Key has been deleted")
        } else {
            print("Data not found")
        }
    }
    
    func getKey(email: String) -> (String?, String?) {
        let request : [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : email.lowercased(),
            kSecReturnAttributes as String : true,
            kSecReturnData as String : true
        ]
        var response : CFTypeRef?
        
        if SecItemCopyMatching(request as CFDictionary, &response) == noErr {
            let data = response as? [String : Any]
            let userID = data?[kSecAttrAccount as String] as? String
            let password = (data![kSecValueData as String] as? Data)!
            let passStr = String(data: password, encoding: .utf8)
            return (userID!, passStr!)
        }
        return (nil, nil)
    }
    
}
