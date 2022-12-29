//
//  ProfileModel.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 28/12/22.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ProfileModel: Codable {
    let image: String
    let username: String
    let phoneNum: String
    let dateOfBirth: Date
    let weight: Double
    let height: Double
    let gender: Int
    let bloodType: Int
    let wheelChair: Bool
    let organDonar: Bool
    
    init(image: String, username: String, phoneNum: String, dateOfBirth: Date, weight: Double, height: Double, gender: Int, bloodType: Int, wheelChair: Bool, organDonar: Bool) {
        self.image = image
        self.username = username
        self.phoneNum = phoneNum
        self.dateOfBirth = dateOfBirth
        self.weight = weight
        self.height = height
        self.gender = gender
        self.bloodType = bloodType
        self.wheelChair = wheelChair
        self.organDonar = organDonar
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM YYYY"
        return formatter.string(from: dateOfBirth)
    }
}
