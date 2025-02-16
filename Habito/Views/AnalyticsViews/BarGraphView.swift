//
//  BarGraphView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/10/25.
//

import SwiftUI
import Charts

struct BarGraphView: View {
    var data: [Double]
    let labels: [String]

    var body: some View {
        VStack {
            HStack {
                Text("This week in review")
                    .bold()
                    .font(.title2)
                Spacer()
            }
            .padding()
            
            Chart {
                ForEach(0..<data.count, id: \.self) { index in
                    BarMark(
                        x: .value("Label", labels[index]),
                        y: .value("Value", data[index]),
                        width: .ratio(0.9)
                    )
                    .foregroundStyle(Color.brandPrimary)
                    .cornerRadius(8)
                    .annotation(position: .overlay) {
                        Text("\(Int(data[index] * 100))%")
                            .font(.caption)
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }
            .padding(.horizontal, 5)
            .padding(.bottom, 5)
            .frame(height: 200)
            // Force y-axis to start at 0
            .chartYScale(domain: 0...1) // Adjust the upper bound (1) as needed
            // Customize axes
            .chartXAxis {
                AxisMarks(position: .bottom) { _ in
                    AxisValueLabel()
                        .foregroundStyle(Color.brandPrimary)
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { _ in }
            }
        }
        .background(Color.brandWhite)
        .cornerRadius(20)
    }
}

#Preview {
    /*BarGraphView(
        data: [5, 2, 4, 3, 5, 1, 5],
        labels: ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]
        
    )*/
}
