//
//  ProfileModel.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 28/12/22.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


struct ProfileModel: Identifiable, Codable {
    @DocumentID var id: String?
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
}
