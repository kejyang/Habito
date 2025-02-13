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
    @State var selectedActivityType : Int = 0
    
    var body: some View {
        VStack {
            ZStack {
                Spacer()
                    .background(Color.brandBackboard)
                    .ignoresSafeArea()
                    .frame(maxHeight: .infinity, alignment: .top)
                
                VStack (alignment: .center){
                    Spacer()
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
            
            ActivityTypeSelectorView(selectedActivityIndex: selectedActivityType)

            Text("Choose Time in a Day")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            TimeOfDaySelectorView()
            
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
    .environmentObject(TimeOfDayViewModel())
}
