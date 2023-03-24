//
//  ChartDataHandling.swift
//  DonutChart
//
//  Created by Daniel Marques on 24/03/23.
//

import SwiftUI

protocol ChartDataHandling {

    var data: [(label: String, color: Color, value: Double)] { get set }
}

extension ChartDataHandling {

    var values: [Double] { return data.map{ $0.value } }

    var percentages: [String] {
        return values.map { String(format: "%.0f%%", $0 * 100 / values.reduce(0, +)) }
    }

    var slices: [SliceData] {
        let valueSum = values.reduce(0, +)
        var degreeSum: Double = 0
        var slices: [SliceData] = []

        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / valueSum
            slices.append(SliceData(startAngle: Angle(degrees: degreeSum),
                                        endAngle: Angle(degrees: degreeSum + degrees),
                                        text: String(format: "%.0f%%", value * 100 / valueSum),
                                        color: self.data[i].color))
            degreeSum += degrees
        }
        return slices
    }
}
