//
//  LoginValidator.swift
//  Habito
//
//  Created by admin on 2/12/25.
//

import Foundation

class LoginValidator {
    
    static var shared = LoginValidator()
    
    private init() {}
    
    func validate(email: String, password: String) -> Bool {
        if let _ = AccountDAO.shared.fetchAccountByEmailAndPassword(email: email as NSString, password: password as NSString) {
            return true
        }
        
        return false
    }
    
}
