//
//  DailyProgresManager.swift
//  Habito
//
//  Created by Kenneth Yang on 2/15/25.
//

import Foundation

class DailyProgressManager{
    
    let dbHelper = DBManager.dbhelper
    
    func getDailyProgress(accountId: Int) -> Double{
        var rawTotal = 0.0
        let today = Date()
        let weekday = String(Calendar.current.component(.weekday, from: today)) // Numeric weekday (1-7)
        let day = String(Calendar.current.component(.day, from: today)) // Numeric day (1-31)
        let month = String(Calendar.current.component(.month, from: today)) // Numeric month (1-12)
        let year = String(Calendar.current.component(.year, from: today)) // Numeric year (e.g., 2023)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let abbreviatedMonth = dateFormatter.string(from: today)

        let calendarDay = CalendarDayModel(
            weekday: weekday,
            day: day,
            month: abbreviatedMonth,
            year: year
        )
        let todaysTasks = HabitTaskManager.shared.getHabitDailyTasksOnCalendarDay(calendarDay: calendarDay, accountId: accountId)
        for task in todaysTasks{
            let activityType = getHabitType(habitId: task.habitId!)
            let maxValue = getActivityTypeMaxValue(activityType: activityType)!
            rawTotal += Double(task.completionValue) / Double(maxValue)
        }
        let progress = todaysTasks.count != 0 ? rawTotal/Double(todaysTasks.count) : 0
        return progress
    }
    
    func getWeeklyProgress(accountId: Int) -> [Double] {
        let today = Date()
        let calendar = Calendar.current
        
        // Get the start of the week (Sunday)
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            return Array(repeating: 0.0, count: 7)
        }
        
        // Initialize an array to store progress for each day of the week
        var weeklyProgress: [Double] = Array(repeating: 0.0, count: 7)
        
        // Loop through each day of the week (Sunday to Saturday)
        for dayOffset in 0..<7 {
            guard let currentDate = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek) else {
                continue
            }
            
            // Get the components for the current day
            let weekday = String(calendar.component(.weekday, from: currentDate)) // Numeric weekday (1-7)
            let day = String(calendar.component(.day, from: currentDate)) // Numeric day (1-31)
            let month = String(calendar.component(.month, from: currentDate)) // Numeric month (1-12)
            let year = String(calendar.component(.year, from: currentDate)) // Numeric year (e.g., 2023)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            let abbreviatedMonth = dateFormatter.string(from: currentDate)
            
            let calendarDay = CalendarDayModel(
                weekday: weekday,
                day: day,
                month: abbreviatedMonth,
                year: year
            )
            
            // Fetch tasks for the current day
            let dailyTasks = HabitTaskManager.shared.getHabitDailyTasksOnCalendarDay(calendarDay: calendarDay, accountId: accountId)
            
            // Calculate progress for the current day
            var rawTotal = 0.0
            for task in dailyTasks {
                let activityType = getHabitType(habitId: task.habitId!)
                let maxValue = getActivityTypeMaxValue(activityType: activityType)!
                rawTotal += Double(task.completionValue) / Double(maxValue)
            }
            
