//
//  WaterTrackingView.swift
//  Habito
//
//  Created by admin on 2/11/25.
//

import SwiftUI

struct WaterTrackingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var habitDailyTaskViewModel: HabitDailyTaskViewModel
    var dailyTask : HabitDailyTaskModel
    var habit: HabitModel?
    @State var value : Int
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
                Image("sleepingWoman")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                
                Text("\(value)")
                    .font(.largeTitle.bold())
            }
            
            Spacer()
            
            Stepper(value: $value, in: 0...8) {
            }
                .labelsHidden()
                .scaleEffect(1.4)
                .padding()
                .onChange(of: value) {
                    let text = habitDailyTaskViewModel.getHabitTaskEditorStrings(progress: value, maxVal: 8)
                    title = text.0
                    headline = text.1
                }
            
            Spacer()
            
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
        .onAppear {
            let text = habitDailyTaskViewModel.getHabitTaskEditorStrings(progress: value, maxVal: 8)
            title = text.0
            headline = text.1
        }
        .modifier(NavigationTitleGeneralModifier(text: "Water Details"))
    }
}

#Preview {
    NavigationView {
        //WaterTrackingView(value: 0)
    }
}
