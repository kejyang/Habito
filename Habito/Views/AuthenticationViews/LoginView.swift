//
//  LoginView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct LoginView: View {
    @State var emailTextFieldText: String = ""
    @State var passwordTextFieldText: String = ""
    @State var isRememberMe: Bool = true
    
    var body: some View {
        VStack {
                    
            Text("Welcome Back!")
                .font(.headline)
                .padding()
            
            Text("Log in to continue building your healthy habits")
                .foregroundColor(Color.brandPrimary)
                .font(.subheadline.bold())
                .padding(.bottom)
            
            TextFieldGeneralView(heading: "E-mail", textFieldText: emailTextFieldText)
                .padding(.bottom)
            
            SecureFieldGeneralView(heading: "Password", textFieldText: passwordTextFieldText)

            HStack {
                Toggle("", isOn: $isRememberMe)
                    .toggleStyle(CheckboxToggleStyle())
                    .frame(maxWidth: 40, alignment: .leading)
                Text("Remember me?")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            
            NavigationLink(destination: TabBarView(), label: {
                Button("Login") {
                    
                }
                .frame(width: SizeStandards.widthGeneral, height: SizeStandards.actionButtonHeight, alignment: .center)
                .modifier(ActionButtonModifier())
            })
            
            HStack {
                Text("Don't have an account?")
                NavigationLink("Sign up here!", destination: SignUpView())
                    .foregroundColor(Color.brandPrimary)
            }
            .padding()

        }
    }
}

#Preview {
    NavigationView {
        LoginView()
    }
    .environmentObject(CalendarDayViewModel())
    .environmentObject(TimeOfDayViewModel())
}
