//
//  ChartView.swift
//  DonutChart
//
//  Created by Daniel Marques on 23/03/23.
//

import SwiftUI

struct ChartView: ChartDataHandling, View {

    var data: [(label: String, color: Color, value: Double)]

    public var width: CGFloat = 0.80
    public var padding: CGFloat = 60.0

    public var total = 90.0
    public var spent = 90.0

    public var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    let slices = self.slices
                    ForEach(0..<self.values.count, id: \.self) { i in
                        SliceView(sliceData: slices[i])
                            .animation(Animation.spring(), value: 3)
                    }
                    .frame(width: geometry.size.width - padding,
                           height: geometry.size.width - padding)
                    Circle()
                        .fill(Color(uiColor: UIColor.systemBackground))
                        .frame(width: geometry.size.width * width - padding,
                               height: geometry.size.width * width - padding)

                    VStack(spacing: 2) {
                        Text(String(format: "$%.2f", spent) + " spent")
                            .foregroundColor(Color.primary)
                            .font(.title2)
                        Text(String(format: "$%.2f", total - spent) + " leftover")
                            .font(.callout)
                            .foregroundColor(Color.secondary)
                    }
                }
                LegendView(data: data)
                    .padding(.top, 8)
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
            .padding()
    }
}
