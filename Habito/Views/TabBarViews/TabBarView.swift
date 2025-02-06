//
//  TabBarView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            Text("Home View")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            Text("Guide View")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            Text("Add Habit View")
                .tabItem {
                    Label("Search", systemImage: "plus")
                }
                
            Text("Data Analysis View")
                .tabItem {
                    Label("Data Analysis", systemImage: "clipboard")
                }
            
            Text("Profile View")
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
        }
        .accentColor(.purple)
    }
}

#Preview {
    TabBarView()
}
