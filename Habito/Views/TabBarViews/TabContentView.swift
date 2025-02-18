//
//  TabContentView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//


import SwiftUI

struct TabContentView: View {
    @Binding var selectedTab: Int

    var body: some View {
        
        switch selectedTab {
        case 0:
            HabitView()
        case 1:
            //GuideView()
            RecipeView()
        case 2:
            AnalyticsView()
        default:
            ProfileView()
        }
        
    }
}
