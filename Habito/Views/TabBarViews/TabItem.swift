//
//  TabItem.swift
//  Habito
//
//  Created by admin on 2/17/25.
//


import SwiftUI

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