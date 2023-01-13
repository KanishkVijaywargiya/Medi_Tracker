//
//  AppointmentModel.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 07/01/23.
//

import Foundation

struct AppointmentModel: Identifiable, Hashable {
    var id: UUID = .init()
    var dateAdded: Date
    var hospitalName: String
    var doctorName: String
    var descriptions: String
    var departmentName: Department
}

var sampleAppointments: [AppointmentModel] = [
    .init(dateAdded: Date(), hospitalName: "Alchemist", doctorName: "Dr. Bakshi Singh", descriptions: "A dermatologist is a medical doctor who specializes in conditions that affect the skin, hair, and nails. Whether it's rashes, wrinkles, psoriasis, or melanoma, no one understands your skin, hair, and nails better than a board-certified dermatologist.", departmentName: .plasticSurgeon),
    .init(dateAdded: Date(), hospitalName: "Alchemist", doctorName: "Dr. Batra", descriptions: "", departmentName: .genearal),
    .init(dateAdded: Date(), hospitalName: "Kalka Nursing Home", doctorName: "Dr. Anil Das", descriptions: "", departmentName: .physician)
]
