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
    //@State var dayString = calendarDayViewModel.getRelativeDayString(index: dayIndex)
    
    var body: some View {
        
        VStack {
            
            ZStack (alignment: .top) {
                
                Spacer()
                    .frame(width: .infinity, height: 100, alignment: .top)
                    .background(Color.brandBackboard)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                VStack {
                    CalendarWeekSelectionView(selectedIndex: $dayIndex)
                    //Spacer()
                }
            }
        
            List {
                //Text("fsef")
                HabitRowView(
                    dayString: "Day 1",
                    title: "Sleeping is good",
                    description: "Sleep 8 hours",
                    img: "sleepingWoman"
                )
                .frame(width: SizeStandards.widthGeneral)
                .background(Color.brandSecondary)
                .cornerRadius(SizeStandards.cornerRadiusGeneral)
                
                //.shadow(color: Color.black.opacity(0.2), radius: 5)
            }
            //.padding()
            .scrollContentBackground(.hidden)
            .frame(width: .infinity, alignment: .leading)
            //.background(Color.brandSecondary)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .zIndex(-1)
            //.shadow(color: Color.black.opacity(0.2), radius: 5)
            //.padding(.horizontal)
            
        }
        .modifier(NavigationTitleGeneralModifier(text: calendarDayViewModel.getRelativeDayString(index: dayIndex)))
        
    }
}

struct CalendarWeekSelectionView: View {
    @Binding var selectedIndex: Int
    @EnvironmentObject var calendarDayViewModel : CalendarDayViewModel
    @State var selectedDay : Date?
    
    var testText: [[String]] = [["Mon", "15"], ["Tue", "16"], ["Wed", "17"]]
    
    var body: some View {
        HStack {
            ForEach(0..<calendarDayViewModel.items.count, id: \.self) { index in
                
                Button(action: {
                    //selectedDay = day
                    selectedIndex = index
                }, label: {
                    //var components = Calendar.current.dateComponents([.weekday, .day], from: day)
                    VStack {
                        
                        Text(calendarDayViewModel.items[index].weekday)
                            .font(.subheadline)
                        Text(calendarDayViewModel.items[index].day)
                            .font(.headline)
                    }
                    .frame(width: 60, height: 60, alignment: .center)
                    .background(selectedIndex == index ? Color.brandPrimary : Color.clear)
                    .foregroundColor(selectedIndex == index ? Color.brandWhite : Color.brandBlack)
                    .cornerRadius(SizeStandards.cornerRadiusGeneral)
                })

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
