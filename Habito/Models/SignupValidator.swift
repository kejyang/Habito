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
    
    
    
    func validate(username: String, email: String, password: String, confirmPassword: String) -> ValidationResponse {
        guard email != "" else {
            return ValidationResponse.emailEmpty
        }
        
        guard !username.contains(" ") else {
            return ValidationResponse.emailContainsSpace
        }
        
        let emailRegEx = "[A-Z0-9a-z._-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,3}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        
        guard emailPredicate.evaluate(with: email) else {
            return ValidationResponse.invalidEmailFormat
        }
        
        let acc = AccountDAO.shared.fetchAccountByEmail(email: email as NSString)
        guard acc == nil else {
            return ValidationResponse.emailInUse
        }
        
        /// Verify the password
        
        guard password.count >= 6 else {
            return ValidationResponse.passwordNotLong
        }
        
        let specialCharacters = CharacterSet(charactersIn: "!@#$%^&*()_+-=<>?,./:\";'[]{}|\\")
        guard let _ = password.rangeOfCharacter(from: specialCharacters) else {
            return ValidationResponse.passwordNoSpecialCharacter
        }
        
        let numericCharacters = CharacterSet(charactersIn: "1234567890")
        guard let _ = password.rangeOfCharacter(from: numericCharacters) else {
            return ValidationResponse.passwordNoNumber
        }
        
        let capitalCharacters = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        guard let _ = password.rangeOfCharacter(from: capitalCharacters) else {
            return ValidationResponse.passwordNoCapital
        }
        
        guard password == confirmPassword else {
            return ValidationResponse.passwordNotMatching
        }
        
        
        return ValidationResponse.valid
    }
    
    
}
