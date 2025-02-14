//
//  GoalView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct HabitContentView: View {
    var value: Int
    var task: HabitDailyTaskModel
    var habit: HabitModel?
    var activityType: String = ""
    
    var body: some View {
        switch activityType {
        case ActivityType.sleep.rawValue:
            SleepTrackingView(dailyTask: task, habit: habit, value: value)
        case ActivityType.drinkingWater.rawValue:
            WaterTrackingView(dailyTask: task, habit: habit, value: value)
        case ActivityType.biking.rawValue:
            ExerciseTrackingView(dailyTask: task, habit: habit, minutesValue: Double(value))
        case ActivityType.running.rawValue:
            StepTrackingView(dailyTask: task, habit: habit, stepsValue: Double(value))
        default:
            Text("Failed to load")
        }
    }
}
