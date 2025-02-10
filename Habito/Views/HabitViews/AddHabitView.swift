//
//  AddGoalView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct AddHabitView: View {
    @State var habitTitle : String = ""
    @State var habitDetails : String = ""
    
    var body: some View {
        VStack {
            ZStack {
                Spacer()
                    .background(Color.brandBackboard)
                    .ignoresSafeArea()
                    .frame(maxHeight: .infinity, alignment: .top)
                
                VStack (alignment: .center){
                    TextField("Habit Title", text: $habitTitle)
                        .font(.title)
                        .offset(x: 4)

                    TextEditorWithPlaceholderView(placeholderText: "Add your habit details", text: habitDetails)
                }
                .cornerRadius(SizeStandards.cornerRadiusGeneral)
                .padding()
            }
            .frame(height: 200, alignment: .center)
            .padding(.bottom)
            
            Text("Choose an Activity")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            HStack(spacing: 30) {
                ToggleOptionButtonIconView(systemName: "person", isSelected: true)
                ToggleOptionButtonIconView(systemName: "drop")
                ToggleOptionButtonIconView(systemName: "bicycle")
                ToggleOptionButtonIconView(systemName: "shoe")
            }
            
            Text("Choose Time in a Day")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            VStack {
                HStack {
                    ToggleOptionButtonTextView(text: "Morning")
                    ToggleOptionButtonTextView(text: "Afternoon")
                }
            }
            .scrollContentBackground(.hidden)

            Spacer()
            
            Button("Create") {
                
            }
            .frame(width: SizeStandards.widthGeneral, height: SizeStandards.actionButtonHeight)
            .modifier(ActionButtonModifier())
            
        }
        .frame(maxHeight: .infinity)
        .modifier(NavigationTitleGeneralModifier(text: "Create New Habit"))
    }
}

#Preview {
    NavigationView {
        AddHabitView()
    }
}


struct ToggleOptionButtonTextView: View {
    var text: String = ""
    @State var isSelected: Bool = false
    
    var body: some View {
        Button(text) {
            isSelected = !isSelected
        }
        .frame(width: 160, height: 50)
        .font(.subheadline)
        .foregroundColor(isSelected ? Color.brandWhite : Color.brandBlack)
        .background(isSelected ? Color.brandPrimary : Color.brandBackboard)
        .cornerRadius(SizeStandards.cornerRadiusGeneral)
        .overlay {
            RoundedRectangle(cornerRadius: SizeStandards.cornerRadiusGeneral)
                .stroke(style: StrokeStyle(lineWidth: SizeStandards.borderWidthGeneral))
                .foregroundColor(Color.brandGray)
        }
    }
}


struct ToggleOptionButtonIconView: View {
    var systemName: String = ""
    @State var isSelected: Bool = false
    
    var body: some View {
        Button(action: {
            isSelected = !isSelected
        }, label: {
            Image(systemName: systemName)
                .font(.title)
                .frame(width: 70, height: 70)
                .foregroundColor(Color.brandWhite)
                .background(isSelected ? Color.brandPrimary : Color.brandGray)
                .cornerRadius(SizeStandards.cornerRadiusGeneral)
        })
    }
}

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
