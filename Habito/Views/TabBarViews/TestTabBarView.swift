//
//  TestTabBarView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct TestTabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            ZStack { // Use ZStack for layering
                // Centered TabContentView behind the tab bar
                TabContentView(selectedTab: $selectedTab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.clear) // Add background if needed
                
                // Tab bar overlay at the bottom
                VStack {
                    Spacer() // Push content to the bottom
                    ZStack {
                        TabBarShape()
                            .fill(Color.white)
                            .frame(height: 100)
                            .shadow(color: Color.black.opacity(0.4), radius: 2, x: 0, y: -1)
                            .overlay(
                                AddHabitButtonView()
                                    .offset(x: 0, y: -45)
                            )
                        
                        TabBarItemsView(selectedTab: $selectedTab)
                    }
                }
            }
            .ignoresSafeArea() // Extend to edges
        }
    }
}






#Preview {
    TestTabBarView()
}
