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
    @State var phoneTextFieldText = ""
    @State var passwordTextFieldText = ""
    
    var body: some View {
        VStack {
            ProfileHeaderView()
            TextFieldGeneralView(heading: "Username", textFieldText: usernameTextFieldText)
            TextFieldGeneralView(heading: "E-mail", textFieldText: emailTextFieldText)
            TextFieldGeneralView(heading: "Phone Number", textFieldText: phoneTextFieldText)
            SecureFieldGeneralView(heading: "Password", textFieldText: passwordTextFieldText)
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
