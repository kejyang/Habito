//
//  ToggleOptionButtonTextView.swift
//  Habito
//
//  Created by admin on 2/10/25.
//


import SwiftUI

struct ToggleOptionButtonTextView: View {
    var text: String = ""
    @State var isSelected: Bool = false
    
    var body: some View {
        Button(text) {
            isSelected = !isSelected
        }
        .frame(width: 160, height: 50)
        .font(.subheadline)
        .foregroundColor(isSelected ? Color.brandWhite : Color.brandBlack)
        .background(isSelected ? Color.brandPrimary : Color.brandBackboard)
        .cornerRadius(SizeStandards.cornerRadiusGeneral)
        .overlay {
            RoundedRectangle(cornerRadius: SizeStandards.cornerRadiusGeneral)
                .stroke(style: StrokeStyle(lineWidth: SizeStandards.borderWidthGeneral))
                .foregroundColor(Color.brandGray)
        }
    }
}