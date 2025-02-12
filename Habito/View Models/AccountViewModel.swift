//
//  AccountsViewModel.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import Foundation

class AccountViewModel: ObservableObject {
    @Published var account : AccountModel?
    
    func validateLogin(email: String, password: String) -> Bool {
        if LoginValidator.shared.validate(email: email, password: password) {
            return true
        }
        return false
    }
    
    func validateSignup(username: String, email: String, password: String, confirmPassword: String) -> Bool {
        if SignupValidator.shared.validate(username: username, email: email, password: password, confirmPassword: confirmPassword) == SignupValidator.ValidationResponse.valid {
            return true
        }
        return false
    }
    
    func signupAccount(username: String, email: String, password: String, confirmPassword: String) {
        
    }
    
    func setSignedInAccount() {
        //account = AccountModel()
    }
}
