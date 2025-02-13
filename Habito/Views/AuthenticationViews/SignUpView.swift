//
//  SignUpView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State var usernameTextFieldText: String = ""
    @State var emailTextFieldText: String = ""
    @State var passwordTextFieldText: String = ""
    @State var confirmPasswordTextFieldText: String = ""
    @State var isAgreeTerms: Bool = false
    
    var body: some View {
        VStack {
            
            Text("Create Account")
                .font(.headline)
                .padding()
            
            Text("Let's create an account for you!")
                .foregroundColor(Color.brandPrimary)
                .font(.subheadline.bold())
                .padding(.bottom)
            
            TextFieldGeneralView(heading: "Username", textFieldText: $usernameTextFieldText)
                .padding(.bottom)
            
            TextFieldGeneralView(heading: "E-mail", textFieldText: $emailTextFieldText)
                .padding(.bottom)
            
            SecureFieldGeneralView(heading: "Password", textFieldText: $passwordTextFieldText)
                .padding(.bottom)
            
            SecureFieldGeneralView(heading: "Confirm Password", textFieldText: $confirmPasswordTextFieldText)
            
            
            HStack {
                Toggle("", isOn: $isAgreeTerms)
                    .toggleStyle(CheckboxToggleStyle())
                    .frame(maxWidth: 40, alignment: .leading)
                Text("I agree to the")
                    .frame(alignment: .leading)
                NavigationLink("terms and privacy policy", destination: ContentView())
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.brandPrimary)
            }
            .padding()
            
            
            //NavigationLink(destination: HomeView(), label: {
                Button("Sign Up") {
                    signup()
                }
                .frame(width: SizeStandards.widthGeneral, height: SizeStandards.actionButtonHeight, alignment: .center)
                .modifier(ActionButtonModifier())
            //})
            
        }
    }
    
    func signup() {
        accountViewModel.signupAccount(username: usernameTextFieldText, email: emailTextFieldText, password: passwordTextFieldText)
        presentationMode.wrappedValue.dismiss()
    }
    
}

#Preview {
    SignUpView()
}
