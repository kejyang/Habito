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
            ZStack {
                TabContentView(selectedTab: $selectedTab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Ensure the tab bar sticks to the bottom
                VStack {
                    Spacer()
                    
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
                    .frame(maxWidth: .infinity) // Ensure full width
                }
                .frame(maxHeight: .infinity, alignment: .bottom) // Stick VStack to bottom
            }
            .ignoresSafeArea(.container, edges: .bottom) // Only ignore bottom safe area
        }
    }
}







#Preview {
    TestTabBarView()
}
