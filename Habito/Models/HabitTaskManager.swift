//
//  HabitTaskManager.swift
//  Habito
//
//  Created by admin on 2/13/25.
//

import Foundation

class HabitTaskManager {
    
    static var shared = HabitTaskManager()
    
    private init() {}
    
    
    func generateHabitDailyTasksForAccountId(accountId: Int) {
        var habits = DBManager.dbhelper.fetchHabitsByAccountId(id: accountId)
        for habit in habits {
            if let id = habit.id {
                generateHabitDailyTasksByHabitId(id: id)
            }
        }
    }
    
    func generateHabitDailyTasksByHabitId(id: Int) {
        let tasks = DBManager.dbhelper.fetchHabitDailyTaskByHabitId(id: id)
        
        let threeDaysAgo = Date(timeInterval: -259200, since: .now)
        
        for i in 0..<5 {
            let date = Date(timeInterval: 86400*Double(i), since: threeDaysAgo)
            
            let day = date.formatted(.dateTime.day())
            let month = date.formatted(.dateTime.month())
            let year = date.formatted(.dateTime.year())
            
            let filteredTasks = tasks.filter { (task: HabitDailyTaskModel) -> Bool in
                return task.day == day && task.month == month && task.year == year
            }
            
            if filteredTasks.isEmpty {
                DBManager.dbhelper.insertHabitDailyTask(day: day, month: month, year: year, completionValue: 0, completed: false, habitId: id)
            }
        }
    }
    
    func getHabitDailyTasksByAccountId(accountId: Int) -> [HabitDailyTaskModel] {
        var habits = DBManager.dbhelper.fetchHabitsByAccountId(id: accountId)
                
        var aggregatedTasks = [HabitDailyTaskModel]()
                
        for habit in habits {
            guard let id = habit.id else {
                continue
            }
            let tasks = DBManager.dbhelper.fetchHabitDailyTaskByHabitId(id: id)
            aggregatedTasks.append(contentsOf: tasks)
        }
        
        return aggregatedTasks
    }
    
    func getHabitDailyTasksOnCalendarDay(calendarDay: CalendarDayModel, accountId: Int) -> [HabitDailyTaskModel] {
        let aggregatedTasks = getHabitDailyTasksByAccountId(accountId: accountId)
        
        let filteredAggregatedTasks = aggregatedTasks.filter { (task: HabitDailyTaskModel) -> Bool in
            return calendarDay.day == task.day && calendarDay.month == task.month && calendarDay.year == task.year
        }
        
        return filteredAggregatedTasks
    }
    
    func updateDailyTaskById(completionValue: Int, activityType: String, taskId: Int) {
        var isCompleted = false
        if completionValue == getActivityTypeMaxValue(activityType: activityType) {
            isCompleted = true
        }
        
        DBManager.dbhelper.updateHabitDailyTaskById(completionValue: completionValue, completed: isCompleted, taskId: taskId)
    }
    
    
    func getActivityTypeMaxValue(activityType: String) -> Int? {
        switch activityType {
        case ActivityType.sleep.rawValue:
            return 8
        case ActivityType.drinkingWater.rawValue:
            return 8
        case ActivityType.biking.rawValue:
            return 30
        case ActivityType.running.rawValue:
            return 10
        default:
            return nil
        }
    }
}
