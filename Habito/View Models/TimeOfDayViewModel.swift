//
//  TimeOfDayViewModel.swift
//  Habito
//
//  Created by admin on 2/10/25.
//

import Foundation

class TimeOfDayViewModel: ObservableObject {
    @Published var items: [TimeOfDayModel] = []
    var selectedItemIndex : Int?
    
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems: [TimeOfDayModel] = [
            TimeOfDayModel(text: TimeOfDay.Morning.rawValue),
            TimeOfDayModel(text: TimeOfDay.Afternoon.rawValue),
            TimeOfDayModel(text: TimeOfDay.Evening.rawValue),
            TimeOfDayModel(text: TimeOfDay.Night.rawValue),
            TimeOfDayModel(text: TimeOfDay.Anytime.rawValue)
        ]
        items.append(contentsOf: newItems)
    }
    
}
