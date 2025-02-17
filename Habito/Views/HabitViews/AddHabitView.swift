//
//  AddGoalView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var habitTitle: String = ""
    @State var habitDetails: String = ""
    @State var selectedActivityType: ActivityType = .sleep // Use the enum
    @State var selectedTimeOfDay: TimeOfDay = .Morning
    @EnvironmentObject var accountViewModel: AccountViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    @EnvironmentObject var habitDailyTaskViewModel: HabitDailyTaskViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Spacer()
                    .background(Color.brandBackboard)
                    .ignoresSafeArea()
                    .frame(maxHeight: .infinity, alignment: .top)
                
                VStack(alignment: .center) {
                    Spacer()
                    TextField("Habit Title", text: $habitTitle)
                        .font(.title)
                        .offset(x: 4)

                    TextEditorWithPlaceholderView(placeholderText: "Add your habit details", text: $habitDetails)
                }
                .cornerRadius(SizeStandards.cornerRadiusGeneral)
                .padding()
            }
            .frame(height: 200, alignment: .center)
            .shadow(color: Color.black.opacity(0.2), radius: 5)
            .padding(.bottom)
            
            Text("Choose an Activity")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ActivityTypeSelectorView(selectedActivityType: $selectedActivityType) // Pass the binding

            Text("Choose Time in a Day")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            TimeOfDaySelectorView(selected: $selectedTimeOfDay)
            
            Spacer()
            
            Button("Create") {
                if let accountId = accountViewModel.account?.id {
                    habitViewModel.attemptAddHabit(habitTitle: habitTitle, habitDetails: habitDetails, selectedActivityType: selectedActivityType, selectedTimeOfDay: selectedTimeOfDay, accountId: accountId)
                }
                presentationMode.wrappedValue.dismiss()
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
    .environmentObject(HabitViewModel())
    .environmentObject(HabitDailyTaskViewModel())
}
