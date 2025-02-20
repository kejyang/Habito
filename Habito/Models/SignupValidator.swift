//
//  SignupValidator.swift
//  Habito
//
//  Created by admin on 2/12/25.
//

import Foundation

class SignupValidator {
    
    static var shared = SignupValidator()
    
    private init() {}
    
    enum ValidationResponse : String {
        case valid = ""
        case emailEmpty = "Email cannot be empty"
        case emailContainsSpace = "Email cannot contain spaces"
        case invalidEmailFormat = "Email must be in the format abc@xyz.com"
        case emailInUse = "An account already exists with this email"
        case passwordNotMatching = "Passwords do not match"
        case passwordNotLong = "Password must be atleast 6 characters"
        case passwordNoSpecialCharacter = "Password must contain a special character"
        case passwordNoNumber = "Password must contain a number"
        case passwordNoCapital = "Password must contain a capital"
    }
    
    
    
    func validate(username: String, email: String, password: String, confirmPassword: String) -> [ValidationResponse] {
        var validationResponses: [ValidationResponse] = []
        
        if email.isEmpty {
            validationResponses.append(ValidationResponse.emailEmpty)
        }
        
        if email.contains(" ") {
            validationResponses.append(ValidationResponse.emailContainsSpace)
        }
        
        let emailRegEx = "[A-Z0-9a-z._-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,3}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        
        if !emailPredicate.evaluate(with: email) {
            validationResponses.append(ValidationResponse.invalidEmailFormat)
        }
        

        let acc = AccountDAO.shared.fetchAccountByEmail(email: email.lowercased() as NSString)
        if acc != nil {
            validationResponses.append(ValidationResponse.emailInUse)
        }
        
        /// Verify the password
        
        if password.count < 6 {
            validationResponses.append(ValidationResponse.passwordNotLong)
        }
        
        let specialCharacters = CharacterSet(charactersIn: "!@#$%^&*()_+-=<>?,./:\";'[]{}|\\")
        if let _ = password.rangeOfCharacter(from: specialCharacters) {
        } else {
            validationResponses.append(ValidationResponse.passwordNoSpecialCharacter)
        }
        
        let numericCharacters = CharacterSet(charactersIn: "1234567890")
        if let _ = password.rangeOfCharacter(from: numericCharacters) {
        } else {
            validationResponses.append(ValidationResponse.passwordNoNumber)
        }
        
        let capitalCharacters = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if let _ = password.rangeOfCharacter(from: capitalCharacters) {
        } else {
            validationResponses.append(ValidationResponse.passwordNoCapital)
        }
        
        if password != confirmPassword {
            validationResponses.append(ValidationResponse.passwordNotMatching)
        }
        
        return validationResponses
    }
    
    
}
