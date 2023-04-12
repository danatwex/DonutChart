//
//  LegendView.swift
//  DonutChart
//
//  Created by Daniel Marques on 24/03/23.
//

import SwiftUI

struct LegendView: View {

    var data: [(label: String, color: Color, value: Double)]

    var values: [Double] { return data.map{ $0.value } }

    var percentages: [String] {
        return values.map { String(format: "%.0f%%", $0 * 100 / values.reduce(0, +)) }
    }

    var body: some View {
        let columns = [GridItem(.flexible(), spacing: 0, alignment: .center),
                       GridItem(.flexible(), spacing: 0, alignment: .center)]
        VStack {
            LazyVGrid(columns: columns, alignment: .center) {
                let count = data.count - (data.count % 2)
                ForEach(0..<count, id: \.self) { i in
                    HStack {
                        Circle()
                            .fill(self.data[i].color)
                            .frame(width: 12)
                        Text("\(percentages[i]) \(data[i].label)")
                            .foregroundColor(.primary)
                            .lineLimit(1)
                    }
                }
            }
            HStack {
                let start = data.count - (data.count % 2)
                ForEach(start..<data.count, id: \.self) { i in
                    HStack {
                        Circle()
                            .fill(self.data[i].color)
                            .frame(width: 12)
                        Text("\(percentages[i]) \(data[i].label)")
                            .foregroundColor(.primary)
                            .lineLimit(1)
                    }
                }
            }
        }.padding(.trailing)
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
