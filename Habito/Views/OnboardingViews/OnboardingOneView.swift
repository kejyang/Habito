//
//  OnboardingOneView.swift
//  Habito
//
//  Created by admin on 2/17/25.
//

import SwiftUI

struct OnboardingOneView: View {
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                NavigationLink(destination: OnboardingTwoView(), label: {
                    Text("Skip")
                        .frame(width: 70, height: 30)
                        .foregroundColor(Color.brandWhite)
                        .background(Color.brandBlack)
                        .cornerRadius(SizeStandards.cornerRadiusGeneral)
                })
            }
            .padding(30)
            
            Image("onboarding_1")
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
            
            HStack {
                
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 40, height: 10)
                        .foregroundColor(Color.brandPrimary)
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 20, height: 10)
                        .foregroundColor(Color.brandGray)
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 20, height: 10)
                        .foregroundColor(Color.brandGray)
                }
                
                Spacer()
                
                NavigationLink(destination: OnboardingTwoView(), label: {
                    Image(systemName: "arrow.forward.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(Color.brandBlack)
                })
                
            }
            .padding(30)
        }
        .toolbar(.hidden)
    }
}

#Preview {
    NavigationView {
        OnboardingOneView()
    }
}
