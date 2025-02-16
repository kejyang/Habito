//
//  WaterProgressView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/16/25.
//

import SwiftUI

struct WaterProgressView: View {
    @EnvironmentObject var dailyProgressViewModel: DailyProgressViewModel
    var body: some View {
        VStack{
            Image(systemName: "figure.walk")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.brandPrimary)
                .frame(width: 30)
            Text("Steps")
                .font(.title)
                .bold()
            Text("\(dailyProgressViewModel.stepsWeekProgress ?? 0)")
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
    WaterProgressView()
}
