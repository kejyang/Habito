//
//  SleepProgressView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/11/25.
//

import SwiftUI

struct SleepProgressView: View {
    @State var sleepProgress : CGFloat
    
    var rawSleepNum: Int {
        return Int(round(sleepProgress * 8))
    }
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top){
                Text("Sleep")
                    .bold()
                    .font(.title)
                Spacer()
                CircleGraphView(progress: $sleepProgress, size: 90)
                
            }
            .padding(.top, 20)
            .padding(.horizontal, 10)
            Text("\(rawSleepNum)/8 Hours")
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .font(.title)
                .bold()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.brandWhite)
        .cornerRadius(20)
    }
}

#Preview {
    SleepProgressView(sleepProgress: 6/8)
}
