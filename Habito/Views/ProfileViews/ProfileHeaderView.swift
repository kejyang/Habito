//
//  ProfileHeaderView.swift
//  Habito
//
//  Created by admin on 2/11/25.
//


import SwiftUI

struct ProfileHeaderView: View {
    @EnvironmentObject var accountViewModel: AccountViewModel
    @EnvironmentObject var googleSignInHelper: GoogleSignInHelper
    @State var googleLogin = false
    @State var profileImage : String = "default-picture.png"
    var username : String = "test username"
    var email : String = "test email"
    
    var body: some View {
        VStack {
            
            if profileImage != "default-picture.png" && profileImage != "N/A" {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            } else {
                Image(profileImage)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            }
            
            Text(username)
                .font(.headline)
            Text(email)
                .opacity(0.5)
        }
        .onAppear {
            if googleSignInHelper.isLoggedIn {
                googleLogin = true
                if let acc = accountViewModel.account {
                    profileImage = acc.profilePicture
                }
            }
        }
        .padding()
    }
}
