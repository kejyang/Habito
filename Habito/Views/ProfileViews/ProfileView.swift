//
//  ProfileView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI
import GoogleSignIn

struct ProfileView: View {
    @EnvironmentObject var accountViewModel: AccountViewModel
    @EnvironmentObject var googleSignInHelper: GoogleSignInHelper
    var profileImageString : String = "sleepingWoman"
    var username : String = "test username"
    var email : String = "test email"
    
    var body: some View {
        VStack {
            ProfileHeaderView(profileImage: profileImageString, username: username, email: email)
            
            List {
                NavigationLink(destination: ProfileEditView(), label: {
                    Text("Personal data")
                })
                NavigationLink(destination: HomeView(), label: {
                    Text("Help")
                })
                NavigationLink(destination: HomeView(), label: {
                    Text("Delete account")
                })
                Button("Log out") {
                    accountViewModel.isLoggedIn = false
                    accountViewModel.account = nil
                    if GIDSignIn.sharedInstance.currentUser != nil {
                        GIDSignIn.sharedInstance.signOut()
                        googleSignInHelper.isLoggedIn = false
                    }
                    
                }
                .foregroundColor(.red)
                /*
                NavigationLink(destination: LoginView(), label: {
                    Text("Log out")
                        .foregroundColor(.red)
                })
                .onTapGesture {
                    accountViewModel.isLoggedIn = false
                    accountViewModel.account = nil
                }*/
                
            }
            .scrollContentBackground(.hidden)
            //.cornerRadius(<#T##radius: CGFloat##CGFloat#>)
            .shadow(color: Color.black.opacity(0.2), radius: 5)            /*.overlay {
                RoundedRectangle(cornerSize: CGSize(width: 40, height: 40)).stroke(Color.brandGray, lineWidth: 1)
            }*/
        }
        .modifier(NavigationTitleGeneralModifier(text: "Your Profile"))
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}


