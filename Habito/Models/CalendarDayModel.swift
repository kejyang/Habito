//
//  CalendarDayModel.swift
//  Habito
//
//  Created by admin on 2/11/25.
//

import Foundation

struct CalendarDayModel: Identifiable {
    var id = UUID()
    var weekday: String
    var day: String
    var month: String
    var year: String
}
