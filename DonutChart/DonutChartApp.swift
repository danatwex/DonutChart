//
//  DonutChartApp.swift
//  DonutChart
//
//  Created by Daniel Marques on 23/03/23.
//

import SwiftUI

@main
struct DonutChartApp: App {
    var body: some Scene {
        WindowGroup {

            let data: [(label: String, color: Color, value: Double)] = [
                ("Essentials", Color(uiColor: .systemBlue), 10),
                ("Discretionary", Color(uiColor: .systemCyan), 10),
                ("Savings", Color(uiColor: .systemMint), 10)
            ]
            ChartView(data: data).padding()
        }
    }
}
