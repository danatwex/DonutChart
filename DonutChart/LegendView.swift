//
//  LegendView.swift
//  DonutChart
//
//  Created by Daniel Marques on 24/03/23.
//

import SwiftUI

struct LegendView: ChartDataHandling, View {

    var data: [(label: String, color: Color, value: Double)]
    var body: some View {
        VStack{
            ForEach(0..<data.count, id: \.self) { i in
                HStack {
                    Circle()
                        .fill(self.data[i].color)
                        .frame(width: 12)
                        .padding(.leading)
                    Text(self.data[i].label)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(String(format: "$%.2f", self.data[i].value))
                        .font(.body.monospacedDigit())
                        .foregroundColor(.primary)
                    Text(percentages[i])
                        .font(.body.monospacedDigit())
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        let data: [(label: String, color: Color, value: Double)] = [
            ("Essentials", Color(uiColor: .systemBlue), 10),
            ("Discretionary", Color(uiColor: .systemCyan), 10),
            ("Savings", Color(uiColor: .systemMint), 10)
        ]
        LegendView(data: data)
    }
}
