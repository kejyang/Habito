//
//  NewSleepView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/16/25.
//

import SwiftUI

struct NewSleepView: View {
    @EnvironmentObject var dailyProgressViewModel: DailyProgressViewModel
    var body: some View {
        VStack{
            Image(systemName: "moon.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.brandPrimary)
                .frame(width: 30)
            Text("Hours Slept")
                .font(.title)
                .bold()
            Text("\(dailyProgressViewModel.sleepWeekProgress ?? 0)")
                .font(.title)
                .bold()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.brandWhite)
        .cornerRadius(20)
    }
}

#Preview {
    NewSleepView()
        .environmentObject(DailyProgressViewModel())
}
