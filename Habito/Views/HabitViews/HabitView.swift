//
//  HabitView.swift
//  Habito
//
//  Created by admin on 2/10/25.
//

import SwiftUI

struct HabitView: View {
    @EnvironmentObject var calendarDayViewModel : CalendarDayViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    @EnvironmentObject var habitDailyTaskViewModel: HabitDailyTaskViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State var dayIndex = 3
    @State var items = [HabitDailyTaskModel]()

    var body: some View {
        
        VStack {
            
            ZStack (alignment: .top) {
                
                Spacer()
                    .frame(maxWidth: .infinity)
                    .frame(height: 100, alignment: .top)
                    .background(Color.brandBackboard)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                VStack {
                    CalendarWeekSelectionView(selectedIndex: $dayIndex)
                }
            }
        
            List {
                
                ForEach(items) { habitTask in

                    HabitTaskRowView(habitdailyTask: habitTask, img: "sleepingWoman")
                    
                }
                /*ZStack {
                    HabitTaskRowView(
                        title: "Drinking",
                        description: "4/8 Glasses",
                        img: "sleepingWoman"
                    )
                }*/
                
            }
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .zIndex(-1)
            
        }
        .modifier(NavigationTitleGeneralModifier(text: calendarDayViewModel.getRelativeDayString(index: dayIndex)))
        .onAppear {
            if let id = accountViewModel.account?.id {
                habitDailyTaskViewModel.generateHabitDailyTasksForAccountId(accountId: Int(id))
                habitDailyTaskViewModel.accountDailytasks = habitDailyTaskViewModel.getHabitDailyTasksByAccountId(accountId: Int(id))
                items = habitDailyTaskViewModel.getHabitDailyTasksByCalendarDay(calendarDay: calendarDayViewModel.items[dayIndex], accountId: Int(id))
            }
            
        }
        
    }
}

#Preview {
    NavigationView {
        HabitView()
    }
    .environmentObject(CalendarDayViewModel())
}
