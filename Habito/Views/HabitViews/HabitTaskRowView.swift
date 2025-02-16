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
    var habitDailyTask: HabitDailyTaskModel
    @State var habitModel: HabitModel? = nil
    var img: String
    @State var backgroundColor = Color.brandBackgroundGradientGreen
    
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
                    Spacer()
                    
                    Text(title)
                        .font(.title2)
                        .bold()
                    
                    Text(description)
                        .font(.body)
                    
                    ProgressView(value: progress)
                        .progressViewStyle(CustomLinearProgressViewStyle())

                    Spacer()

                }
                .frame(maxWidth: .infinity, alignment: .center)
                

                Image(systemName: isCompleted ? "checkmark.circle" : "circle")
                            //.frame(alignment: .trailing)
                            .scaleEffect(2)
                            .foregroundColor(isCompleted ? Color.brandPrimary : Color.brandSecondary)
                            .padding()
                    
                
            }
            /*.padding()
            .frame(maxWidth: SizeStandards.widthGeneral, alignment: .leading)
            .background(Color.brandSecondary)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .shadow(color: Color.black.opacity(0.2), radius: 5)
            .padding(.horizontal)*/
    //    })
            .frame(width: SizeStandards.widthGeneral)
            .background(LinearGradient(gradient: Gradient(colors: [backgroundColor, Color.brandBackgroundGradientEnd]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .foregroundColor(Color.brandBlack)
            .onAppear {
                if let habitId = habitDailyTask.habitId {
                    if let habit = habitViewModel.getHabit(id: habitId) {
                        title = habit.title
                        if let maxVal = habitViewModel.getActivityTypeMaxValues(activityType: habit.activityType) {
                            progress = Double(habitDailyTask.completionValue) / Double(maxVal)
                        }
                        description = habitDailyTaskViewModel.getTaskProgressDescription(progress: habitDailyTask.completionValue, activityType: habit.activityType)
                        habitModel = habit
                        switch habit.activityType {
                        case ActivityType.sleep.rawValue:
                            backgroundColor = Color.brandBackgroundGradientGray
                        case ActivityType.drinkingWater.rawValue:
                            backgroundColor = Color.brandBackgroundGradientGreen
                        case ActivityType.biking.rawValue:
                            backgroundColor = Color.brandBackgroundGradientBlue
                        case ActivityType.running.rawValue:
                            backgroundColor = Color.brandBackgroundGradientYellow
                        default:
                            break
                        }
                    }
                }
                isCompleted = habitDailyTask.completed
            }
            .background(NavigationLink("", destination: HabitContentView(value: habitDailyTask.completionValue, task: habitDailyTask, habit: habitModel, activityType: habitModel?.activityType ?? "")).opacity(0))
            
        
    }
}
