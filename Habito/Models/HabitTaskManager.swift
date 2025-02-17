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
        let habits = DBManager.dbhelper.fetchHabitsByAccountId(id: accountId)
        for habit in habits {
            if let id = habit.id {
                generateHabitDailyTasksByHabitId(id: id)
            }
        }
    }
    
    func generateHabitDailyTasksByHabitId(id: Int) {
        let tasks = DBManager.dbhelper.fetchHabitDailyTaskByHabitId(id: id)
        guard let habit = DBManager.dbhelper.fetchHabitById(id: id) else {
            return
        }
        
        var habitCreationDate = Date()
        var dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: habitCreationDate)
        
        guard let d = habit.createdDay else {
            return
        }
        guard let m = habit.createdMonth else {
            return
        }
        guard let y = habit.createdYear else {
            return
        }
        dateComponents.day = d
        dateComponents.month = m
        dateComponents.year = y
        
        let threeDaysAgo = Date(timeInterval: -259200, since: .now)
        
        for i in 0..<5 {
            let date = Date(timeInterval: 86400*Double(i), since: threeDaysAgo)
            var components = Calendar.current.dateComponents([.day, .month, .year], from: date)
            
            // Only create tasks after or on the creation date
            guard let taskDay = components.day else {
                continue
            }
            guard let taskMonth = components.month else {
                continue
            }
            guard let taskYear = components.year else {
                continue
            }
            
            if taskYear == y {
                if taskMonth == m {
                    if taskDay < d {
                        continue
                    }
                } else if taskMonth < m{
                    continue
                }
            } else if taskYear < y {
                continue
            }
                
                
            
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
        let habits = DBManager.dbhelper.fetchHabitsByAccountId(id: accountId)
                
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
    
    func getTimeOfDayFromString(time: String) -> TimeOfDay {
        switch time {
        case TimeOfDay.Morning.rawValue:
            return TimeOfDay.Morning
        case TimeOfDay.Evening.rawValue:
            return TimeOfDay.Evening
        case TimeOfDay.Afternoon.rawValue:
            return TimeOfDay.Afternoon
        case TimeOfDay.Night.rawValue:
            return TimeOfDay.Night
        case TimeOfDay.Anytime.rawValue:
            return TimeOfDay.Anytime
        default:
            return TimeOfDay.Morning
        }
    }
    
    func getTaskProgressDescription(progress: Int, activityType: String) -> String {
        let maxVal = getActivityTypeMaxValue(activityType: activityType) ?? 0
        let description: String
        
        switch activityType {
        case ActivityType.sleep.rawValue:
            description = "\(progress)/\(maxVal) Hours"
        case ActivityType.drinkingWater.rawValue:
            description = "\(progress)/\(maxVal) Glasses"
        case ActivityType.biking.rawValue:
            description = "\(progress)/\(maxVal) Minutes"
        case ActivityType.running.rawValue:
            description = "\(progress)K/\(maxVal)K Steps"
        default:
            description = ""
        }
        
        return description
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
