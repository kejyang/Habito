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
    @Published var todaysDailyTasks : [HabitDailyTaskModel] = []
    let dbHelper = DBManager.dbhelper
    
    init() {
        dbHelper.createDatabase()
        dbHelper.createHabitDailyTaskTable()
        print(dbHelper.fetchHabitDailyTasks())
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
    
    func getHabitDailyTasksByHabitId(habitId: Int) -> [HabitDailyTaskModel] {
        return dbHelper.fetchHabitDailyTaskByHabitId(id: habitId)
    }
    
    func getHabitDailyTasksByAccountId(accountId: Int) -> [HabitDailyTaskModel] {
        return HabitTaskManager.shared.getHabitDailyTasksByAccountId(accountId: accountId)
    }
    
    func deleteHabitDailyTask(id: Int) throws {
        let success = dbHelper.deleteHabitDailyTaskById(id: id)
        if !success {
            throw HabitError.deletionFailed
        }
    }
    
    func getHabitDailyTasksByCalendarDay(calendarDay: CalendarDayModel, accountId: Int) -> [HabitDailyTaskModel] {
        return HabitTaskManager.shared.getHabitDailyTasksOnCalendarDay(calendarDay: calendarDay, accountId: accountId)
    }
    
    func setHabitDailyTasksByCalendarDay(calendarDay: CalendarDayModel, accountId: Int) {
        todaysDailyTasks = HabitTaskManager.shared.getHabitDailyTasksOnCalendarDay(calendarDay: calendarDay, accountId: accountId)
    }
    
    func generateHabitDailyTasksByHabitId(habitId: Int) {
        return HabitTaskManager.shared.generateHabitDailyTasksByHabitId(id: habitId)
    }
    
    func generateHabitDailyTasksForAccountId(accountId: Int) {
        HabitTaskManager.shared.generateHabitDailyTasksForAccountId(accountId: accountId)
    }
    
    func updateDailyTaskById(completionValue: Int, activityType: String, taskId: Int) {
        HabitTaskManager.shared.updateDailyTaskById(completionValue: completionValue, activityType: activityType, taskId: taskId)
    }
    
}


