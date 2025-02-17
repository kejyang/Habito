//
//  ProfileDeleteView.swift
//  Habito
//
//  Created by admin on 2/16/25.
//

import SwiftUI

struct ProfileDeleteView: View {
    @EnvironmentObject var accountViewModel: AccountViewModel
    @EnvironmentObject var googleSignInHelper: GoogleSignInHelper
    @State var profileImageString : String = "default-picture.png"
    @State var username = ""
    @State var email = ""
    @State var passwordText = ""
    @State var isInvalidAttempt = false
    
    var body: some View {
        VStack {
            ProfileHeaderView(profileImage: profileImageString, username: username, email: email)
            
            
                Text("Enter your password and submit to delete your account")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                Text("Warning: This action cannot be undone")
                    .font(.headline)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            
            SecureFieldGeneralView(heading: "Password", textFieldText: $passwordText, isRed: isInvalidAttempt)
            
            if isInvalidAttempt {
                Text("Incorrect Password")
                    .frame(alignment: .center)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Button("Delete Account") {
                if let account = accountViewModel.account {
                    if passwordText == account.password {
                        accountViewModel.deleteAccount()
                        accountViewModel.habitTab = 0
                        accountViewModel.isLoggedIn = false
                        accountViewModel.account = nil
                    } else {
                        isInvalidAttempt = true
                    }
                }
            }
            .frame(width: SizeStandards.widthGeneral, height: SizeStandards.actionButtonHeight)
            .modifier(ActionButtonModifier())
            .padding()
        }
        .onAppear {
            if let account = accountViewModel.account {
                username = account.username
                email = account.email
                profileImageString = account.profilePicture
            }
        }
        .modifier(NavigationTitleGeneralModifier(text: "Delete Account"))
    }
}

#Preview {
    ProfileDeleteView()
}
