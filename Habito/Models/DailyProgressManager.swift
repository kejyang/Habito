//
//  DailyProgresManager.swift
//  Habito
//
//  Created by Kenneth Yang on 2/15/25.
//

import Foundation

class DailyProgressManager {
    
    let dbHelper = DBManager.dbhelper
    private let daysInWeek = 7
    
    enum ActivityType: String {
        case sleep = "Sleep"
        case drinkingWater = "Water"
        case biking = "Biking"
        case running = "Running"
    }
    
    func testGetAllHabits() -> [HabitModel]{
        return dbHelper.fetchHabits()
    }
    
    func getDailyProgress(accountId: Int) -> Double {
        let today = Date()
        let calendarDay = createCalendarDay(from: today)
        let todaysTasks = HabitTaskManager.shared.getHabitDailyTasksOnCalendarDay(calendarDay: calendarDay, accountId: accountId)
        
        let progress = calculateProgress(for: todaysTasks)
        return progress
    }
    
    func getWeeklyProgress(accountId: Int) -> [Double] {
        let startOfWeek = getStartOfWeek()
        var weeklyProgress: [Double] = Array(repeating: 0.0, count: daysInWeek)
        
        for dayOffset in 0..<daysInWeek {
            guard let currentDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfWeek) else {
                continue
            }
            
            let calendarDay = createCalendarDay(from: currentDate)
            let dailyTasks = HabitTaskManager.shared.getHabitDailyTasksOnCalendarDay(calendarDay: calendarDay, accountId: accountId)
            
            let progress = calculateProgress(for: dailyTasks)
            weeklyProgress[dayOffset] = progress
        }
        
        return weeklyProgress
    }
    
    func getStepsWeeklyProgress(accountId: Int) -> Int {
        return getWeeklyActivityProgress(accountId: accountId, activityType: .running)
    }
    
    func getSleepWeeklyProgress(accountId: Int) -> Int {
        return getWeeklyActivityProgress(accountId: accountId, activityType: .sleep)
    }
    
    func getWaterWeeklyProgress(accountId: Int) -> Int {
        return getWeeklyActivityProgress(accountId: accountId, activityType: .drinkingWater)
    }
    
    func getBikingWeeklyProgress(accountId: Int) -> Int {
        return getWeeklyActivityProgress(accountId: accountId, activityType: .biking)
    }
    
    private func getWeeklyActivityProgress(accountId: Int, activityType: ActivityType) -> Int {
        let startOfWeek = getStartOfWeek()
        var weeklyTotal = 0
        
        for dayOffset in 0..<daysInWeek {
            guard let currentDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfWeek) else {
                continue
            }
            
            let calendarDay = createCalendarDay(from: currentDate)
            let dailyTasks = HabitTaskManager.shared.getHabitDailyTasksOnCalendarDay(calendarDay: calendarDay, accountId: accountId)
            
            for task in dailyTasks {
                if getHabitType(habitId: task.habitId!) == activityType.rawValue {
                    weeklyTotal += task.completionValue
                }
            }
        }
        
        return weeklyTotal
    }
    
    private func createCalendarDay(from date: Date) -> CalendarDayModel {
        let calendar = Calendar.current
        let weekday = String(calendar.component(.weekday, from: date))
        let day = String(calendar.component(.day, from: date))
        let month = String(calendar.component(.month, from: date))
        let year = String(calendar.component(.year, from: date))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let abbreviatedMonth = dateFormatter.string(from: date)
        
        return CalendarDayModel(
            weekday: weekday,
            day: day,
            month: abbreviatedMonth,
            year: year
        )
    }
    
    private func calculateProgress(for tasks: [HabitDailyTaskModel]) -> Double {
        var rawTotal = 0.0
        for task in tasks {
            let activityType = getHabitType(habitId: task.habitId!)
            if let maxValue = getActivityTypeMaxValue(activityType: activityType) {
                rawTotal += Double(task.completionValue) / Double(maxValue)
            }
        }
        return tasks.isEmpty ? 0 : rawTotal / Double(tasks.count)
    }
    
    private func getStartOfWeek() -> Date {
        let today = Date()
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) ?? today
    }
    
    private func getHabitType(habitId: Int) -> String {
        let habit = dbHelper.fetchHabitById(id: habitId)
        return habit?.activityType ?? "nil"
    }
    
    private func getActivityTypeMaxValue(activityType: String) -> Int? {
        guard let type = ActivityType(rawValue: activityType) else { return nil }
        
        switch type {
        case .sleep:
            return 8
        case .drinkingWater:
            return 8
        case .biking:
            return 30
        case .running:
            return 10
        }
    }
}
