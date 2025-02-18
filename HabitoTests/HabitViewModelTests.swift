//
//  HabitViewModelTests.swift
//  HabitoTests
//
//  Created by Kenneth Yang on 2/18/25.
//

import XCTest
@testable import Habito

final class HabitViewModelTests: XCTestCase {

    var habitViewModel: HabitViewModel!
    override func setUp(){
        super.setUp()
        habitViewModel = HabitViewModel(isUnitTesting: true)
        
    }

    override func tearDown(){
        habitViewModel = nil
        super.tearDown()
    }

    func testExample(){
        let habits = habitViewModel.getAllHabits()
        XCTAssertEqual(habits.count, 0)
    }
    


}
