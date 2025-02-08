//
//  GuideRowView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct GuideRowView: View {
    var title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .padding()
        }
        .frame(maxWidth: SizeStandards.widthGeneral)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)
    }
}

#Preview {
    GuideRowView(title: "test")
}
