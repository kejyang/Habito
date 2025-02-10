//
//  ActivityTypeSelectorView.swift
//  Habito
//
//  Created by admin on 2/10/25.
//


import SwiftUI

struct ActivityTypeSelectorView: View {
    @State var selectedActivityIndex = 0
    var icons : [String] = ["person", "drop", "bicycle", "shoe"]
    
    var body: some View {
        HStack(spacing: 30) {
            ForEach(0..<icons.count, id: \.self) { index in
                Button(action: {
                    selectedActivityIndex = index
                }, label: {
                    Image(systemName: icons[index])
                        .font(.title)
                        .frame(width: 70, height: 70)
                        .foregroundColor(Color.brandWhite)
                        .background(selectedActivityIndex == index ? Color.brandPrimary : Color.brandGray)
                        .cornerRadius(SizeStandards.cornerRadiusGeneral)
                })
            }
        }
    }
}