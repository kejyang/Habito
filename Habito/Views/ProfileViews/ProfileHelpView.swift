//
//  ProfileHelpView.swift
//  Habito
//
//  Created by admin on 2/16/25.
//

import SwiftUI

struct ProfileHelpView: View {
    var body: some View {
        VStack (alignment: .leading) {
            Text("Welcome to Habito")
                .font(.title)
                .bold()
            Text("Habito is a health and wellness mobile application designed to help user build healthy habits and achieve their wellness goals. With an intuitive interface and personalized tools, Habito makes it easier for indiviuals to track their daily habits, access healthy recipes, and stay motivated through a supportive community. The app aims to turn small, consistent actions into life-changing results.")
                .font(.body)
                .bold()
            Text("Many people struggle to build and maintain healthy habits due to busy schedules, inconsistent tracking, and lack of motivation. This makes it challenging to stay committed to their wellness goals. Habito solves this by offering an easy-to-use platform for habit tracking, practical resourcesm and a supportive community to help users stay on track.")
                .font(.body)
                .bold()
            Spacer()
        }
        .padding()
        .modifier(NavigationTitleGeneralModifier(text: "Help"))
    }
}
