//
//  BudgetView.swift
//  DonutChart
//
//  Created by Daniel Marques on 12/04/23.
//

import SwiftUI

struct BudgetView: View {

    var income = 6000.00

    @State var essentials = 3000.0
    @State var discretionary = 1800.0
    @State var savings = 1200.0

    var spent: Double {
        return essentials + discretionary + savings
    }

    var leftover: Double {
        return income - spent
    }

    var currencyFormatter: NumberFormatter {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 2
        return currencyFormatter
    }

    var legendData: [(label: String, color: Color, value: Double)] {
        return [
             ("Essentials", Color(uiColor: .systemBlue), essentials),
             ("Discretionary", Color(uiColor: .systemCyan), discretionary),
             ("Savings and debt", Color(uiColor: .systemMint), savings)
        ]
    }

    var chartData: [(label: String, color: Color, value: Double)] {
        var data = legendData
        let leftover = self.leftover
        if leftover > 0 {
            data.append((label: "Leftover", color: Color.gray, value: leftover))
        }
        return data
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {

                    let formatter = currencyFormatter

                    Text("How much do you spend in these categories each month?")
                        .font(.title2)
                    Text("We’ve filled in some recommended numbers, but you should adjust these to estimate your household’s monthly spending.")
                        .font(.body)
                        .foregroundColor(.secondary)

                    ChartView(data: chartData, spent: spent, leftover: leftover)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)

                    LegendView(data: legendData)
                        .padding(.top, 16)

                    BudgetSection(title: "Essentials",
                                  description: "Mortgage/rent, car payments, groceries, utilities, childcare/schooling",
                                  tip: "We recommend 50% of your monthly budget.",
                                  formatter: formatter, total: spent, value: $essentials)
                    BudgetSection(title: "Discretionary",
                                  description: "Entertainment, dining out, clothing, gym memberships, subscription services",
                                  tip: "We recommend 30% of your monthly budget.",
                                  formatter: formatter, total: spent, value: $discretionary)
                    BudgetSection(title: "Savings and debt",
                                  description: "Debt payments, credit card payments, retirement savings, other savings",
                                  tip: "We recommend 20% of your monthly budget.",
                                  formatter: formatter, total: spent, value: $savings)

                    Spacer()

                    Divider().padding(.vertical)

                    Button {
                        let _ = print("Recommendations button tapped")
                    } label: {
                        Text("See my recommendations")
                            .font(.headline)
                            .padding(6)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)


                }
                .padding()
            }
            .toolbar {
                Button("Skip") { }
            }
        }
    }
}

struct BudgetSection: View {

    var title: String
    var description: String
    var tip: String
    let formatter: NumberFormatter
    let total: Double

    @Binding var value: Double

    var percentage: Int {
        return Int(value * 100 / total)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .padding(.top, 16)
                .padding(.bottom, 4)
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.bottom, 6)

            HStack {
                TextField("$0.00", value: $value, formatter: formatter)
                    .keyboardType(.numberPad)
                Text("\(percentage)%")
                    .foregroundColor(.secondary)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.secondary, lineWidth: 0.5)
            )

            Text(tip)
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.leading, 6)
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
    }
}
