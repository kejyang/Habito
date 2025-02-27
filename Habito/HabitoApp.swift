//
//  HabitoApp.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

@main
struct HabitoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                OnboardingContentView()
                //LoginView()
            }
            .environmentObject(CalendarDayViewModel())
            .environmentObject(TimeOfDayViewModel())
            .environmentObject(AccountViewModel())
            .environmentObject(HabitViewModel())
            .environmentObject(HabitDailyTaskViewModel())
            .environmentObject(DailyProgressViewModel())
            .environmentObject(GoogleSignInHelper())
            .environmentObject(AppleSignInHelper())
        }
    }
}
