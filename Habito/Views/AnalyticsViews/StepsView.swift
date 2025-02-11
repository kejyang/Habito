//
//  StepsView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/11/25.
//

import SwiftUI

struct StepsView: View {
    var steps = 5000
    var body: some View {
        VStack{
            Image(systemName: "figure.walk")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.brandPrimary)
                .frame(width: 30)
            Text("Steps")
                .font(.title)
                .bold()
            Text("\(steps)")
                .font(.title)
                .bold()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.brandWhite)
        .cornerRadius(20)
    }
}

#Preview {
    StepsView()
}
