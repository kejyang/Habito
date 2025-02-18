//
//  RecipeView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/17/25.
//

import SwiftUI

struct RecipeView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Your Guide to Wellness")
                .font(.title)
                .bold()
                .padding(.top, 20)

            // Add an extra hidden item at the end of the list
            List {
                ForEach(guides) { item in
                    GuideRowView(title: item.title, description: item.description, img: item.img)
                        .listRowInsets(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                        .listRowSeparator(.hidden)
                }

                // Add an invisible spacer at the bottom
                Color.clear
                    .frame(height: 100) // Adjust the height to match the obscuring shape
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
        }
        .modifier(NavigationTitleGeneralModifier(text: "Guides and Resources"))
    }
}

#Preview {
    RecipeView()
}
