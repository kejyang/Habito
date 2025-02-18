//
//  HabitTaskManagerTests.swift
//  HabitoTests
//
//  Created by admin on 2/18/25.
//

import XCTest
@testable import Habito

final class HabitTaskManagerTests: XCTestCase {
    
    var dbManager: DBManager!
    let accountId = 1
    
    override func setUp() {
        super.setUp()
        dbManager = DBManager()
        dbManager.createDatabase(inMemory: true) // Use in-memory database for testing
        dbManager.createAccountTable()
        dbManager.createHabitTable() // Create the necessary table for testing
        dbManager.createHabitDailyTaskTable()
        
        // Setup environment
        dbManager.insertAccount(username: "XCTest", email: "XCTest7547457@xyz.com" as NSString, password: "Abc123!")
        
        let title = "Test Habit"
        let habitDetails = "Test Details"
        let activityType = ActivityType.drinkingWater.rawValue
        let timeOfTheDay = TimeOfDay.Afternoon.rawValue
        let accountId = 1
        
        // When
        dbManager.insertHabit(title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: accountId)
    }
    
    override func tearDown() {
        dbManager = nil
        super.tearDown()
    }
    
    func testGetTimeOfDayString_Morning() {
        let time = HabitTaskManager.shared.getTimeOfDayFromString(time: TimeOfDay.Morning.rawValue)
        XCTAssertEqual(TimeOfDay.Morning, time)
    }
    
    func testGetTimeOfDayString_Evening() {
        let time = HabitTaskManager.shared.getTimeOfDayFromString(time: TimeOfDay.Evening.rawValue)
        XCTAssertEqual(TimeOfDay.Evening, time)
    }
    
    func testGetTimeOfDayString_Afternoon() {
        let time = HabitTaskManager.shared.getTimeOfDayFromString(time: TimeOfDay.Afternoon.rawValue)
        XCTAssertEqual(TimeOfDay.Afternoon, time)
    }
    
    func testGetTimeOfDayString_Night() {
        let time = HabitTaskManager.shared.getTimeOfDayFromString(time: TimeOfDay.Night.rawValue)
        XCTAssertEqual(TimeOfDay.Night, time)
    }
    
    func testGetTimeOfDayString_Anytime() {
        let time = HabitTaskManager.shared.getTimeOfDayFromString(time: TimeOfDay.Anytime.rawValue)
        XCTAssertEqual(TimeOfDay.Anytime, time)
    }
    
    func testGetTimeOfDayString_Morning_RandomString() {
        let time = HabitTaskManager.shared.getTimeOfDayFromString(time: "efsef")
        XCTAssertEqual(TimeOfDay.Morning, time)
    }
    
    func testGetTaskProgressDescription_ReturnsString_Sleep() {
        let stringVal = HabitTaskManager.shared.getTaskProgressDescription(progress: 0, activityType: ActivityType.sleep.rawValue)
        XCTAssertEqual("0/8 Hours", stringVal)
    }
    
    func testGetTaskProgressDescription_ReturnsString_Water() {
        let stringVal = HabitTaskManager.shared.getTaskProgressDescription(progress: 0, activityType: ActivityType.drinkingWater.rawValue)
        XCTAssertEqual("0/8 Glasses", stringVal)
    }
    
    func testGetTaskProgressDescription_ReturnsString_Biking() {
        let stringVal = HabitTaskManager.shared.getTaskProgressDescription(progress: 0, activityType: ActivityType.biking.rawValue)
        XCTAssertEqual("0/30 Minutes", stringVal)
    }
    
    
    func testGetTaskProgressDescription_ReturnsString_Running() {
        let stringVal = HabitTaskManager.shared.getTaskProgressDescription(progress: 0, activityType: ActivityType.running.rawValue)
        XCTAssertEqual("0K/10K Steps", stringVal)
    }
    
    func testGetTaskProgressDescription_ReturnsEmpty_RandomString() {
        let stringVal = HabitTaskManager.shared.getTaskProgressDescription(progress: 0, activityType: "seffse")
        XCTAssertEqual("", stringVal)
    }
    
    func testGetActivityTypeMaxValue_ReturnsInt_Sleep() {
        let val = HabitTaskManager.shared.getActivityTypeMaxValue(activityType: ActivityType.sleep.rawValue)
        XCTAssertEqual(8, val)
    }
    
    func testGetActivityTypeMaxValue_ReturnsInt_Water() {
        let val = HabitTaskManager.shared.getActivityTypeMaxValue(activityType: ActivityType.drinkingWater.rawValue)
        XCTAssertEqual(8, val)
    }
    
    func testGetActivityTypeMaxValue_ReturnsInt_Biking() {
        let val = HabitTaskManager.shared.getActivityTypeMaxValue(activityType: ActivityType.biking.rawValue)
        XCTAssertEqual(30, val)
    }
    
    func testGetActivityTypeMaxValue_ReturnsInt_Running() {
        let val = HabitTaskManager.shared.getActivityTypeMaxValue(activityType: ActivityType.running.rawValue)
        XCTAssertEqual(10, val)
    }
    
    func testGetActivityTypeMaxValue_ReturnsInt_RandomString() {
        let val = HabitTaskManager.shared.getActivityTypeMaxValue(activityType: "esfsefsef")
        XCTAssertNil(val)
    }
}
