//
//  HabitDailyTaskModel.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import Foundation

struct HabitDailyTaskModel: Identifiable {
    let id : Int?
    var day: String
    var month: String
    var year: String
    var completionValue: Int
    var completed: Bool
    var habitId: Int?
}
