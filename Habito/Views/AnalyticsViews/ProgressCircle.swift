//
//  ProgressCircle.swift
//  Habito
//
//  Created by admin on 2/17/25.
//


import SwiftUI

struct ProgressCircle: View {
    @Binding var progress: CGFloat
    let lineWidth: CGFloat

    var body: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(
                AngularGradient(
                    gradient: Gradient(stops: [
                        .init(color: .brandProgressBar, location: 0.0),
                        .init(color: .brandPrimary, location: 0.25),
                        .init(color: .brandPrimary, location: 0.75),
                        .init(color: .brandProgressBar, location: 1.0)
                    ]),
                    center: .center,
                    startAngle: .degrees(0),
                    endAngle: .degrees(360)
                ),
                style: StrokeStyle(lineWidth: lineWidth)
            )
            .rotationEffect(.degrees(-90))
            .animation(.easeOut, value: progress)
    }
}