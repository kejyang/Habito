//
//  HabitEditDescriptionView.swift
//  Habito
//
//  Created by admin on 2/16/25.
//

import SwiftUI

struct HabitEditDescriptionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var habit: HabitModel
    @State var habitTitle: String = ""
    @State var habitDetails: String = ""
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
            .frame(alignment: .center)
            .shadow(color: Color.black.opacity(0.2), radius: 5)
            .padding(.bottom)

            Text("Choose Time in a Day")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            TimeOfDaySelectorView(selected: $selectedTimeOfDay)
            
            Spacer()
            
            Button("Update") {
                if let habitId = habit.id {
                    habitViewModel.updateHabitById(title: habitTitle, details: habitDetails, timeOfDay: selectedTimeOfDay.rawValue, habitId: habitId)
                }
                presentationMode.wrappedValue.dismiss()
            }
            .frame(width: SizeStandards.widthGeneral, height: SizeStandards.actionButtonHeight)
            .modifier(ActionButtonModifier())
            .padding()
        }
        .onAppear {
            habitTitle = habit.title
            habitDetails = habit.habitDetails
            selectedTimeOfDay = habitViewModel.getTimeOfDayFromString(time: habit.timeOfTheDay)
        }
        .frame(maxHeight: .infinity)
        .modifier(NavigationTitleGeneralModifier(text: "Create New Habit"))
    }
}
