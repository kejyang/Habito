//
//  DailyProgressTests.swift
//  HabitoTests
//
//  Created by Kenneth Yang on 2/18/25.
//

import XCTest
@testable import Habito

class DailyProgressViewModelTests: XCTestCase {
    var viewModel: DailyProgressViewModel!
    var progressManager: DailyProgressManager!

    override func setUp() {
        super.setUp()
        
        // Configure the shared DBManager instance for testing
        DBManager.dbhelper.createDatabase(inMemory: true)
        DBManager.dbhelper.createHabitTable()
        DBManager.dbhelper.appendCreationDateToHabitTable()

        // Initialize the view model
        viewModel = DailyProgressViewModel()
        progressManager = DailyProgressManager()
    }

    override func tearDown() {
        // Reset the shared DBManager instance (optional)
        DBManager.dbhelper = DBManager()
        super.tearDown()
    }

    func testInMemory() {
        // Add test data to the in-memory database
        let habits = DBManager.dbhelper.fetchHabits()
        XCTAssertEqual(habits.count, 0) // Adjust based on your logic
    }
    
    func testInMemory2() {
        // Add test data to the in-memory database
        let habits = progressManager.testGetAllHabits()
        XCTAssertEqual(habits.count, 0) // Adjust based on your logic
    }
    
    func testGetDailyProgress() {
        let progress = progressManager.getDailyProgress(accountId: 1)
        XCTAssertEqual(0, progress)
    }

}
