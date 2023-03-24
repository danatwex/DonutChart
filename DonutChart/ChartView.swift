//
//  ChartView.swift
//  DonutChart
//
//  Created by Daniel Marques on 23/03/23.
//

import SwiftUI

struct ChartView: ChartDataHandling, View {

    var data: [(label: String, color: Color, value: Double)]

    public var widthFraction: CGFloat = 1
    public var innerRadiusFraction: CGFloat = 0.60

    @State private var activeIndex: Int = -1

    public var body: some View {
            GeometryReader { geometry in
                VStack {
                    ZStack{
                        let slices = self.slices
                        ForEach(0..<self.values.count, id: \.self) { i in
                            SliceView(sliceData: slices[i])
                                .scaleEffect(self.activeIndex == i ? 1.03 : 1)
                                .animation(Animation.spring(), value: 3)
                        }
                        .frame(width: widthFraction * geometry.size.width,
                               height: widthFraction * geometry.size.width)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let radius = 0.5 * widthFraction * geometry.size.width
                                    let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
                                    let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
                                    if (dist > radius || dist < radius * innerRadiusFraction) {
                                        self.activeIndex = -1
                                        return
                                    }
                                    var radians = Double(atan2(diff.x, diff.y))
                                    if (radians < 0) {
                                        radians = 2 * Double.pi + radians
                                    }

                                    for (i, slice) in slices.enumerated() {
                                        if (radians < slice.endAngle.radians) {
                                            self.activeIndex = i
                                            break
                                        }
                                    }
                                }
                                .onEnded { value in
                                    self.activeIndex = -1
                                }
                        )
                        Circle()
                            .fill(Color(uiColor: UIColor.systemBackground))
                            .frame(width: widthFraction * geometry.size.width * innerRadiusFraction, height: widthFraction * geometry.size.width * innerRadiusFraction)

                        VStack {
                            Text(self.activeIndex == -1 ? "Total" : data[self.activeIndex].label)
                                .font(.callout)
                                .foregroundColor(Color.secondary)
                            Text(String(format: "$%.2f", self.activeIndex == -1 ? values.reduce(0, +) : values[self.activeIndex]))
                                .foregroundColor(Color.primary)
                                .font(.title)
                        }

                    }
                    LegendView(data: data)
                }
                .background(Color(uiColor: UIColor.systemBackground))
                .foregroundColor(Color.white)
            }
        }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {

        let data: [(label: String, color: Color, value: Double)] = [
            ("Essentials", Color(uiColor: .systemBlue), 10),
            ("Discretionary", Color(uiColor: .systemCyan), 10),
            ("Savings", Color(uiColor: .systemMint), 10)
        ]
        ChartView(data: data)
    }
}
