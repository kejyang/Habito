//
//  AccountsViewModel.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import Foundation

class AccountViewModel: ObservableObject {
    @Published var account : AccountModel?

    @Published var isLoggedIn = false
    
    enum ValidationResponse {
        case valid
        case emailEmpty
        case emailContainsSpace
        case invalidEmailFormat
        case emailInUse
        case passwordNotMatching
        case passwordNotLong
        case passwordNoSpecialCharacter
        case passwordNoNumber
        case passwordNoCapital
    }
    
    init() {
        AccountDAO.shared.createDatabase()
        AccountDAO.shared.createAccountTable()
    }
    
    func validateLogin(email: String, password: String) -> Bool {
        if LoginValidator.shared.validate(email: email, password: password) {
            return true
        }
        return false
    }
    
    func attemptLogin(email: String, password: String) -> Bool {
        if let account = AccountDAO.shared.fetchAccountByEmailAndPassword(email: email.lowercased() as NSString, password: password as NSString) {
            setSignedInAccount(accountModel: account)
            return true
        }
        return false
    }
    
    func validateSignup(username: String, email: String, password: String, confirmPassword: String) -> Bool {
        if SignupValidator.shared.validate(username: username, email: email, password: password, confirmPassword: confirmPassword).isEmpty {
            return true
        }
        return false
    }
    
    func signupAccount(username: String, email: String, password: String) -> AccountModel? {
        AccountDAO.shared.insertAccount(username: username as NSString, email: email.lowercased() as NSString, password: password as NSString)
        return AccountDAO.shared.fetchAccountByEmail(email: email.lowercased() as NSString)
    }
    
    func attemptSignup(username: String, email: String, password: String, confirmPassword: String) -> Dictionary<ValidationResponse,Bool> {
        let validationResponses = SignupValidator.shared.validate(username: username, email: email, password: password, confirmPassword: confirmPassword)
        
        var responseDictionary = Dictionary<ValidationResponse,Bool>()
        responseDictionary[ValidationResponse.valid] = validationResponses.isEmpty
        responseDictionary[ValidationResponse.emailEmpty] = validationResponses.contains(SignupValidator.ValidationResponse.emailEmpty)
        responseDictionary[ValidationResponse.emailContainsSpace] = validationResponses.contains(SignupValidator.ValidationResponse.emailContainsSpace)
        responseDictionary[ValidationResponse.invalidEmailFormat] = validationResponses.contains(SignupValidator.ValidationResponse.invalidEmailFormat)
        responseDictionary[ValidationResponse.emailInUse] = validationResponses.contains(SignupValidator.ValidationResponse.emailInUse)
        responseDictionary[ValidationResponse.passwordNotMatching] = validationResponses.contains(SignupValidator.ValidationResponse.passwordNotMatching)
        responseDictionary[ValidationResponse.passwordNotLong] = validationResponses.contains(SignupValidator.ValidationResponse.passwordNotLong)
        responseDictionary[ValidationResponse.passwordNoSpecialCharacter] = validationResponses.contains(SignupValidator.ValidationResponse.passwordNoSpecialCharacter)
        responseDictionary[ValidationResponse.passwordNoNumber] = validationResponses.contains(SignupValidator.ValidationResponse.passwordNoNumber)
        responseDictionary[ValidationResponse.passwordNoCapital] = validationResponses.contains(SignupValidator.ValidationResponse.passwordNoCapital)
        
        guard validationResponses.isEmpty else {
            return responseDictionary
        }
        
        if let account = signupAccount(username: username, email: email, password: password) {
            setSignedInAccount(accountModel: account)
        } else {
            responseDictionary[ValidationResponse.valid] = false
        }
        
        return responseDictionary
    }
    
    func setSignedInAccount(accountModel: AccountModel) {
        account = accountModel
    }
}
