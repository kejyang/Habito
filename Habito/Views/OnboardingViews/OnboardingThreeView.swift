//
//  OnboardingThreeView.swift
//  Habito
//
//  Created by admin on 2/17/25.
//

import SwiftUI

struct OnboardingThreeView: View {
    var body: some View {
        VStack {
            
            Image("habithelper")
            
            Image("onboarding_3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: SizeStandards.widthGeneral)
            
            Spacer()
            
            HStack {
                Text("Start a")
                 //   .padding(0)
                 + Text(" healthy life ")
                    .foregroundColor(Color.brandPrimary)
                 //   .padding(0)
                + Text("today!")
                //    .padding(0)
            }
            .font(.headline)
            .padding()
            
            Text("Track your habits")
                .opacity(0.7)
                .padding()
            
            Spacer()
            
            Button("Get Started") {
                
            }
        }
        .toolbar(.hidden)
    }
}

#Preview {
    OnboardingThreeView()
}
