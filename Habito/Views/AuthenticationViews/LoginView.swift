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
    @EnvironmentObject var dailyTaskViewModel: HabitDailyTaskViewModel
    @EnvironmentObject var googleSignInHelper: GoogleSignInHelper
    @EnvironmentObject var dailyProgressViewModel: DailyProgressViewModel
    
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
                        let today = Date()
                        let weekday = String(Calendar.current.component(.weekday, from: today)) // Numeric weekday (1-7)
                        let day = String(Calendar.current.component(.day, from: today)) // Numeric day (1-31)
                        let month = String(Calendar.current.component(.month, from: today)) // Numeric month (1-12)
                        let year = String(Calendar.current.component(.year, from: today)) // Numeric year (e.g., 2023)
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MMM"
                        let abbreviatedMonth = dateFormatter.string(from: today)

                        let calendarDay = CalendarDayModel(
                            weekday: weekday,
                            day: day,
                            month: abbreviatedMonth,
                            year: year
                        )

                        if let accountId = accountViewModel.account?.id {
                            dailyTaskViewModel.setHabitDailyTasksByCalendarDay(
                                calendarDay: calendarDay,
                                accountId: Int(accountId)
                            )
                            dailyProgressViewModel.setDailyProgress(accountId: Int(accountId))
                        } else {
                            print("Account ID is nil")
                        }
                        print(calendarDay)
                        print("Todays daily tasks  \(dailyTaskViewModel.todaysDailyTasks)")
                        
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
                    // Call the updated signIn method with a completion handler
                    googleSignInHelper.signIn { user, error in
                        if let error = error {
                            // Handle the error
                            print("Google Sign-In failed: \(error.localizedDescription)")
                            isError = true
                            return
                        }
                        if let user = user {
                            // Update the accountViewModel with Google user data
                            if let email = user.profile?.email, let name = user.profile?.name {
                                accountViewModel.handleGoogleSignIn(username: name, email: email)
                                accountViewModel.isLoggedIn = true
                            }
                        }
                    }
                }){
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
