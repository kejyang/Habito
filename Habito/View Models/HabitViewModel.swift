//
//  GoalsViewModel.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var habit : HabitModel?
    @Published var accountHabits : [HabitModel] = []
    let dbHelper = DBManager.dbhelper
    
    init() {
        dbHelper.createDatabase()
        dbHelper.createHabitTable()
        dbHelper.appendCreationDateToHabitTable()
        print(dbHelper.fetchHabits())
    }
    
    func addHabit(title: String, habitDetails: String, activityType: String, timeOfTheDay: String, accountId: Int) {
        dbHelper.insertHabit(title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: accountId)
    }
    
    func getAllHabits() -> [HabitModel] {
        return dbHelper.fetchHabits()
    }
    
    func getHabitsByAccountId(id: Int) -> [HabitModel] {
        let habits = dbHelper.fetchHabitsByAccountId(id: id)
        return habits
    }
    

    
    func getHabit(id: Int) -> HabitModel? {
        if let habit = dbHelper.fetchHabitById(id: id) {
            return habit
        } else {
            print("Error: Habit with id \(id) not found.")
            return nil
        }
    }
    
    
    func deleteHabit(indexSet: IndexSet) {
        indexSet.sorted(by: > ).forEach{ (i) in
            if let id = accountHabits[i].id {
            let success = dbHelper.deleteHabitById(id: id)
                if success {
                    accountHabits.remove(atOffsets: indexSet)
                    if dbHelper.deleteHabitDailyTaskByHabitId(habitId: id) {
                        print("Habit deleted")
                    }
                }
            }
        }
    }
    
    func deleteHabit(id: Int) throws {
        let success = dbHelper.deleteHabitById(id: id)
        if !success {
            throw HabitError.deletionFailed
        }
        if !dbHelper.deleteHabitDailyTaskByHabitId(habitId: id) {
            throw HabitError.tasksDeletionFailed
        }
    }
    
    func getActivityTypeMaxValues(activityType: String) -> Int? {
        return HabitTaskManager.shared.getActivityTypeMaxValue(activityType: activityType)
    }
}

enum HabitError: Error {
    case deletionFailed
    case tasksDeletionFailed
}
