//
//  ExerciseTrackingView.swift
//  Habito
//
//  Created by admin on 2/12/25.
//

import SwiftUI

struct ExerciseTrackingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var habitDailyTaskViewModel: HabitDailyTaskViewModel
    var dailyTask : HabitDailyTaskModel
    var habit : HabitModel?
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
            
            Spacer()
            
            Slider(value: $minutesValue, in: 0...30, step: 1) {
                
            }
            .frame(width: SizeStandards.widthGeneral)
            //.frame(height: 100)
            .tint(Color.brandPrimary)
            
            Spacer()
            
            Button("Done") {
                if let h = habit {
                    if let id = dailyTask.id {
                        habitDailyTaskViewModel.updateDailyTaskById(completionValue: Int(minutesValue), activityType: h.activityType, taskId: id)
                    }
                }
                presentationMode.wrappedValue.dismiss()
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
        //ExerciseTrackingView(minutesValue: 0)
    }
}
