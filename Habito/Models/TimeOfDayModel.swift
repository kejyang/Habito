//
//  TimeOfDayModel.swift
//  Habito
//
//  Created by admin on 2/10/25.
//

import Foundation

struct TimeOfDayModel: Identifiable {
    var id = UUID()
    var text: String
    //var time: Date
    var isSelected: Bool = false
}
