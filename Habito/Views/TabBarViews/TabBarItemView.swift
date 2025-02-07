//
//  TabBarItemView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//


import SwiftUI

struct TabBarItemView: View {
    let iconName: String
    let iconNameNotSelected: String
    let label: String
    let index: Int
    @Binding var selectedTab: Int

    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            VStack {
                Image(systemName: selectedTab == index ? iconName : iconNameNotSelected)
                    .font(.system(size: 24))
                    .foregroundColor(.brandPrimary)
                Text(label)
                    .font(.caption)
                    .foregroundColor(.brandBlack)
            }
            .padding()
            .foregroundColor(selectedTab == index ? .blue : .gray)
        }
    }
}
