//
//  HabitDailyTaskViewModel.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import Foundation

class HabitDailyTaskViewModel: ObservableObject {
    @Published var habitDailyTask : HabitDailyTaskModel?
    @Published var accountDailytasks : [HabitDailyTaskModel] = []
    let dbHelper = DBManager.dbhelper
    
    init() {
        dbHelper.createDatabase()
        dbHelper.createHabitDailyTaskTable()
    }
    
    func addHabitDailyTask(day: String, month: String, year: String, completionValue: Int, completed: Bool, habitId: Int) {
        dbHelper.insertHabitDailyTask(day: day, month: month, year: year, completionValue: completionValue, completed: completed, habitId: habitId)
    }
    
    func getAllHabitDailyTasks() -> [HabitDailyTaskModel] {
        return dbHelper.fetchHabitDailyTasks()
    }
    
    func getHabitDailyTaskById(id: Int) -> HabitDailyTaskModel? {
        return dbHelper.fetchHabitDailyTaskById(id: id)
    }
    
    func getHabitDailyTasksByHabitId(habitId: Int) -> HabitDailyTaskModel? {
        return dbHelper.fetchHabitDailyTaskByHabitId(id: habitId)
    }
    
    
    func deleteHabitDailyTask(id: Int) throws {
        let success = dbHelper.deleteHabitDailyTaskById(id: id)
        if !success {
            throw HabitError.deletionFailed
        }
    }
}

