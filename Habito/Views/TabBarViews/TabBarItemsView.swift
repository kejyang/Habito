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
            TabBarItemView(iconName: "book.fill", iconNameNotSelected: "book", label: "Guides", index: 1, selectedTab: $selectedTab)

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


enum TabItem: Int, CaseIterable {
    case home = 0
    case guides
    case data
    case profile

    var iconName: String {
        switch self {
        case .home: return "house.fill"
        case .guides: return "book.fill"
        case .data: return "clipboard.fill"
        case .profile: return "person.fill"
        }
    }

    var iconNameNotSelected: String {
        switch self {
        case .home: return "house"
        case .guides: return "book"
        case .data: return "clipboard"
        case .profile: return "person"
        }
    }

    var label: String {
        switch self {
        case .home: return "Home"
        case .guides: return "Guides"
        case .data: return "Data"
        case .profile: return "Profile"
        }
    }
}
