//
//  OnboardingThreeView.swift
//  Habito
//
//  Created by admin on 2/17/25.
//

import SwiftUI

struct OnboardingThreeView: View {
    @Binding var tab: Int
    
    var body: some View {
        VStack {
            
            Image("habithelper")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: SizeStandards.widthGeneral)
                .padding()
            
            Spacer()
            
            HStack {
                Text("Welcome to ")
                + Text("HabitHelper")
                    .foregroundColor(Color.brandPrimary)
            }
            .font(.title)
            
            
            Text("Build healthy habits, track your progress, and stay motivated every day")
                .frame(width: SizeStandards.widthGeneral)
                .opacity(0.7)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            
            
            Image("onboarding_3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: SizeStandards.widthGeneral)
            
            
            Spacer()
            
            
            Button("Get Started") {
                tab += 1
            }
            .frame(width: SizeStandards.widthGeneral, height: SizeStandards.actionButtonHeight)
            .modifier(ActionButtonModifier())
            
        }
        .toolbar(.hidden)
    }
}
