//
//  HabitTableTests.swift
//  HabitoTests
//
//  Created by Kenneth Yang on 2/17/25.
//

import XCTest
@testable import Habito

final class HabitTableTests: XCTestCase {

    var dbManager: DBManager!
    
    override func setUp() {
        super.setUp()
        dbManager = DBManager()
        dbManager.createDatabase(inMemory: true) // Use in-memory database for testing
        dbManager.createHabitTable() // Create the necessary table for testing
    }
    
    override func tearDown() {
        dbManager = nil
        super.tearDown()
    }
    

    
    func testInsertHabit() {
        let title = "Test Habit"
        let habitDetails = "Test Details"
        let activityType = "Test Activity"
        let timeOfTheDay = "Morning"
        let accountId = 1
        
        dbManager.insertHabit(title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: accountId)
        
        let habits = dbManager.fetchHabits()
        XCTAssertEqual(habits.count, 1)
        XCTAssertEqual(habits[0].title, title)
        XCTAssertEqual(habits[0].habitDetails, habitDetails)
        XCTAssertEqual(habits[0].activityType, activityType)
        XCTAssertEqual(habits[0].timeOfTheDay, timeOfTheDay)
        XCTAssertEqual(habits[0].accountId, accountId)
    }
    
    func testFetchHabitById() {
        let title = "Test Habit"
        let habitDetails = "Test Details"
        let activityType = "Test Activity"
        let timeOfTheDay = "Morning"
        let accountId = 1
        
        dbManager.insertHabit(title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: accountId)
        
        let habits = dbManager.fetchHabits()
        let habit = dbManager.fetchHabitById(id: habits[0].id!)!
        XCTAssertEqual(habit.title, title)
        XCTAssertEqual(habit.habitDetails, habitDetails)
        XCTAssertEqual(habit.activityType, activityType)
        XCTAssertEqual(habit.timeOfTheDay, timeOfTheDay)
        XCTAssertEqual(habit.accountId, accountId)
    }
    
    func testFetchHabitsByAccountId() {
        let accountId1 = 1
        let accountId2 = 2
        
        dbManager.insertHabit(title: "Habit 1", habitDetails: "", activityType: "", timeOfTheDay: "", accountId: accountId1)
        dbManager.insertHabit(title: "Habit 1.2", habitDetails: "", activityType: "", timeOfTheDay: "", accountId: accountId1)
        dbManager.insertHabit(title: "Habit 2", habitDetails: "", activityType: "", timeOfTheDay: "", accountId: accountId2)
        let firstAccHabits = dbManager.fetchHabitsByAccountId(id: 1)
        let secondAccHabits = dbManager.fetchHabitsByAccountId(id: 2)
        
        XCTAssertEqual(firstAccHabits.count, 2)
        XCTAssertEqual(secondAccHabits.count, 1)
    }
    
    func testDeleteHabitById() throws {
        let title = "Test Habit"
        let habitDetails = "Test Details"
        let activityType = "Test Activity"
        let timeOfTheDay = "Morning"
        let accountId = 1
        
        dbManager.insertHabit(title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: accountId)
        
        let habits = dbManager.fetchHabitsByAccountId(id: 1)
        let habitId = try XCTUnwrap(habits[0].id, "Habit doesn't exist!")
        XCTAssertTrue(dbManager.deleteHabitById(id: habitId))
    }
    
    func testupdateHabitTitleDescriptionTimeById() {
        let title = "Test Habit"
        let habitDetails = "Test Details"
        let activityType = "Test Activity"
        let timeOfTheDay = "Morning"
        let accountId = 1
        
        dbManager.insertHabit(title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: accountId)
        
        let habits = dbManager.fetchHabits()
        
        dbManager.updateHabitTitleDescriptionTimeById(title: "New Habit", details: "New Details", timeOfDay: "New Time", habitId: habits[0].id!)
        
        XCTAssertEqual(dbManager.fetchHabits()[0].title, "New Habit")
        XCTAssertEqual(dbManager.fetchHabits()[0].habitDetails, "New Details")
        XCTAssertEqual(dbManager.fetchHabits()[0].timeOfTheDay, "New Time")
    }
    
}
