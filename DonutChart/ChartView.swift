//
//  ChartView.swift
//  DonutChart
//
//  Created by Daniel Marques on 23/03/23.
//

import SwiftUI

struct ChartView: View {

    var data: [(label: String, color: Color, value: Double)]

    var values: [Double] { return data.map{ $0.value } }

    var spent: Double

    var leftover: Double

    var currencyFormatter: NumberFormatter {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 2
        return currencyFormatter
    }

    var slices: [SliceData] {
        let valueSum = values.reduce(0, +)
        var degreeSum: Double = 0
        var slices: [SliceData] = []

        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / valueSum
            if degrees > 2 {
                slices.append(SliceData(startAngle: Angle(degrees: degreeSum),
                                            endAngle: Angle(degrees: degreeSum + degrees),
                                            text: String(format: "%.0f%%", value * 100 / valueSum),
                                            color: self.data[i].color))
                degreeSum += degrees
            }
        }
        return slices
    }

    public var body: some View {
        VStack {
            ZStack {
                let slices = self.slices
                let size = 0.65 * UIScreen.main.bounds.size.width
                let ringWidth: CGFloat = 28
                ForEach(0..<self.slices.count, id: \.self) { i in
                    SliceView(sliceData: slices[i])
                }
                .frame(width: size, height: size)

                Circle()
                    .fill(Color(.systemBackground))
                    .frame(width: size - ringWidth * 2,
                           height: size - ringWidth * 2)



                let formatter = currencyFormatter

                VStack(spacing: 2) {
                    Text((formatter.string(from: NSNumber(value: spent)) ?? "") + " spent")
                        .foregroundColor(Color.primary)
                        .font(.title3)
                    Text((formatter.string(from: NSNumber(value: leftover)) ?? "") + " leftover")
                        .font(.caption)
                        .foregroundColor(Color.secondary)
                }
            }
        }
        .background(Color(.systemBackground))
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {

        let data: [(label: String, color: Color, value: Double)] = [
            ("Essentials", Color.blue, 10),
            ("Discretionary", Color.cyan, 10),
            ("Savings", Color.mint, 10)
        ]
        ChartView(data: data, spent: 30, leftover: 60)
            .padding()
    }
}
