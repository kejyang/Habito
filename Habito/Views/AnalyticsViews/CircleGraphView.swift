

//When using this view you have to pass in the size that you want and the progress of the circle bar which ranges from 0 to 1

import SwiftUI

struct CircleGraphView: View {
    @Binding var progress: CGFloat
    var lineWidth: CGFloat { size * 0.1 }
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

struct ProgressCircle: View {
    @Binding var progress: CGFloat
    let lineWidth: CGFloat

    var body: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(
                AngularGradient(
                    gradient: Gradient(stops: [
                        .init(color: .brandProgressBar, location: 0.0),
                        .init(color: .brandPrimary, location: 0.25),
                        .init(color: .brandPrimary, location: 0.75),
                        .init(color: .brandProgressBar, location: 1.0)
                    ]),
                    center: .center,
                    startAngle: .degrees(0),
                    endAngle: .degrees(360)
                ),
                style: StrokeStyle(lineWidth: lineWidth)
            )
            .rotationEffect(.degrees(-90))
            .animation(.easeOut, value: progress)
    }
}


struct InnerFilledCircle: View {
    let lineWidth: CGFloat = 20
    let size: CGFloat
    var body: some View {
        Circle()
            .fill(Color.brandWhite)
            .frame(
                width: size - lineWidth,
                height: size - lineWidth
            )
    }
}

struct PercentageText: View {
    @Binding var progress: CGFloat
    let size: CGFloat
    var body: some View {
        Text("\(Int(progress * 100))%")
            .font(.system(size: size * 0.22, weight: .bold))
    }
}
