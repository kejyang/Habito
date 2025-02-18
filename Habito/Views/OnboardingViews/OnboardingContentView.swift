//
//  OnboardingContentView.swift
//  Habito
//
//  Created by admin on 2/17/25.
//

import SwiftUI

struct OnboardingContentView: View {
    @State var tab = 0
    
    var body: some View {
        switch tab {
        case 0:
            OnboardingOneView(tab: $tab)
        case 1:
            OnboardingTwoView(tab: $tab)
        case 2:
            OnboardingThreeView(tab: $tab)
        default:
            LoginView()
        }
    }
}
