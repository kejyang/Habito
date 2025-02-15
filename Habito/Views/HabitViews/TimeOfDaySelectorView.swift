//
//  TimeOfDaySelectorView.swift
//  Habito
//
//  Created by admin on 2/10/25.
//


import SwiftUI

struct TimeOfDaySelectorView: View {
    @Binding var selected: TimeOfDay
    var columns = [GridItem(.flexible(), alignment: .center), GridItem(.flexible(), alignment: .center)]
    
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(TimeOfDay.allCases, id: \.self) { item in
                Button(item.rawValue) {
                    selected = item
                }
                .frame(width: 160, height: 50)
                .font(.subheadline)
                .foregroundColor(selected == item ? Color.brandWhite : Color.brandBlack)
                .background(selected == item ? Color.brandPrimary : Color.brandBackboard)
                .cornerRadius(SizeStandards.cornerRadiusGeneral)
                .overlay {
                    RoundedRectangle(cornerRadius: SizeStandards.cornerRadiusGeneral)
                        .stroke(style: StrokeStyle(lineWidth: SizeStandards.borderWidthGeneral))
                        .foregroundColor(Color.brandGray)
                }
            }
        }
        .frame(width: SizeStandards.widthGeneral)
    }
}
