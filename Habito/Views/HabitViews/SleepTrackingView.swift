//
//  SleepTrackingView.swift
//  Habito
//
//  Created by admin on 2/13/25.
//

import SwiftUI

struct SleepTrackingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var habitDailyTaskViewModel: HabitDailyTaskViewModel
    var dailyTask : HabitDailyTaskModel
    var habit : HabitModel?
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
                if let h = habit {
                    if let id = dailyTask.id {
                        habitDailyTaskViewModel.updateDailyTaskById(completionValue: value, activityType: h.activityType, taskId: id)
                    }
                }
                presentationMode.wrappedValue.dismiss()
            }
            .frame(width: 160, height: SizeStandards.actionButtonHeight)
            .modifier(ActionButtonModifier())
            .padding()
            
        }
        .modifier(NavigationTitleGeneralModifier(text: "Sleep Details"))
    }
}

