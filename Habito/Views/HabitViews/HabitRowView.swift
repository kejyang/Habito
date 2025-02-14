//
//  HabitRowView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct HabitRowView: View {
    var dayString: String
    var title: String
    var description: String
    var img: String
    
    @State var isCompleted: Bool = false
    
    var body: some View {
        NavigationLink {
            //HabitContentView()
        } label: {
            HStack {
                Image(img)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .scaledToFit()
                
                VStack(alignment: .center, spacing: 8) {
                    Text(title)
                        .font(.title2)
                        .bold()
                    
                    Text(description)
                        .font(.body)
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                /*Image(systemName: "checkmark")
                    .frame(maxWidth: .infinity, alignment: .trailing)*/
                
            }
            /*.padding()
            .frame(maxWidth: SizeStandards.widthGeneral, alignment: .leading)
            .background(Color.brandSecondary)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .shadow(color: Color.black.opacity(0.2), radius: 5)
            .padding(.horizontal)*/
        }
        .foregroundColor(Color.brandBlack)
    }
}

#Preview {
    HabitRowView(
        dayString: "Day 1",
        title: "Sleeping is good",
        description: "Sleep 8 hours",
        img: "sleepingWoman"
    )
}
