//
//  HabitView.swift
//  Habito
//
//  Created by admin on 2/15/25.
//

import SwiftUI

struct HabitView: View {
    @EnvironmentObject var habitViewModel: HabitViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State var items = [HabitDailyTaskModel]()
    @State var dayIndex: Int = 3
    @State var tab: Int = 0
    
    var body: some View {
        if tab == 0 {
            
            VStack {
                
                ZStack (alignment: .top) {
                    Spacer()
                        .frame(maxWidth: .infinity)
                        .frame(height: 100, alignment: .top)
                        .background(Color.brandBackboard)
                        .shadow(color: Color.black.opacity(0.2), radius: 5)
                    CalendarWeekSelectionView(selectedIndex: $dayIndex)
                        //.disabled(true)
                }
                //.background(Color.brandBackboard)
                
                Button("Start today's challenge") {
                    accountViewModel.habitTab = 1
                    tab = 1
                }
                .frame(width: SizeStandards.widthGeneral, height: SizeStandards.actionButtonHeight)
                .modifier(ActionButtonModifier())
                .padding(.top)
                //  ScrollView(.vertical, content: {
                
                List {
                    if habitViewModel.accountHabits.isEmpty {
                        Text("Looks like you don't have any habits!\nAdd a new habit with the plus button")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .font(.title3)
                            .foregroundColor(.gray)
                    } else {
                        ForEach(habitViewModel.accountHabits) { habit in
                            HabitRowView(habit: habit)
                                .padding()
                        }
                        .onDelete(perform: habitViewModel.deleteHabit)
                    }
                    
                    Color.clear
                        .frame(height: 100) // Adjust the height to match the obscuring shape
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .listRowSeparator(.hidden)
                .frame(alignment: .leading)
                .scrollContentBackground(.hidden)
                
                Spacer()
            }
            .modifier(NavigationTitleGeneralModifier(text: "Your Habits"))
            .onAppear {
                if let id = accountViewModel.account?.id {
                    habitViewModel.accountHabits = habitViewModel.getHabitsByAccountId(id: Int(id))
                }
                tab = accountViewModel.habitTab
                
            }
                /*.onTapGesture {
                    accountViewModel.habitTab = 1
                    tab = 1
                }*/
                //   })
                
        } else if tab == 1 {
            HabitTaskView(tab: $tab)
        }
        
    }
}
