//
//  ActivityTypeSelectorView.swift
//  Habito
//
//  Created by admin on 2/10/25.
//


import SwiftUI

struct ActivityTypeSelectorView: View {
    @Binding var selectedActivityType: ActivityType
    let activityIcons: [ActivityType: String] = [
        .sleep: "moon",
        .drinkingWater: "drop",
        .biking: "bicycle",
        .running: "shoe"
    ]
    
    var body: some View {
        HStack(spacing: 30) {
            ForEach(ActivityType.allCases, id: \.self) { activity in
                Button(action: {
                    selectedActivityType = activity
                }, label: {
                    Image(systemName: activityIcons[activity] ?? "questionmark")
                        .font(.title)
                        .frame(width: 70, height: 70)
                        .foregroundColor(Color.brandWhite)
                        .background(selectedActivityType == activity ? Color.brandPrimary : Color.brandGray)
                        .cornerRadius(SizeStandards.cornerRadiusGeneral)
                })
            }
        }
    }
}
