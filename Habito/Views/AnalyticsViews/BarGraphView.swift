//
//  BarGraphView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/10/25.
//

import SwiftUI
import Charts

struct BarGraphView: View {
    let data: [Double]
    let labels: [String]

    var body: some View {
        VStack{
            HStack{
                Text("Days")
                    .bold()
                    .font(.title2)
                Spacer()
                Text("7 Days")
            }
            .padding()
            Chart {
                ForEach(0..<data.count, id: \.self) { index in
                    BarMark(
                        x: .value("Label", labels[index]),
                        y: .value("Value", data[index])
                    )
                    .foregroundStyle(Color.brandPrimary)
                    .annotation(position: .overlay) {
                        Text("\(Int(data[index]))")
                            .font(.caption)
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }
            .frame(height: 300)
            .padding()
            // Customize axes to remove lines
            .chartXAxis {
                AxisMarks(position: .bottom) { _ in
                    AxisValueLabel()
                        .foregroundStyle(Color.brandPrimary)
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { _ in
                    
                }
            }
        }
        .background(Color.brandWhite)
        .cornerRadius(SizeStandards.cornerRadiusGeneral)
    }
}

#Preview {
    BarGraphView(
        data: [10, 20, 30, 40, 50, 60, 70],
        labels: ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]
        
    )
}