            let progress = dailyTasks.count != 0 ? rawTotal / Double(dailyTasks.count) : 0.0
            weeklyProgress[dayOffset] = progress
        }
        
        return weeklyProgress
    }
    
    func getStepsWeeklyProgress(accountId: Int) -> Int {
        let today = Date()
        let calendar = Calendar.current
        
        // Get the start of the week (Sunday)
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            return 0
        }
        var weeklySteps = 0
        
        // Loop through each day of the week (Sunday to Saturday)
        for dayOffset in 0..<7 {
            guard let currentDate = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek) else {
                continue
            }
            
            // Get the components for the current day
            let weekday = String(calendar.component(.weekday, from: currentDate)) // Numeric weekday (1-7)
            let day = String(calendar.component(.day, from: currentDate)) // Numeric day (1-31)
            let month = String(calendar.component(.month, from: currentDate)) // Numeric month (1-12)
            let year = String(calendar.component(.year, from: currentDate)) // Numeric year (e.g., 2023)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            let abbreviatedMonth = dateFormatter.string(from: currentDate)
            
            let calendarDay = CalendarDayModel(
                weekday: weekday,
                day: day,
                month: abbreviatedMonth,
                year: year
            )
            
            // Fetch tasks for the current day
            let dailyTasks = HabitTaskManager.shared.getHabitDailyTasksOnCalendarDay(calendarDay: calendarDay, accountId: accountId)
            
            // Calculate progress for the current day
            var rawTotal = 0
            for task in dailyTasks {
                let activityType = getHabitType(habitId: task.habitId!)
                if activityType == "Running" {
                    weeklySteps += task.completionValue
                }
                rawTotal += task.completionValue
            }
            
        }
        
        return weeklySteps
    }
    
    func getSleepWeeklyProgress(accountId: Int) -> Int {
        let today = Date()
        let calendar = Calendar.current
        
        // Get the start of the week (Sunday)
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            return 0
        }
        var weeklySleep = 0
        
        // Loop through each day of the week (Sunday to Saturday)
        for dayOffset in 0..<7 {
            guard let currentDate = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek) else {
                continue
            }
            
            // Get the components for the current day
            let weekday = String(calendar.component(.weekday, from: currentDate)) // Numeric weekday (1-7)
            let day = String(calendar.component(.day, from: currentDate)) // Numeric day (1-31)
            let month = String(calendar.component(.month, from: currentDate)) // Numeric month (1-12)
            let year = String(calendar.component(.year, from: currentDate)) // Numeric year (e.g., 2023)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            let abbreviatedMonth = dateFormatter.string(from: currentDate)
            
            let calendarDay = CalendarDayModel(
                weekday: weekday,
                day: day,
                month: abbreviatedMonth,
                year: year
            )
            
            // Fetch tasks for the current day
            let dailyTasks = HabitTaskManager.shared.getHabitDailyTasksOnCalendarDay(calendarDay: calendarDay, accountId: accountId)
            
            // Calculate progress for the current day
            var rawTotal = 0
            for task in dailyTasks {
                let activityType = getHabitType(habitId: task.habitId!)
                if activityType == "Sleep" {
                    weeklySleep += task.completionValue
                }
                rawTotal += task.completionValue
            }
            
        }
        
        return weeklySleep
    }
    
    func getWaterWeeklyProgress(accountId: Int) -> Int {
        let today = Date()
        let calendar = Calendar.current
        
        // Get the start of the week (Sunday)
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            return 0
        }
        var weeklyWater = 0
        
        // Loop through each day of the week (Sunday to Saturday)
        for dayOffset in 0..<7 {
            guard let currentDate = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek) else {
                continue
            }
            
            // Get the components for the current day
            let weekday = String(calendar.component(.weekday, from: currentDate)) // Numeric weekday (1-7)
            let day = String(calendar.component(.day, from: currentDate)) // Numeric day (1-31)
            let month = String(calendar.component(.month, from: currentDate)) // Numeric month (1-12)
            let year = String(calendar.component(.year, from: currentDate)) // Numeric year (e.g., 2023)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            let abbreviatedMonth = dateFormatter.string(from: currentDate)
            
            let calendarDay = CalendarDayModel(
                weekday: weekday,
                day: day,
                month: abbreviatedMonth,
                year: year
            )
            
            // Fetch tasks for the current day
            let dailyTasks = HabitTaskManager.shared.getHabitDailyTasksOnCalendarDay(calendarDay: calendarDay, accountId: accountId)
            
            // Calculate progress for the current day
            var rawTotal = 0
            for task in dailyTasks {
                let activityType = getHabitType(habitId: task.habitId!)
                if activityType == "Water" {
                    weeklyWater += task.completionValue
                }
                rawTotal += task.completionValue
            }
            
        }
        
        return weeklyWater
    }
    
    func getBikingWeeklyProgress(accountId: Int) -> Int {
        let today = Date()
        let calendar = Calendar.current
        
        // Get the start of the week (Sunday)
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            return 0
        }
        var weeklyBiking = 0
        
        // Loop through each day of the week (Sunday to Saturday)
        for dayOffset in 0..<7 {
            guard let currentDate = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek) else {
                continue
            }
            
            // Get the components for the current day
            let weekday = String(calendar.component(.weekday, from: currentDate)) // Numeric weekday (1-7)
            let day = String(calendar.component(.day, from: currentDate)) // Numeric day (1-31)
            let month = String(calendar.component(.month, from: currentDate)) // Numeric month (1-12)
            let year = String(calendar.component(.year, from: currentDate)) // Numeric year (e.g., 2023)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            let abbreviatedMonth = dateFormatter.string(from: currentDate)
            
            let calendarDay = CalendarDayModel(
                weekday: weekday,
                day: day,
                month: abbreviatedMonth,
                year: year
            )
            
            // Fetch tasks for the current day
            let dailyTasks = HabitTaskManager.shared.getHabitDailyTasksOnCalendarDay(calendarDay: calendarDay, accountId: accountId)
            
            // Calculate progress for the current day
            var rawTotal = 0
            for task in dailyTasks {
                let activityType = getHabitType(habitId: task.habitId!)
                if activityType == "Biking" {
                    weeklyBiking += task.completionValue
                }
                rawTotal += task.completionValue
            }
            
        }
        
        return weeklyBiking
    }
    
    func getHabitType(habitId: Int) -> String{
        let habit = dbHelper.fetchHabitById(id: habitId)
        return habit?.activityType ?? "nil"
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
