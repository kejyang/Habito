//
//  RecipeRowView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/17/25.
//

import SwiftUI

struct RecipeRowView: View {
    var title: String
    var description: String
    var img: String
    
    var body: some View {
        ZStack {
            // Main content of the row
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title2)
                    .bold()
                // Image with max height and clipping
                Image(img)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 200) // Set max height
                    .clipped() // Clip content that exceeds the frame
                    .clipShape(RoundedRectangle(cornerRadius: SizeStandards.cornerRadiusGeneral))
            }
            .padding()
            .frame(maxWidth: SizeStandards.widthGeneral, alignment: .leading)
            .background(Color.brandWhite)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .shadow(color: Color.black.opacity(0.2), radius: 5)
            .padding(.horizontal)
            
            // Invisible NavigationLink on top
            NavigationLink(destination: RecipeContentView(title: title, description: description, img: img)) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle()) // Remove default button styling
            .opacity(0) // Hide the actual NavigationLink
        }
    }
}

#Preview {
    //RecipeRowView()
}
