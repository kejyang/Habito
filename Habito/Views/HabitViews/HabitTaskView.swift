//
//  HabitView.swift
//  Habito
//
//  Created by admin on 2/10/25.
//

import SwiftUI

struct HabitTaskView: View {
    @EnvironmentObject var calendarDayViewModel : CalendarDayViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    @EnvironmentObject var habitDailyTaskViewModel: HabitDailyTaskViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State var dayIndex = 3
    @State var items = [HabitDailyTaskModel]()
    @Binding var tab: Int
    
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
        
            Button("View your habits") {
                accountViewModel.habitTab = 0
                tab = 0
            }
            .frame(width: SizeStandards.widthGeneral, height: SizeStandards.actionButtonHeight)
            .modifier(ActionButtonModifier())
            .padding(.top)
            
            List {
                
                ForEach(items) { habitTask in

                    HabitTaskRowView(habitDailyTask: habitTask, img: "sleepingWoman")
                        .disabled(dayIndex < 2 || dayIndex == 4)
                        .opacity(dayIndex < 2 || dayIndex == 4 ? 0.6 : 1)
                }
                
            }
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .zIndex(-1)
            .onChange(of: dayIndex) {
                if let id = accountViewModel.account?.id {
                    items = habitDailyTaskViewModel.getHabitDailyTasksByCalendarDay(calendarDay: calendarDayViewModel.items[dayIndex], accountId: Int(id))
                }
            }
            
            Spacer()
            
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
