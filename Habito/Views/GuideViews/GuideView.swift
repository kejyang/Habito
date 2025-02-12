//
//  GuideView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct GuideView: View {
    //let items = Array(1...3)

    var body: some View {
            
        VStack(spacing: 0) { // Set the spacing to 0 to reduce the space
            Text("Your Guide to Wellness")
                .font(.title)
                .bold()
                .padding(.top, 20)

            List(guides) { item in
                GuideRowView(title: item.title, description: item.description, img: item.img)
                    .listRowInsets(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
        }
    }
    
}

#Preview {
    NavigationStack{
        GuideView()
    }
}
