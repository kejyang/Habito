//
//  AddHabitButtonView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct AddHabitButtonView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: AddHabitView()) {
                ZStack {
                    Circle()
                        .fill(Color.brandPrimary)
                        .frame(width: 70, height: 70) // Circle size
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                }
            }
        }
    }
    
}
#Preview {
    AddHabitButtonView()
}
