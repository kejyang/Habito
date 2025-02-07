//
//  TestTabBarView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/6/25.
//

import SwiftUI

struct TestTabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            ZStack { // Use ZStack for layering
                // Centered TabContentView behind the tab bar
                TabContentView(selectedTab: $selectedTab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.clear) // Add background if needed
                
                // Tab bar overlay at the bottom
                VStack {
                    Spacer() // Push content to the bottom
                    ZStack {
                        TabBarShape()
                            .fill(Color.white)
                            .frame(height: 100)
                            .shadow(color: Color.black.opacity(0.4), radius: 2, x: 0, y: -1)
                            .overlay(
                                AddHabitButtonView()
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 70, height: 70)
                                    .background(Color.blue)
                                    .cornerRadius(60)
                                    .offset(x: 0, y: -45)
                            )
                        
                        TabBarItems(selectedTab: $selectedTab)
                    }
                }
            }
            .ignoresSafeArea() // Extend to edges
        }
    }
}

struct TabBarShape: Shape {
    private enum Constants {
        static let cornerRadius: CGFloat = 20
        static let buttonRadius: CGFloat = 45
        static let buttonPadding: CGFloat = 5
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()

        path.move(to: .init(x: 0, y: rect.height))
        path.addLine(to: .init(x: 0, y: rect.height - Constants.cornerRadius))
        path.addArc(withCenter: .init(x: 0, y: Constants.cornerRadius), radius: Constants.cornerRadius, startAngle: CGFloat.pi, endAngle: -CGFloat.pi/2, clockwise: true)

        let lineEnd = rect.width/2 - 2 * Constants.buttonPadding - Constants.buttonRadius
        path.addLine(to: .init(x: lineEnd, y: 0))
        path.addArc(withCenter: .init(x: lineEnd, y: Constants.buttonPadding), radius: Constants.buttonPadding, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)
        path.addArc(withCenter: .init(x: rect.width/2, y: Constants.buttonPadding), radius: Constants.buttonPadding + Constants.buttonRadius, startAngle: CGFloat.pi, endAngle: 0, clockwise: false)

        let lineStart = rect.width/2 + 2 * Constants.buttonPadding + Constants.buttonRadius
        path.addArc(withCenter: .init(x: lineStart, y: Constants.buttonPadding), radius: Constants.buttonPadding, startAngle: CGFloat.pi, endAngle: -CGFloat.pi/2, clockwise: true)

        path.addLine(to: .init(x: rect.width - Constants.cornerRadius, y: 0))
        path.addArc(withCenter: .init(x: rect.width, y: Constants.cornerRadius), radius: Constants.cornerRadius, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)
        path.addLine(to: .init(x: rect.width, y: rect.height))
        path.close()

        return Path(path.cgPath)
    }
}

struct TabBarItems: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            Spacer().frame(width: 5)
            // First Tab Button
            TabBarItemView(iconName: "house.fill", label: "Home", index: 0, selectedTab: $selectedTab)

            // Second Tab Button
            TabBarItemView(iconName: "book", label: "Guides", index: 1, selectedTab: $selectedTab)

            Spacer().frame(width: 110)

            // Third Tab Button
            TabBarItemView(iconName: "clipboard", label: "Data", index: 2, selectedTab: $selectedTab)

            Spacer()

            // Fourth Tab Button
            TabBarItemView(iconName: "person.fill", label: "Profile", index: 3, selectedTab: $selectedTab)
        }
        .frame(height: 90)
    }
}


#Preview {
    TestTabBarView()
}
