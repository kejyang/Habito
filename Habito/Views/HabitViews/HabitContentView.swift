//
//  GoalView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct HabitContentView: View {
    var value: Int
    var habit: HabitModel?
    var activityType: String = ""
    
    var body: some View {
        switch activityType {
        case ActivityType.sleep.rawValue:
            SleepTrackingView(habit: habit, value: value)
        case ActivityType.drinkingWater.rawValue:
            WaterTrackingView(habit: habit, value: value)
        case ActivityType.biking.rawValue:
            ExerciseTrackingView(habit: habit, minutesValue: Double(value))
        case ActivityType.running.rawValue:
            StepTrackingView(habit: habit, stepsValue: Double(value))
        default:
            Text("Failed to load")
        }
    }
}
