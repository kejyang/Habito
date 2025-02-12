//
//  Account.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import Foundation

struct AccountModel: Identifiable {
    var id = UUID()
    var profilePicture: String = "default-picture.png"
    var username: String
    var email: String
    var password: String
    
}
