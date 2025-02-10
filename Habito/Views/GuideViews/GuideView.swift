//
//  GuideView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct GuideView: View {
    let items = Array(1...3)

    var body: some View {
        ZStack {
            Color.brandWhite
                .ignoresSafeArea()
            
            VStack(spacing: 0) { // Set the spacing to 0 to reduce the space
                Text("Your Guide to Wellness")
                    .font(.title)
                    .bold()
                    .padding(.top, 20)

                List(items, id: \.self) { item in
                    GuideRowView(title: "Card \(item)", description: "test description", img: "sleepingWoman")
                        .listRowInsets(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.brandWhite)
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    GuideView()
}
