//
//  TodayProgressView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/11/25.
//

import SwiftUI

struct TodayProgressView: View {
    @State var todayProgress : CGFloat
    var body: some View {
        HStack{
            Text("Today's Progress!")
                .bold()
                .font(.title2)
            CircleGraphView(progress: $todayProgress, size: 80)
            Image(systemName: "")
        }
        .frame(maxWidth: .infinity)
        .background(Color.brandWhite)
        .cornerRadius(20)
    }
}

#Preview {
    TodayProgressView(todayProgress: 0.73)
}
