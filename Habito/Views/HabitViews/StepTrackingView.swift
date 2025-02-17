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
    @State var title = ""
    @State var headline = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text(title)
                .font(.title)
            
            Text(headline)
                .font(.subheadline)
            
            Spacer()
            
            ZStack {
                
                Image("sneaker")
                    .resizable()
                    .frame(width: 280, height: 280)
                    //.clipShape(Circle())
                
                HStack {
                    Text("\(Int(stepsValue))K")
                        .font(.title)
                        .bold()
                    Text("Steps")
                        .font(.body)
                        .opacity(0.7)
                }
            }
            
            Spacer()
            
            Slider(value: $stepsValue, in: 0...10, step: 1) {
                
            }
            .frame(width: SizeStandards.widthGeneral, height: 100)
            .tint(Color.brandPrimary)
            .onChange(of: stepsValue) {
                let text = habitDailyTaskViewModel.getHabitTaskEditorStrings(progress: Int(stepsValue), maxVal: 10)
                title = text.0
                headline = text.1
            }
            
            Spacer()
            
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
        .onAppear {
            let text = habitDailyTaskViewModel.getHabitTaskEditorStrings(progress: Int(stepsValue), maxVal: 10)
            title = text.0
            headline = text.1
        }
        .modifier(NavigationTitleGeneralModifier(text: "Steps Details"))
    }
}

#Preview {
    //StepTrackingView(stepsValue: 0)
}
