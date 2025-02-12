//
//  ViewGuideView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct GuideContentView: View {
    var title: String
    var description: String
    var img: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(img)
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.brandWhite)
                    
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.title)
                            .bold()
                        
                        Text(description)
                            .font(.body)
                            .bold()
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .ignoresSafeArea(edges: .bottom)
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    GuideContentView(
        title: "test title",
        description: "test description",
        img: "sleepingWoman"
    
    )
}
