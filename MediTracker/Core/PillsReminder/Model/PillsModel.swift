//
//  PillsModel.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 19/01/23.
//

import Foundation

struct PillsModel: Identifiable {
    var id: UUID = .init()
    var medicineName: String
    var medicineForm: String
    var intake: String
    var startDate: Date
    var endDate: Date
}
