//
//  TextEditorWithPlaceholderView.swift
//  Habito
//
//  Created by admin on 2/10/25.
//


import SwiftUI

struct TextEditorWithPlaceholderView: View {
    var placeholderText: String = ""
    @State var text: String = ""
    
    var body: some View {
        ZStack {
            if text.isEmpty {
                TextEditor(text: .constant(placeholderText))
                    .disabled(true)
                    .scrollContentBackground(.hidden)
                    .opacity(0.25)

            }
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                //.opacity(text.isEmpty ? 0.25 : 1)
        }
    }
}