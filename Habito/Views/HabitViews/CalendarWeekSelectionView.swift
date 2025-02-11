//
//  CalendarWeekSelectionView.swift
//  Habito
//
//  Created by admin on 2/11/25.
//


import SwiftUI

struct CalendarWeekSelectionView: View {
    @Binding var selectedIndex: Int
    @EnvironmentObject var calendarDayViewModel : CalendarDayViewModel
    
    var body: some View {
        HStack {
            ForEach(0..<calendarDayViewModel.items.count, id: \.self) { index in
                
                Button(action: {
                    selectedIndex = index
                }, label: {
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