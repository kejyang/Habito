//
//  TestViewModel.swift
//  Habito
//
//  Created by Kenneth Yang on 2/12/25.
//

import Foundation
import Combine

class TestViewModel: ObservableObject {
    @Published var testList = [TestModel]()
    
    private var dbHelper = DBManager.dbhelper
    
    init() {
        dbHelper.createDatabase()
        dbHelper.createTestTable()
        fetchData()
    }

    func fetchData() {
        self.testList = dbHelper.fetchData()
    }

    func addTest(title: String) {
        dbHelper.insertData(title: title)
        fetchData()  // Update the testList after inserting
    }
}

