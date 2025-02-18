//
//  OnboardingTwoView.swift
//  Habito
//
//  Created by admin on 2/17/25.
//

import SwiftUI

struct OnboardingTwoView: View {
    @Binding var tab: Int
    
    var body: some View {
        VStack {
            
            Image("onboarding_2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: SizeStandards.widthGeneral)
                .padding(30)
            Spacer()
            
            HStack {
                Text("Achieve")
                + Text(" your goals ")
                    .foregroundColor(Color.brandPrimary)
                + Text("easily!")
            }
            .font(.headline)
            .padding()
            
            Text("\"We give you simple tools to track your habits and analyze your health progress\"")
                .frame(width: SizeStandards.widthGeneral)
                .opacity(0.7)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            HStack {
                
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 20, height: 10)
                        .foregroundColor(Color.brandGray)
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 40, height: 10)
                        .foregroundColor(Color.brandPrimary)
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 20, height: 10)
                        .foregroundColor(Color.brandGray)
                }
                
                Spacer()
                
                    Image(systemName: "arrow.forward.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(Color.brandBlack)
                        .onTapGesture {
                            tab += 1
                        }
                
            }
            .padding(30)
        }
        .toolbar(.hidden)
    }
}
