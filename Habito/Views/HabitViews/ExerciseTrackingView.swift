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
                
                Text("\(Int(minutesValue)) minute\(Int(minutesValue) == 1 ? "" : "s")")
                    .font(.title)
                
            }
            
            Spacer()
            
            Slider(value: $minutesValue, in: 0...30, step: 1) {
                
            }
            .frame(width: SizeStandards.widthGeneral)
            //.frame(height: 100)
            .tint(Color.brandPrimary)
            .onChange(of: minutesValue) {
                let text = habitDailyTaskViewModel.getHabitTaskEditorStrings(progress: Int(minutesValue), maxVal: 30)
                title = text.0
                headline = text.1
            }
            
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
        .onAppear {
            let text = habitDailyTaskViewModel.getHabitTaskEditorStrings(progress: Int(minutesValue), maxVal: 30)
            title = text.0
            headline = text.1
        }
        .modifier(NavigationTitleGeneralModifier(text: "Biking Details"))
    }
}

#Preview {
    NavigationView {
        //ExerciseTrackingView(minutesValue: 0)
    }
}
