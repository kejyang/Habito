//
//  RecipeContentView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/17/25.
//

import SwiftUI

struct RecipeContentView: View {
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
                    .padding()
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    //RecipeContentView()
}
