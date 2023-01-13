//
//  ActivityModel.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 11/01/23.
//

import Foundation

struct ActivityModel: Identifiable {
    var id: UUID = .init()
    var title: Description
    var data: String
    var iconName: String
    var chartData: String
}

var sampleActivity: [ActivityModel] = [
    .init(title: .step, data: "3,456", iconName: "figure.step.training", chartData: "chart.bar"),
    .init(title: .heart, data: "3,456", iconName: "heart", chartData: "chart.bar"),
    .init(title: .weights, data: "3,456", iconName: "", chartData: "chart.bar"),
    .init(title: .sleep, data: "3,456", iconName: "", chartData: "chart.bar"),
]
