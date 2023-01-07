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
    var description: String
    var departmentName: Department
}

var sampleAppointments: [AppointmentModel] = [
    .init(dateAdded: Date(), hospitalName: "Alchemist", doctorName: "Dr. Bakshi Singh", description: "A dermatologist is a medical doctor who specializes in conditions that affect the skin, hair, and nails. Whether it's rashes, wrinkles, psoriasis, or melanoma, no one understands your skin, hair, and nails better than a board-certified dermatologist.", departmentName: .dermatology),
    .init(dateAdded: Date(), hospitalName: "Alchemist", doctorName: "Dr. Batra", description: "", departmentName: .genearal),
    .init(dateAdded: Date(), hospitalName: "Kalka Nursing Home", doctorName: "Dr. Anil Das", description: "", departmentName: .physician)
]
