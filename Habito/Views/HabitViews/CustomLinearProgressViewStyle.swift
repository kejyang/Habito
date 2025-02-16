//
//  CustomLinearProgressViewStyle.swift
//  Habito
//
//  Created by admin on 2/15/25.
//

import SwiftUI

struct CustomLinearProgressViewStyle: ProgressViewStyle {
    var width: CGFloat = 200
    var height: CGFloat = 15
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.brandWhite.opacity(0.5))
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.brandProgressBar)
            //.fill(LinearGradient(colors: [Color.brandPrimary, Color.brandProgressBar], startPoint: .leading, endPoint: .trailing))
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * width)
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    ProgressView(value: 0.6, total: 1)
        .progressViewStyle(CustomLinearProgressViewStyle())
}
