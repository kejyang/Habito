

//When using this view you have to pass in the size that you want and the progress of the circle bar which ranges from 0 to 1

import SwiftUI

struct CircleGraphView: View {
    @Binding var progress: CGFloat
    var lineWidth: CGFloat { size * 0.15 }
    let size: CGFloat
    
    var body: some View {
        VStack {
            ZStack {
                InnerFilledCircle(size: size)
                ProgressCircle(progress: $progress, lineWidth: lineWidth)
                PercentageText(progress: $progress, size: size)
            }
            .frame(width: size, height: size)
            .padding()
            
            // Progress Slider For Testing Purposes
            /*Slider(value: $progress, in: 0...1)
                .padding(.horizontal)*/
        }
    }
}


#Preview {
    CircleGraphView(progress: .constant(0.7), size: 200)
}
