//
//  InnerFilledCircle.swift
//  Habito
//
//  Created by admin on 2/17/25.
//


import SwiftUI

struct InnerFilledCircle: View {
    let lineWidth: CGFloat = 20
    let size: CGFloat
    var body: some View {
        Circle()
            .fill(Color.brandWhite)
            .frame(
                width: size - lineWidth,
                height: size - lineWidth
            )
    }
}