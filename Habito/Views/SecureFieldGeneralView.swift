//
//  SecureFieldGeneralView.swift
//  Habito
//
//  Created by admin on 2/6/25.
//

import SwiftUI

struct SecureFieldGeneralView: View {
    var heading : String = ""
    @State var textFieldText : String = ""
    
    var body: some View {
        VStack {
            Text(heading)
                .frame(width: SizeStandards.widthGeneral, alignment: .leading)
            
            SecureField("", text: $textFieldText)
                .frame(width: SizeStandards.widthGeneral, height: SizeStandards.textFieldHeight, alignment: .center)
                .overlay {
                    RoundedRectangle(cornerRadius: SizeStandards.cornerRadiusGeneral)
                        .stroke(style: StrokeStyle(lineWidth: SizeStandards.borderWidthGeneral))
                        .foregroundColor(Color.brandPrimary)
                }
        }
    }
}

#Preview {
    SecureFieldGeneralView()
}
