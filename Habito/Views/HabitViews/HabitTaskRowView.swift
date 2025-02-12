//
//  HabitTaskRowView.swift
//  Habito
//
//  Created by admin on 2/11/25.
//

import SwiftUI

struct HabitTaskRowView: View {
    //var dayString: String
    var title: String
    var description: String
    var img: String
    
    @State var isCompleted: Bool = false
    
    var body: some View {
      /*  NavigationLink(destination: {
            HabitContentView()
        }, label: {*/
            HStack {
                Image(img)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFit()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.title2)
                        .bold()
                    
                    Text(description)
                        .font(.body)
                        .padding(.bottom)
                    
                    ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                        .progressViewStyle(.linear)
                        .tint(Color.brandPrimary)
                        //.foregroundColor(Color.brandPrimary)
                        .background(Color.brandWhite)
                        //.cornerRadius(SizeStandards.cornerRadiusGeneral)
                        .scaleEffect(x: 1, y: 4)

                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Image(systemName: "left.circle")
                    .frame(alignment: .trailing)
                    .foregroundColor(Color.brandPrimary)
                    .padding()
                
            }
            /*.padding()
            .frame(maxWidth: SizeStandards.widthGeneral, alignment: .leading)
            .background(Color.brandSecondary)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .shadow(color: Color.black.opacity(0.2), radius: 5)
            .padding(.horizontal)*/
    //    })
            .frame(width: SizeStandards.widthGeneral, height: 120)
            .background(Color.brandSecondary)
            .cornerRadius(SizeStandards.cornerRadiusGeneral)       .foregroundColor(Color.brandBlack)
            .background(NavigationLink("", destination: WaterTrackingView(value: 0)).opacity(0))
        
    }
}

#Preview {
    HabitTaskRowView(title: "Drinking", description: "3/8 Glasses", img: "sleepingWoman")
}
