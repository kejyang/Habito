//
//  TextFieldViewGeneral.swift
//  Habito
//
//  Created by admin on 2/6/25.
//

import SwiftUI

struct TextFieldGeneralView: View {
    var heading : String = ""
    @Binding var textFieldText : String
    var isRed = false
    
    var body: some View {
        VStack {
            Text(heading)
                .frame(width: SizeStandards.widthGeneral, alignment: .leading)
            
            TextField("", text: $textFieldText)
                .frame(width: SizeStandards.widthGeneral-20, height: SizeStandards.textFieldHeight, alignment: .center)
                .overlay {
                    RoundedRectangle(cornerRadius: SizeStandards.cornerRadiusGeneral)
                        .stroke(style: StrokeStyle(lineWidth: SizeStandards.borderWidthGeneral))
                        .frame(width: SizeStandards.widthGeneral, height: SizeStandards.textFieldHeight)
                        .foregroundColor(isRed ? .red : Color.brandPrimary)
                }
        }
    }
}

#Preview {
    //TextFieldGeneralView()
}
