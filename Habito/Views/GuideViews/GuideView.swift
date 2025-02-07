//
//  GuideView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        ZStack {
            // Green background (fills entire screen)
            Color.green
                .ignoresSafeArea() // Ignore safe area edges
            
            // Your content on top of the background
            Text("Guide View")
        }
    }
}

#Preview {
    GuideView()
}
