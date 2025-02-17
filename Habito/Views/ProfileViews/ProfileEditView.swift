//
//  ProfileEditView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject var accountViewModel: AccountViewModel
    @EnvironmentObject var googleSignInHelper: GoogleSignInHelper
    @State var profileImageString : String = "default-picture.png"
    @State var username = ""
    @State var email = ""
    @State var usernameTextFieldText = ""
    @State var emailTextFieldText = ""
    @State var passwordTextFieldText = ""
    @State var confirmPasswordTextFieldText = ""
    
    var body: some View {
        VStack {
            ProfileHeaderView(profileImage: profileImageString, username: username, email: email)
            TextFieldGeneralView(heading: "Username", textFieldText: $usernameTextFieldText)
                .disabled(true)
                .foregroundColor(.gray)
                .opacity(0.7)
            TextFieldGeneralView(heading: "E-mail", textFieldText: $emailTextFieldText)
                .foregroundColor(.gray)
                .opacity(0.7)
            //SecureFieldGeneralView(heading: "Password", textFieldText: $passwordTextFieldText)
            //SecureFieldGeneralView(heading: "Confirm Password", textFieldText: $confirmPasswordTextFieldText)
            Spacer()
        }
        .onAppear {
            if let account = accountViewModel.account {
                username = account.username
                email = account.email
                profileImageString = account.profilePicture
                usernameTextFieldText = account.username
                emailTextFieldText = account.email
                passwordTextFieldText = account.password
            }
        }
        .modifier(NavigationTitleGeneralModifier(text: "Personal Data"))
    }
}

#Preview {
    NavigationView {
        ProfileEditView()
    }
}
