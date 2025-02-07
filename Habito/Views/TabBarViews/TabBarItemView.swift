//
//  TabBarItemView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//


import SwiftUI

struct TabBarItemView: View {
    let iconName: String
    let label: String
    let index: Int
    @Binding var selectedTab: Int

    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            VStack {
                Image(systemName: iconName)
                    .font(.system(size: 24))
                Text(label)
                    .font(.caption)
            }
            .padding()
            .foregroundColor(selectedTab == index ? .blue : .gray)
        }
    }
}
