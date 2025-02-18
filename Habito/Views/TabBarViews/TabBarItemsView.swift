//
//  TabBarItems.swift
//  Habito
//
//  Created by Kenneth Yang on 2/7/25.
//


import SwiftUI

struct TabBarItemsView: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack(alignment: .bottom) {
            Spacer().frame(width: 5)
            // First Tab Button
            TabBarItemView(iconName: "house.fill", iconNameNotSelected: "house", label: "Home", index: 0, selectedTab: $selectedTab)

            // Second Tab Button
            TabBarItemView(iconName: "book.fill", iconNameNotSelected: "book", label: "Recipes", index: 1, selectedTab: $selectedTab)

            Spacer().frame(width: 110)

            // Third Tab Button
            TabBarItemView(iconName: "clipboard.fill", iconNameNotSelected: "clipboard", label: "Data", index: 2, selectedTab: $selectedTab)

            Spacer()

            // Fourth Tab Button
            TabBarItemView(iconName: "person.fill", iconNameNotSelected: "person", label: "Profile", index: 3, selectedTab: $selectedTab)
        }
        .frame(height: 90)
    }
}
