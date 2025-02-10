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
                        y: .value("Value", data[index]),
                        width: .ratio(0.8)
                    )
                    .foregroundStyle(Color.brandPrimary)
                    .cornerRadius(8)
                    .annotation(position: .overlay) {
                        Text("\(Int(data[index]))hr")
                            .font(.caption)
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                }
            }
            .frame(height: 200)
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
            .chartXScale(
                
            )
        }
        .background(Color.brandWhite)
        .cornerRadius(20)
    }
}

#Preview {
    BarGraphView(
        data: [5, 2, 4, 3, 5, 1, 5],
        labels: ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]
        
    )
}
