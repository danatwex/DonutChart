//
//  SliceView.swift
//  DonutChart
//
//  Created by Daniel Marques on 23/03/23.
//

import SwiftUI

internal struct SliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}

extension Path {
    mutating func addSlice(from startAngle: Angle, to endAngle: Angle, radius: CGFloat) {
        self.addArc(center: CGPoint(x: radius, y: radius),
                    radius: radius,
                    startAngle: Angle(degrees: -90.0) + startAngle,
                    endAngle: Angle(degrees: -90.0) + endAngle,
                    clockwise: false)
    }
}

struct SliceView: View {

    var sliceData: SliceData

    var midRadians: Double {
        let angle = sliceData.startAngle + sliceData.endAngle
        return Double.pi / 2.0 - angle.radians / 2.0
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let radius: CGFloat = min(geometry.size.width, geometry.size.height) * 0.5
                    path.move(to: CGPoint(x: radius, y: radius))
                    path.addSlice(from: sliceData.startAngle, to: sliceData.endAngle, radius: radius)
                }
                .fill(sliceData.color)

                Text(sliceData.text)
                    .position(x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.8 * cos(self.midRadians)),
                              y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.8 * sin(self.midRadians)))
                    .foregroundColor(Color.white)
                    .font(.headline)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct SliceView_Previews: PreviewProvider {
    static var previews: some View {
        SliceView(sliceData: SliceData(startAngle: Angle(degrees: 0.0),
                                        endAngle: Angle(degrees: 60.0),
                                        text: "16.6%", color: Color.red))
    }
}
