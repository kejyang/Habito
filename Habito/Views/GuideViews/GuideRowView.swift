//
//  GuideRowView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct GuideRowView: View {
    var title: String
    var description: String
    var img: String
    
    var body: some View {
        NavigationLink(destination: GuideContentView(title: title, description: description, img: img))
        {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title2)
                    .bold()
                
                Text(description)
                    .font(.body)
                    .lineLimit(2)
                    .truncationMode(.tail)
                
                Image(img)
                    .resizable()
                    .scaledToFit()
            }
            .padding()
            .frame(maxWidth: SizeStandards.widthGeneral, alignment: .leading)
            .background(Color.brandWhite)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .shadow(color: Color.black.opacity(0.2), radius: 5)
            .padding(.horizontal)
        }
    }
}

#Preview {
    GuideRowView(
        title: "Sleeping is good",
        description: "description",
        img: "sleepingWoman"
    )
}
