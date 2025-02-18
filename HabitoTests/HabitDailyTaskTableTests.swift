//
//  HabitDailyTaskTableTests.swift
//  HabitoTests
//
//  Created by Kenneth Yang on 2/18/25.
//

import XCTest
@testable import Habito


final class HabitDailyTaskTableTests: XCTestCase {

    var dbManager: DBManager!
    
    override func setUp() {
        super.setUp()
        dbManager = DBManager()
        dbManager.createDatabase(inMemory: true) // Use in-memory database for testing
        dbManager.createHabitDailyTaskTable() // Create the necessary table for testing
        dbManager.createHabitTable()
        insertSampleHabit()
    }
    
    override func tearDown() {
        dbManager = nil
        super.tearDown()
    }
    
    private func insertSampleHabit() {
        let title = "Test Habit"
        let habitDetails = "Test Details"
        let activityType = "Test Activity"
        let timeOfTheDay = "Morning"
        let accountId = 1
        
        dbManager.insertHabit(title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: accountId)
    }
    
    // Helper function to fetch the first habit ID
    private func fetchFirstHabitId() -> Int {
        let habits = dbManager.fetchHabits()
        return habits[0].id!
    }
    
    // Helper function to insert a daily task
    private func insertDailyTask(day: String, month: String, year: String, completionValue: Int, completed: Bool, habitId: Int) {
        dbManager.insertHabitDailyTask(day: day, month: month, year: year, completionValue: completionValue, completed: completed, habitId: habitId)
    }
    
    func testInsertAndFetchByHabitIdDailyTask() {
        let habitId = fetchFirstHabitId()
        insertDailyTask(day: "12", month: "Feb", year: "2025", completionValue: 0, completed: false, habitId: habitId)
        
        let dailyHabitTasks = dbManager.fetchHabitDailyTaskByHabitId(id: habitId)
        XCTAssertEqual("12", dailyHabitTasks[0].day)
        XCTAssertEqual("Feb", dailyHabitTasks[0].month)
        XCTAssertEqual(0, dailyHabitTasks[0].completionValue)
        XCTAssertEqual(false, dailyHabitTasks[0].completed)
    }
    
    func testUpdateDailyHabitTaskById() {
        let habitId = fetchFirstHabitId()
        insertDailyTask(day: "12", month: "Feb", year: "2025", completionValue: 0, completed: false, habitId: habitId)
        let dailyHabitTask = dbManager.fetchHabitDailyTaskByHabitId(id: habitId)
        
        dbManager.updateHabitDailyTaskById(completionValue: 2, completed: true, taskId: dailyHabitTask[0].id!)
        let updatedTask = dbManager.fetchHabitDailyTaskById(id: dailyHabitTask[0].id!)
        XCTAssertEqual(2, updatedTask?.completionValue)
    }
    
    func testDeleteHabitDailyTaskById() {
        let habitId = fetchFirstHabitId()
        insertDailyTask(day: "12", month: "Feb", year: "2025", completionValue: 0, completed: false, habitId: habitId)
        let dailyHabitTask = dbManager.fetchHabitDailyTaskByHabitId(id: habitId)
        let taskIdToDelete = dailyHabitTask[0].id!
        XCTAssertTrue(dbManager.deleteHabitDailyTaskById(id: taskIdToDelete))
    }
    
    func testDeleteHabitDailyTasksByHabitId() {
        let habitId = fetchFirstHabitId()
        insertDailyTask(day: "12", month: "Feb", year: "2025", completionValue: 0, completed: false, habitId: habitId)
        XCTAssertTrue(dbManager.deleteHabitDailyTaskByHabitId(habitId: habitId))
    }
}
