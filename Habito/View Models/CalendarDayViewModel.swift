//
//  CalendarDayViewModel.swift
//  Habito
//
//  Created by admin on 2/10/25.
//

import Foundation

class CalendarDayViewModel: ObservableObject {
    @Published var items: [CalendarDayModel] = []
    var selectedItemIndex : Int?
    
    init() {
        getItems()
    }
    
    func getItems() {
        var newItems: [CalendarDayModel] = []
        let today = Date()
        
        let calendarDay = CalendarDayModel(weekday: today.formatted(.dateTime.weekday()), day: today.formatted(.dateTime.day()), month: today.formatted(.dateTime.month()), year: today.formatted(.dateTime.year()))
        
        let tomorrow = today.addingTimeInterval(86400)
        let tomorrowCalendarDay = CalendarDayModel(weekday: tomorrow.formatted(.dateTime.weekday()), day: tomorrow.formatted(.dateTime.day()), month: tomorrow.formatted(.dateTime.month()), year: tomorrow.formatted(.dateTime.year()))
        
        newItems.append(tomorrowCalendarDay)
        newItems.append(calendarDay)
        
        for i in 1..<4 {
            let day = today.addingTimeInterval(-86400 * Double(i))
            let cDay = CalendarDayModel(weekday: day.formatted(.dateTime.weekday()), day: day.formatted(.dateTime.day()), month: day.formatted(.dateTime.month()), year: day.formatted(.dateTime.year()))
            newItems.append(cDay)
        }
        
        items.append(contentsOf: newItems.reversed())
    }
    
    func getRelativeDayString(index: Int) -> String {
        var dayString : String
        switch index {
        case 0:
            fallthrough
        case 1:
            dayString = "\(items[index].weekday) \(items[index].day)"
        case 2:
            dayString = "Yesterday"
        case 3:
            dayString = "Today"
        case 4:
            dayString = "Tomorrow"
        default:
            dayString = ""
        }
        return dayString
    }
    
}
