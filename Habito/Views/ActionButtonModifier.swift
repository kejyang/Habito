//
//  ActionButtonModifier.swift
//  Habito
//
//  Created by admin on 2/6/25.
//


import SwiftUI

struct ActionButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.brandWhite)
            .background(Color.brandPrimary)
            .font(.headline.bold())
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            //.padding()
    }
}
