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
        VStack{
            Text("Your Guide to Wellness")
                .font(.title)
                .bold()
            List(items, id: \.self) { item in
                GuideRowView(title: "Card \(item)")
                    .listRowInsets(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)) //adjust spacing between cards
                    .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
        }
        
    }
}

#Preview {
    GuideView()
}
