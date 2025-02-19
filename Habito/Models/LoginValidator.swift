//
//  LoginValidator.swift
//  Habito
//
//  Created by admin on 2/12/25.
//

import Foundation

class LoginValidator {
    
    static var shared = LoginValidator()
    
    var accountDB = AccountDAO.shared
    
    private init() {}
    
    init(isUnitTesting: Bool) {
        if isUnitTesting {
            accountDB.createDatabase(inMemory: true)
        }
    }
    
    func validate(email: String, password: String) -> Bool {
        if let _ = accountDB.fetchAccountByEmailAndPassword(email: email as NSString, password: password as NSString) {
            return true
        }
        
        return false
    }
    
}
