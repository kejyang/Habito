//
//  StepTrackingView.swift
//  Habito
//
//  Created by admin on 2/13/25.
//

import SwiftUI

struct StepTrackingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var habitDailyTaskViewModel: HabitDailyTaskViewModel
    var dailyTask : HabitDailyTaskModel
    var habit : HabitModel?
    @State var stepsValue: Double
    
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
                
                Text("\(Int(stepsValue)) steps")
                    .font(.title)
                
            }
            
            Slider(value: $stepsValue, in: 0...10, step: 1) {
                
            }
            .frame(height: 100)
            .tint(Color.brandPrimary)
            
            
            Button("Done") {
                if let h = habit {
                    if let id = dailyTask.id {
                        habitDailyTaskViewModel.updateDailyTaskById(completionValue: Int(stepsValue), activityType: h.activityType, taskId: id)
                    }
                }
                presentationMode.wrappedValue.dismiss()
            }
            .frame(width: 160, height: SizeStandards.actionButtonHeight)
            .modifier(ActionButtonModifier())
            .padding()
            
        }
        .modifier(NavigationTitleGeneralModifier(text: "Steps Details"))
    }
}

#Preview {
    //StepTrackingView(stepsValue: 0)
}
