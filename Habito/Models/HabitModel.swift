//
//  Habit.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import Foundation

struct HabitModel: Identifiable {
    let id : Int?
    var title: String
    var habitDetails: String
    var activityType: String
    var timeOfTheDay: String
    var accountId: Int? 
}
