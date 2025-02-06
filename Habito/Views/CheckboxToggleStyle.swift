//
//  CheckboxToggleStyle.swift
//  Habito
//
//  Created by admin on 2/6/25.
//


import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                //.cornerRadius(7)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}