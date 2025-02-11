//
//  HabitView.swift
//  Habito
//
//  Created by admin on 2/10/25.
//

import SwiftUI

struct HabitView: View {
    @EnvironmentObject var calendarDayViewModel : CalendarDayViewModel
    @State var dayIndex = 3
    
    var body: some View {
        
        VStack {
            
            ZStack (alignment: .top) {
                
                Spacer()
                    .frame(width: .infinity, height: 100, alignment: .top)
                    .background(Color.brandBackboard)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                VStack {
                    CalendarWeekSelectionView(selectedIndex: $dayIndex)
                }
            }
        
            List {
                
                ZStack {
                    HabitTaskRowView(
                        title: "Drinking",
                        description: "4/8 Glasses",
                        img: "sleepingWoman"
                    )
                }
                
            }
            .scrollContentBackground(.hidden)
            .frame(width: .infinity, alignment: .leading)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .zIndex(-1)
            
        }
        .modifier(NavigationTitleGeneralModifier(text: calendarDayViewModel.getRelativeDayString(index: dayIndex)))
        
    }
}

#Preview {
    NavigationView {
        HabitView()
    }
    .environmentObject(CalendarDayViewModel())
}
