//
//  ProfileEditView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct ProfileEditView: View {
    @State var usernameTextFieldText = ""
    @State var emailTextFieldText = ""
    @State var passwordTextFieldText = ""
    @State var confirmPasswordTextFieldText = ""
    
    var body: some View {
        VStack {
            ProfileHeaderView()
            TextFieldGeneralView(heading: "Username", textFieldText: $usernameTextFieldText)
            TextFieldGeneralView(heading: "E-mail", textFieldText: $emailTextFieldText)
            SecureFieldGeneralView(heading: "Password", textFieldText: $passwordTextFieldText)
            SecureFieldGeneralView(heading: "Confirm Password", textFieldText: $confirmPasswordTextFieldText)
            Spacer()
        }
        .modifier(NavigationTitleGeneralModifier(text: "Personal Data"))
    }
}

#Preview {
    NavigationView {
        ProfileEditView()
    }
}
