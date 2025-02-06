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
                VStack {
                    // Content for selected tab
                    if selectedTab == 0 {
                        Text("Home View")
                            .font(.largeTitle)
                    }
                    else if selectedTab == 1 {
                        Text("Search View")
                            .font(.largeTitle)
                    }
                    else if selectedTab == 2 {
                        Text("Data View")
                            .font(.largeTitle)
                    }
                    else {
                        Text("Profile View")
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                    
                    // Custom Tab Bar
                    HStack {
                        Spacer().frame(width: 5)
                        // First Tab Button
                        Button(action: {
                            selectedTab = 0
                        }) {
                            VStack {
                                Image(systemName: "house.fill")
                                    .font(.system(size: 24))
                                Text("Home")
                                    .font(.caption)
                                    .layoutPriority(1)
                            }
                            .padding()
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        }
                        
                        
                        
                        // Second Tab Button
                        Button(action: {
                            selectedTab = 1
                        }) {
                            VStack {
                                Image(systemName: "book")
                                    .font(.system(size: 24))
                                Text("Guides")
                                    .font(.caption)
                            }
                            .padding()
                            .foregroundColor(selectedTab == 1 ? .blue : .gray)
                        }
                        
                        Spacer().frame(width: 80)
                        
                        // Third Tab Button
                        Button(action: {
                            selectedTab = 2
                        }) {
                            VStack {
                                Image(systemName: "clipboard")
                                    .font(.system(size: 24))
                                Text("data")
                                    .font(.caption)
                            }
                            .padding()
                            .foregroundColor(selectedTab == 2 ? .blue : .gray)
                        }
                        
                        Spacer()
                        
                        // Fourth Tab Button
                        Button(action: {
                            selectedTab = 3
                        }) {
                            VStack {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 24))
                                Text("Profile")
                                    .font(.caption)
                            }
                            .padding()
                            .foregroundColor(selectedTab == 3 ? .blue : .gray)
                        }
                        
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
