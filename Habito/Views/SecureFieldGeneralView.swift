//
//  SecureFieldGeneralView.swift
//  Habito
//
//  Created by admin on 2/6/25.
//

import SwiftUI

struct SecureFieldGeneralView: View {
    var heading : String = ""
    @Binding var textFieldText : String
    @State var isRed = false
    
    var body: some View {
        VStack {
            Text(heading)
                .frame(width: SizeStandards.widthGeneral, alignment: .leading)
            
            SecureField("", text: $textFieldText)
                .frame(width: SizeStandards.widthGeneral, height: SizeStandards.textFieldHeight, alignment: .center)
                .overlay {
                    RoundedRectangle(cornerRadius: SizeStandards.cornerRadiusGeneral)
                        .stroke(style: StrokeStyle(lineWidth: SizeStandards.borderWidthGeneral))
                        .foregroundColor(isRed ? .red : Color.brandPrimary)
                }
        }
    }
}

#Preview {
    //SecureFieldGeneralView()
}
