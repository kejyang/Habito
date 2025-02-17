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
    @State var profileImageString : String = "default-picture.png"
    @State var username : String = ""
    @State var email : String = ""
    @State var isNormalLogin = true
    
    var body: some View {
        VStack {
            ProfileHeaderView(profileImage: profileImageString, username: username, email: email)
            
            List {
                /*NavigationLink(destination: ProfileEditView(), label: {
                    HStack {
                        Image(systemName: "person")
                        Text("Personal data")
                    }
                })
                .frame(height: SizeStandards.actionButtonHeight)*/
                
                NavigationLink(destination: ProfileHelpView(), label: {
                    HStack {
                        Image(systemName: "questionmark.circle")
                        Text("Help")
                    }
                })
                .frame(height: SizeStandards.actionButtonHeight)
                
                if isNormalLogin {
                    NavigationLink(destination: ProfileDeleteView(), label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete account")
                        }
                    })
                    .frame(height: SizeStandards.actionButtonHeight)
                }
                
                HStack {
                    Image(systemName: "power")
                    Button("Log out") {
                        accountViewModel.habitTab = 0
                        accountViewModel.isLoggedIn = false
                        accountViewModel.account = nil
                        if GIDSignIn.sharedInstance.currentUser != nil {
                            GIDSignIn.sharedInstance.signOut()
                            googleSignInHelper.isLoggedIn = false
                        }
                    }
                }
                .frame(height: SizeStandards.actionButtonHeight)
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
            //.frame(width: SizeStandards.widthGeneral)
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            //.cornerRadius(<#T##radius: CGFloat##CGFloat#>)
            .shadow(color: Color.black.opacity(0.2), radius: 5)            /*.overlay {
                RoundedRectangle(cornerSize: CGSize(width: 40, height: 40)).stroke(Color.brandGray, lineWidth: 1)
            }*/
        }
        .onAppear {
            if let account = accountViewModel.account {
                username = account.username
                email = account.email
                profileImageString = account.profilePicture
            }
            if googleSignInHelper.isLoggedIn {
                isNormalLogin = false
            }
        }
        .modifier(NavigationTitleGeneralModifier(text: "Your Profile"))
    }
}
