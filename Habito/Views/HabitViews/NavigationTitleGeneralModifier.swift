//
//  NavigationTitleModifierGeneral.swift
//  Habito
//
//  Created by admin on 2/7/25.
//


import SwiftUI

struct NavigationTitleGeneralModifier: ViewModifier {
    var text: String = ""
    func body(content: Content) -> some View {
        content
            .navigationTitle(text)
            .navigationBarTitleDisplayMode(.inline)
    }
}
