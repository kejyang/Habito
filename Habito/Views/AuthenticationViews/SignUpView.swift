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
    
    @State var isEmailEmpty = false
    @State var isEmailSpace = false
    @State var isEmailWrongFormat = false
    @State var isEmailUsed = false
    
    @State var isPasswordShort = false
    @State var isPasswordNoNumber = false
    @State var isPasswordNoCapital = false
    @State var isPasswordNoSpecial = false
    
    @State var isPasswordNoMatch = false
    
    @State var isSignupSuccess: Bool? = false
    
    var body: some View {
        if accountViewModel.isLoggedIn {
            TabBarView()
                .transition(.move(edge: .leading))
        } else {
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
                
                TextFieldGeneralView(heading: "E-mail", textFieldText: $emailTextFieldText, isRed: isEmailUsed || isEmailEmpty || isEmailSpace || isEmailWrongFormat)
                    .padding(.bottom)
                
                VStack (alignment: .leading) {
                    if isEmailUsed {
                        Text("An account already exists with this email")
                    }
                    if isEmailWrongFormat {
                        Text(verbatim: "Email must be in the format abc@xyz.com")
                    }
                    if isEmailSpace {
                        Text("Email cannot contain spaces")
                    }
                    if isEmailEmpty {
                        Text("Email cannot be empty")
                    }
                }
                .frame(width: SizeStandards.widthGeneral, alignment: .leading)
                .foregroundColor(.red)
                .font(.subheadline)
                
                
                SecureFieldGeneralView(heading: "Password", textFieldText: $passwordTextFieldText, isRed: isPasswordShort || isPasswordNoNumber || isPasswordNoCapital || isPasswordNoSpecial)
                    .padding(.bottom)
                
                VStack (alignment: .leading) {
                    if isPasswordShort {
                        Text("Password must be atleast 6 characters")
                    }
                    if isPasswordNoSpecial {
                        Text("Password must contain a special character")
                    }
                    if isPasswordNoNumber {
                        Text("Password must contain a number")
                    }
                    if isPasswordNoCapital {
                        Text("Password must contain a capital")
                    }
                }
                .frame(width: SizeStandards.widthGeneral, alignment: .leading)
                .foregroundColor(.red)
                .font(.subheadline)
                
                SecureFieldGeneralView(heading: "Confirm Password", textFieldText: $confirmPasswordTextFieldText, isRed: isPasswordNoMatch)
                
                VStack (alignment: .leading) {
                    if isPasswordNoMatch {
                        Text("Passwords do not match")
                    }
                }
                .frame(width: SizeStandards.widthGeneral, alignment: .leading)
                .foregroundColor(.red)
                .font(.subheadline)
                /*HStack {
                 Toggle("", isOn: $isAgreeTerms)
                 .toggleStyle(CheckboxToggleStyle())
                 .frame(maxWidth: 40, alignment: .leading)
                 Text("I agree to the")
                 .frame(alignment: .leading)
                 NavigationLink("terms and privacy policy", destination: ContentView())
                 .lineLimit(1)
                 .frame(maxWidth: .infinity, alignment: .leading)
                 .foregroundColor(Color.brandPrimary)
                 }*/
                .padding()
                
                
                //NavigationLink(destination: HabitView(), tag: true, selection: $isSignupSuccess, label: {
                Button("Sign Up") {
                    if signup() {
                        isEmailEmpty = false
                        isEmailSpace = false
                        isEmailWrongFormat = false
                        isEmailUsed = false
                        isPasswordShort = false
                        isPasswordNoNumber = false
                        isPasswordNoCapital = false
                        isPasswordNoSpecial = false
                        isPasswordNoMatch = false
                        accountViewModel.isLoggedIn = true
                    }
                }
                .frame(width: SizeStandards.widthGeneral, height: SizeStandards.actionButtonHeight, alignment: .center)
                .modifier(ActionButtonModifier())
                //})
                
            }
        }
    }
    
    func signup() -> Bool {
        //let responses = accountViewModel.signupAccount(username: usernameTextFieldText, email: emailTextFieldText, password: passwordTextFieldText)
        let responses = accountViewModel.attemptSignup(username: usernameTextFieldText, email: emailTextFieldText, password: passwordTextFieldText, confirmPassword: confirmPasswordTextFieldText)
        
        isEmailEmpty = responses[AccountViewModel.ValidationResponse.emailEmpty] ?? false
        isEmailSpace = responses[AccountViewModel.ValidationResponse.emailContainsSpace] ?? false
        isEmailWrongFormat = responses[AccountViewModel.ValidationResponse.invalidEmailFormat] ?? false
        isEmailUsed = responses[AccountViewModel.ValidationResponse.emailInUse] ?? false
        isPasswordShort = responses[AccountViewModel.ValidationResponse.passwordNotLong] ?? false
        isPasswordNoNumber = responses[AccountViewModel.ValidationResponse.passwordNoNumber] ?? false
        isPasswordNoCapital = responses[AccountViewModel.ValidationResponse.passwordNoCapital] ?? false
        isPasswordNoSpecial = responses[AccountViewModel.ValidationResponse.passwordNoSpecialCharacter] ?? false
        
        isPasswordNoMatch = responses[AccountViewModel.ValidationResponse.passwordNotMatching] ?? false
        
        return responses[AccountViewModel.ValidationResponse.valid] ?? false
        //presentationMode.
    }
    
}

#Preview {
    NavigationView {
        SignUpView()
    }
    .environmentObject(AccountViewModel())
}
