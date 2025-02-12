//
//  ExerciseTrackingView.swift
//  Habito
//
//  Created by admin on 2/12/25.
//

import SwiftUI

struct ExerciseTrackingView: View {
    @State var minutesValue: Double
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Almost there!")
                .font(.title)
            
            Text("Keep going, you're doing great!")
                .font(.subheadline)
            
            Spacer()
            
            ZStack {
                
                Image("sleepingWoman")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                
                Text("\(Int(minutesValue)) minute\(Int(minutesValue) == 1 ? "" : "s")")
                    .font(.title)
                
            }
            
            Slider(value: $minutesValue, in: 0...30, step: 1) {
                
            }
            .frame(height: 100)
            .tint(Color.brandPrimary)
            
            
            Button("Done") {
                
            }
            .frame(width: 160, height: SizeStandards.actionButtonHeight)
            .modifier(ActionButtonModifier())
            .padding()
            
        }
        .modifier(NavigationTitleGeneralModifier(text: "Exercise Details"))
    }
}

#Preview {
    NavigationView {
        ExerciseTrackingView(minutesValue: 0)
    }
}
