//
//  HabitRowView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct HabitRowView: View {
    var habit: HabitModel
    @State var img: String = "circle.fill"
    @State var imgColor = Color.brandBlack
    @State var backgroundColor = Color.brandBackgroundGradientGreen
    @State var isCompleted: Bool = false
    
    var body: some View {
        
            HStack {
                Image(systemName: img)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .scaledToFill()
                    //.foregroundColor(imgColor)
                    .padding()
                
                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    
                    Text(habit.title)
                        .font(.title2)
                        .bold()
                    HStack {
                        Text("\(habit.timeOfTheDay) - \(habit.activityType)")
                    }
                    .font(.headline)
                    
                    Text(habit.habitDetails)
                        .font(.body)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing)
            }
            .frame(width: SizeStandards.widthGeneral)
            .background(LinearGradient(gradient: Gradient(colors: [backgroundColor, Color.brandBackgroundGradientEnd]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(SizeStandards.cornerRadiusGeneral)
            .foregroundColor(Color.brandBlack)
            .onAppear {
                switch habit.activityType {
                case ActivityType.sleep.rawValue:
                    img = "moon.zzz.fill"
                    imgColor = Color.brandBlack
                    backgroundColor = Color.brandBackgroundGradientGray
                case ActivityType.drinkingWater.rawValue:
                    img = "waterbottle.fill"
                    imgColor = Color.teal
                    backgroundColor = Color.brandBackgroundGradientGreen
                case ActivityType.biking.rawValue:
                    img = "figure.outdoor.cycle"
                    imgColor = Color.brandPrimary
                    backgroundColor = Color.brandBackgroundGradientBlue
                case ActivityType.running.rawValue:
                    img = "figure.run"
                    imgColor = Color.blue
                    backgroundColor = Color.brandBackgroundGradientYellow
                default:
                    break
                }
            
        }
            .background(NavigationLink("", destination: HabitEditDescriptionView(habit: habit)).opacity(0))
        .foregroundColor(Color.brandBlack)
    }
}

#Preview {
    HabitRowView(
        habit: HabitModel(id: nil, title: "This is a Title", habitDetails: "This is the habit's details", activityType: ActivityType.sleep.rawValue, timeOfTheDay: TimeOfDay.Evening.rawValue)
    )
}
