//
//  HabitTaskRowView.swift
//  Habito
//
//  Created by admin on 2/11/25.
//

import SwiftUI

struct HabitTaskRowView: View {
    //var dayString: String
    @EnvironmentObject var habitViewModel: HabitViewModel
    @EnvironmentObject var habitDailyTaskViewModel: HabitDailyTaskViewModel
    
    @State var title: String = ""
    @State var description: String = ""
    @State var progress = 0.0
    var habitdailyTask: HabitDailyTaskModel
    @State var habitModel: HabitModel? = nil
    var img: String
    
    @State var isCompleted: Bool = false
    
    var body: some View {
      /*  NavigationLink(destination: {
            HabitContentView()
        }, label: {*/
            HStack {
                Image(img)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFit()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.title2)
                        .bold()
                    
                    Text(description)
                        .font(.body)
                        .padding(.bottom)
                    
                    ProgressView(value: progress)
                        .progressViewStyle(.linear)
                        .tint(Color.brandPrimary)
                        //.foregroundColor(Color.brandPrimary)
                        .background(Color.brandWhite)
                        //.cornerRadius(SizeStandards.cornerRadiusGeneral)
                        .scaleEffect(x: 1, y: 4)

                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Image(systemName: "left.circle")
                    .frame(alignment: .trailing)
                    .foregroundColor(Color.brandPrimary)
                    .padding()
                
            }
            /*.padding()
            .frame(maxWidth: SizeStandards.widthGeneral, alignment: .leading)
            .background(Color.brandSecondary)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .shadow(color: Color.black.opacity(0.2), radius: 5)
            .padding(.horizontal)*/
    //    })
            .frame(width: SizeStandards.widthGeneral, height: 120)
            .background(Color.brandSecondary)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .foregroundColor(Color.brandBlack)
            .onAppear {
                if let habitId = habitdailyTask.habitId {
                    if let habit = habitViewModel.getHabit(id: habitId) {
                        title = habit.title
                        description = habit.habitDetails
                        if let maxVal = habitViewModel.getActivityTypeMaxValues(activityType: habit.activityType) {
                            progress = Double(habitdailyTask.completionValue) / Double(maxVal)
                        }
                        habitModel = habit
                    }
                }
            }
            .background(NavigationLink("", destination: HabitContentView(value: habitdailyTask.completionValue, task: habitdailyTask, habit: habitModel, activityType: habitModel?.activityType ?? "")).opacity(0))
            
        
    }
}
