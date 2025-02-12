//
//  WaterTrackingView.swift
//  Habito
//
//  Created by admin on 2/11/25.
//

import SwiftUI

struct WaterTrackingView: View {
    @State var value : Int
    
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
                
                Text("\(value)")
                    .font(.largeTitle.bold())
            }
            
                Stepper(value: $value, in: 0...8) {
                }
                .labelsHidden()
                .scaleEffect(1.4)
                .padding()
            
            Button("Done") {
                
            }
            .frame(width: 160, height: SizeStandards.actionButtonHeight)
            .modifier(ActionButtonModifier())
            .padding()
            
        }
        .modifier(NavigationTitleGeneralModifier(text: "Water Details"))
    }
}

#Preview {
    NavigationView {
        WaterTrackingView(value: 0)
    }
}
