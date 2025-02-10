//
//  TimeOfDaySelectorView.swift
//  Habito
//
//  Created by admin on 2/10/25.
//


import SwiftUI

struct TimeOfDaySelectorView: View {
    @EnvironmentObject var timeOfDayViewModel: TimeOfDayViewModel
    var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        LazyVGrid(columns: columns) {
            ForEach(timeOfDayViewModel.items) { item in
                ToggleOptionButtonTextView(text: item.text)
            }
        }
        
    }
}