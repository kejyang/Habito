//
//  AnalyticsView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct AnalyticsView: View {
    var data = [5, 2, 4, 3, 5, 1, 5]
    var labels = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]
    var body: some View {
        
        VStack{
            TodayProgressView(todayProgress: 0.73)
                //.frame(width: SizeStandards.widthGeneral)
                .shadow(color: Color.black.opacity(0.4), radius: 1)
            BarGraphView(data: data, labels: labels)
                //.frame(width:SizeStandards.widthGeneral)
                .padding(.bottom, 3)
                .shadow(color: Color.black.opacity(0.4), radius: 1)
            HStack{
                SleepProgressView(sleepProgress: 8/8)
                    .frame(width: 225)
                    .shadow(color: Color.black.opacity(0.4), radius: 1)
                StepsView()
                    .shadow(color: Color.black.opacity(0.4), radius: 1)
                
            }
            .frame(height: 215)
            //.padding()
        }
        .frame(maxWidth: SizeStandards.widthGeneral)
        
    }
}

#Preview {
    AnalyticsView()
}
