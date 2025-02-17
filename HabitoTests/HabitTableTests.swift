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
    func testInsertHabit() throws {
        let title = "Test Habit"
        let habitDetails = "Test Details"
        let activityType = "Test Activity"
        let timeOfTheDay = "Morning"
        let accountId = 1
        
        // When
        dbManager.insertHabit(title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: accountId)
        
        // Then
        let habits = dbManager.fetchHabits()
        XCTAssertEqual(habits.count, 1)
        XCTAssertEqual(habits[0].title, title)
        XCTAssertEqual(habits[0].habitDetails, habitDetails)
        XCTAssertEqual(habits[0].activityType, activityType)
        XCTAssertEqual(habits[0].timeOfTheDay, timeOfTheDay)
        XCTAssertEqual(habits[0].accountId, accountId)
    }
}
