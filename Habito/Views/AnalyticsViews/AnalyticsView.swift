//
//  AnalyticsView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct AnalyticsView: View {
    @EnvironmentObject var dailyProgressViewModel: DailyProgressViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel
    
    // Labels for the days of the week
    var labels = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]

    var body: some View {
        ScrollView {
            VStack {
                // Today's Progress View
                TodayProgressView(todayProgress: .constant(CGFloat(dailyProgressViewModel.dailyProgress ?? 0)))
                    .shadow(color: Color.black.opacity(0.4), radius: 1)
                
                // Bar Graph View
                if let weekProgress = dailyProgressViewModel.weekProgress {
                    BarGraphView(data: weekProgress, labels: labels)
                        .padding(.bottom, 3)
                        .shadow(color: Color.black.opacity(0.4), radius: 1)
                } else {
                    // Placeholder if weekProgress is nil
                    BarGraphView(data: [0, 0, 0, 0, 0, 0, 0], labels: labels)
                        .padding(.bottom, 3)
                        .shadow(color: Color.black.opacity(0.4), radius: 1)
                }
                
                // Sleep and Steps Views
                HStack {
                    SleepProgressView(sleepProgress: 8/8)
                        .frame(width: 225)
                        .shadow(color: Color.black.opacity(0.4), radius: 1)
                    StepsView()
                        .shadow(color: Color.black.opacity(0.4), radius: 1)
                }
                .frame(height: 215)
                
                // New Sleep View
                NewSleepView()
                
                // Add extra space at the bottom to allow scrolling further
                Spacer(minLength: 100) // Adjust this value to control how much further you can scroll
            }
            .frame(maxWidth: SizeStandards.widthGeneral)
            .onAppear {
                if let accountId = accountViewModel.account?.id {
                    // Fetch daily and weekly progress
                    dailyProgressViewModel.setDailyProgress(accountId: Int(accountId))
                    dailyProgressViewModel.setWeekProgress(accountId: Int(accountId))
                    dailyProgressViewModel.setStepsWeekProgress(accountId: Int(accountId))
                    dailyProgressViewModel.setSleepWeekProgress(accountId: Int(accountId))
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AnalyticsView()
        .environmentObject(DailyProgressViewModel())
        .environmentObject(AccountViewModel())
}
