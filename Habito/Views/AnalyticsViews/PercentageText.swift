//
//  PercentageText.swift
//  Habito
//
//  Created by admin on 2/17/25.
//


import SwiftUI

struct PercentageText: View {
    @Binding var progress: CGFloat
    let size: CGFloat
    var body: some View {
        Text("\(Int(progress * 100))%")
            .font(.system(size: size * 0.25, weight: .bold))
    }
}