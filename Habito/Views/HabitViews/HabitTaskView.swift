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
                
                if habitViewModel.accountHabits.isEmpty {
                    Text("Looks like you don't have any habits!\nAdd a new habit with the plus button")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                else{
                    ForEach(items) { habitTask in

                        HabitTaskRowView(habitDailyTask: habitTask)
                            .disabled(dayIndex < 2 || dayIndex == 4)
                            .opacity(dayIndex < 2 || dayIndex == 4 ? 0.6 : 1)
                            .padding()
                    }
                }
                Color.clear
                    .frame(height: 100) // Adjust the height to match the obscuring shape
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                
            }
            .listStyle(PlainListStyle())
            .listRowSeparator(.hidden)
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            //.zIndex(-1)
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
