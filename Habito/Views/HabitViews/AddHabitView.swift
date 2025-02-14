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

            TimeOfDaySelectorView()
            
            Spacer()
            
            Button("Create") {
                addHabit()
                
            }
            .frame(width: SizeStandards.widthGeneral, height: SizeStandards.actionButtonHeight)
            .modifier(ActionButtonModifier())
        }
        .frame(maxHeight: .infinity)
        .modifier(NavigationTitleGeneralModifier(text: "Create New Habit"))
    }
    
    func addHabit() {
        if let accountId = accountViewModel.account?.id {
            habitViewModel.addHabit(
                title: habitTitle,
                habitDetails: habitDetails,
                activityType: selectedActivityType.rawValue,
                timeOfTheDay: "morning",
                accountId: Int(accountId)
            )
            habitViewModel.accountHabits = habitViewModel.getHabitsByAccountId(id: Int(accountId))
            if let newHabit = habitViewModel.accountHabits.last {
                
            }
            presentationMode.wrappedValue.dismiss()
        } else {
            print("Error: Account ID is nil.")
        }
    }
}

#Preview {
    NavigationView {
        AddHabitView()
    }
    .environmentObject(TimeOfDayViewModel())
}
