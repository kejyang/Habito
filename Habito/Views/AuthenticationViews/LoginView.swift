//
//  LoginView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI
import GoogleSignIn

struct LoginView: View {
    @EnvironmentObject var accountViewModel: AccountViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    @StateObject private var googleSignInHelper = GoogleSignInHelper()
    
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
                
                if isError {
                    Text("Invalid E-mail/Password Combination")
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .padding(.bottom)
                }
                
                Button("Login") {
                    if login() {
                        accountViewModel.isLoggedIn = true
                    }
                }
                .frame(width: SizeStandards.widthGeneral, height: SizeStandards.actionButtonHeight, alignment: .center)
                .modifier(ActionButtonModifier())
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink("Sign up here!", destination: SignUpView())
                        .foregroundColor(Color.brandPrimary)
                }
                .padding()
                
                Button(action: {
                    googleSignInHelper.signIn()
                }) {
                    Text("Google Login")
                }
                .padding()
                
                if !googleSignInHelper.errorMessage.isEmpty {
                    Text(googleSignInHelper.errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .padding()
                }
            }
            .onAppear(perform: getRememberedData)
            .onChange(of: googleSignInHelper.isLoggedIn) { isLoggedIn in
                if isLoggedIn {
                    accountViewModel.isLoggedIn = true
                }
            }
        }
    }
    
    func getRememberedData() {
        let email = accountViewModel.getRememberedEmail()
        if !email.isEmpty {
            emailTextFieldText = email
            passwordTextFieldText = accountViewModel.getPasswordFromKeyChain(email: email)
            isRememberMe = true
        } else {
            isRememberMe = false
        }
    }
    
    func login() -> Bool {
        if accountViewModel.attemptLogin(email: emailTextFieldText, password: passwordTextFieldText) {
            accountViewModel.rememberEmail(email: emailTextFieldText, isRememberMe: isRememberMe)
            if let id = accountViewModel.account?.id {
                habitViewModel.accountHabits = habitViewModel.getHabitsByAccountId(id: Int(id))
            }
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
