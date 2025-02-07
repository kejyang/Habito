//
//  TabBarView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0 // Manage selected tab state internally

    var body: some View {
        NavigationView {
            ZStack {
                CustomTabBarView(selectedTab: $selectedTab)
                .edgesIgnoringSafeArea(.bottom) // To make the tab bar appear at the bottom
                
                // Floating Add Button (Plus Circle)
                AddHabitButtonView()
                    .offset(y: 335) // Move it above the tab bar
                    .zIndex(1) // Make sure it stays above the tab bar
            }
        }
    }
}



#Preview {
    TabBarView()
}
