//
//  CustomTabBarView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//


import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: Int

    var body: some View {
        VStack {
            
            // Content for selected tab
            TabContentView(selectedTab: $selectedTab)
            
            Spacer()
            
            // Custom Tab Bar
            HStack {
                Spacer().frame(width: 5)
                // First Tab Button
                TabBarItemView(iconName: "house.fill", label: "Home", index: 0, selectedTab: $selectedTab)
                
                // Second Tab Button
                TabBarItemView(iconName: "book", label: "Guides", index: 1, selectedTab: $selectedTab)
                
                Spacer().frame(width: 80)
                
                // Third Tab Button
                TabBarItemView(iconName: "clipboard", label: "Data", index: 2, selectedTab: $selectedTab)
                
                Spacer()
                
                // Fourth Tab Button
                TabBarItemView(iconName: "person.fill", label: "Profile", index: 3, selectedTab: $selectedTab)
                
            }
            .frame(height: 90)
            .background(Color.white) // Background for the tab bar
            .cornerRadius(10) // Optional: adds rounded corners to the tab bar
            .padding(.horizontal, 16) // Optional: adds padding around the tab bar
            .background(
                Color.white // Background color for shadow effect
                    .cornerRadius(10)
                    .shadow(radius: 1) // Apply shadow only to the background
            )
        }
    }
}