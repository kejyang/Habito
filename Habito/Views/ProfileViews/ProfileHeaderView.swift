//
//  ProfileHeaderView.swift
//  Habito
//
//  Created by admin on 2/11/25.
//


import SwiftUI

struct ProfileHeaderView: View {
    var profileImage : String = "sleepingWoman"
    var username : String = "test username"
    var email : String = "test email"
    
    var body: some View {
        VStack {
            Image(profileImage)
                .resizable()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            
            Text(username)
                .font(.headline)
            Text(email)
                .opacity(0.5)
        }
        .padding()
    }
}