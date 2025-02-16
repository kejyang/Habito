//
//  BikingProgressView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/16/25.
//

import SwiftUI

struct BikingProgressView: View {
    @EnvironmentObject var dailyProgressViewModel: DailyProgressViewModel
    var body: some View {
        VStack{
            Image(systemName: "bicycle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.brandPrimary)
                .frame(width: 80)
            Text("Minutes")
                .font(.title)
                .bold()
            Text("\(dailyProgressViewModel.bikingWeekProgress ?? 0)")
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
    BikingProgressView()
        .environmentObject(DailyProgressViewModel())
}
