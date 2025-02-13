//
//  LoginView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State var emailTextFieldText: String = ""
    @State var passwordTextFieldText: String = ""
    @State var isRememberMe: Bool = true
    
    @State var isError = false
    
    var body: some View {
        if accountViewModel.isLoggedIn {
            TabBarView()
                .transition(.move(edge: .leading))
        } else {
            VStack {
                
                Text("Welcome Back!")
                    .font(.headline)
                    .padding()
                
                Text("Log in to continue building your healthy habits")
                    .foregroundColor(Color.brandPrimary)
                    .font(.subheadline.bold())
                    .padding(.bottom)
                
                TextFieldGeneralView(heading: "E-mail", textFieldText: $emailTextFieldText)
                    .padding(.bottom)
                
                SecureFieldGeneralView(heading: "Password", textFieldText: $passwordTextFieldText)
                
                HStack {
                    Toggle("", isOn: $isRememberMe)
                        .toggleStyle(CheckboxToggleStyle())
                        .frame(maxWidth: 40, alignment: .leading)
                    Text("Remember me?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                
                VStack {
                    if isError {
                        Text("Invalid E-mail/Password Combination")
                            .padding(.bottom)
                    }
                }
                
                .frame(width: SizeStandards.widthGeneral, alignment: .center)
                .foregroundColor(.red)
                .font(.subheadline)
                //NavigationLink(destination: TabBarView(), label: {
                Button("Login") {
                    if login() {
                        accountViewModel.isLoggedIn = true
                    }
                }
                .frame(width: SizeStandards.widthGeneral, height: SizeStandards.actionButtonHeight, alignment: .center)
                .modifier(ActionButtonModifier())
                //})
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink("Sign up here!", destination: SignUpView())
                        .foregroundColor(Color.brandPrimary)
                }
                .padding()
            }
        }
    }
    
    func login() -> Bool {
        if accountViewModel.attemptLogin(email: emailTextFieldText, password: passwordTextFieldText) {
            return true
        }
        isError = true
        return false
    }
}

#Preview {
    NavigationView {
        LoginView()
    }
    .environmentObject(CalendarDayViewModel())
    .environmentObject(TimeOfDayViewModel())
    .environmentObject(AccountViewModel())
}
