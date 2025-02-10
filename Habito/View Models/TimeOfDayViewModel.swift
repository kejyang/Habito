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
            TimeOfDayModel(text: "Morning", isSelected: true),
            TimeOfDayModel(text: "Afternoon"),
            TimeOfDayModel(text: "Evening"),
            TimeOfDayModel(text: "Night"),
            TimeOfDayModel(text: "Anytime")
        ]
        items.append(contentsOf: newItems)
    }
    
}
