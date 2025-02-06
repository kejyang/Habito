//
//  AddHabitButtonView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct AddHabitButtonView: View {
    var body: some View {
        Button(action: {
            // Add habit functionality here
        }) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 60, height: 60) // Circle size
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            }
        }
        .offset(y: 360) // Move it above the tab bar
        .zIndex(1) // Make sure it stays above the tab bar
    }
}

#Preview {
    AddHabitButtonView()
}
