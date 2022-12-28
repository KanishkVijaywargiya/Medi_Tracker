//
//  ProfileViewModel.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 26/12/22.
//

import SwiftUI
import Firebase
import CoreData

class ProfileViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var userProfileData = [ProfileModel]()
    
    
    // MARK: Profile upload
    func uploadUserProfile(image: UIImage?, username: String, phoneNum: String, dateOfBirth: Date, weight: Double, height: Double, gender: Int, bloodType: Int, wheelChair: Bool, organDonar: Bool, completion: @escaping(Bool) -> ()) {
        
        self.isLoading = true
        guard let image = image else {
            self.isLoading = false
            return
        }
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            let data: [String: Any] = ["image": imageUrl, "username": username, "phoneNum": phoneNum, "dateOfBirth": dateOfBirth, "weight": weight, "height": height, "gender": gender, "bloodType": bloodType, "wheelChair": wheelChair, "organDonar": organDonar]
            
            COLLECTION_USERS.document(phoneNum).setData(data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false)
                    return
                }
                print("Successfully uploaded user profile data", phoneNum)
                self.isLoading = false
                completion(true)
            }
        }
    }
    
    
    // MARK: Fetch user data
    func fetchUserData(phoneNum: String) {
        self.isLoading = true
        
        COLLECTION_USERS.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.userProfileData = documents.map { (queryDocumentSnapshot) -> ProfileModel in
                let data = queryDocumentSnapshot.data()

                let image = data["image"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let phoneNum = data["phoneNum"] as? String ?? ""
                let dateOfBirth = data["dateOfBirth"] as? Date ?? Date()
                let weight = data["weight"] as? Double ?? 0.0
                let height = data["height"] as? Double ?? 0.0
                let gender = data["gender"] as? Int ?? 0
                let bloodType = data["bloodType"] as? Int ?? 0
                let wheelChair = data["wheelChair"] as? Bool ?? false
                let organDonar = data["organDonar"] as? Bool ?? false

                print("Success!")
                
                return ProfileModel(image: image, username: username, phoneNum: phoneNum, dateOfBirth: dateOfBirth, weight: weight, height: height, gender: gender, bloodType: bloodType, wheelChair: wheelChair, organDonar: organDonar)
            }
        }
    }
}

//class ProfileViewModel: ObservableObject {
//    let container: NSPersistentContainer
//    @Published var savedEntities: [ProfileEntity] = []
//
//    init() {
//        container = NSPersistentContainer(name: "ProfileContainer")
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                print("Error loading CoreData \(error) ⚠️")
//            }
//        }
//
//        fetchProfileData()
//    }
//
//    func fetchProfileData() {
//        let request = NSFetchRequest<ProfileEntity>(entityName: "ProfileEntity")
//        do {
//            savedEntities = try container.viewContext.fetch(request)
//        } catch let error {
//            print("Error fetching. \(error) ⚠️")
//        }
//    }
//
//    func addProfileData(name: String, contactNumber: String, dateOfBirth: Date, weight: String, height: String, gender: String, bloodType: String, wheelChair: Bool, OrganDonar: Bool) {
//        let newData = ProfileEntity(context: container.viewContext)
//
//        newData.name = name
//        newData.contactNumber = contactNumber
//        newData.dateOfBirth = dateOfBirth
//        newData.weight = weight
//        newData.height = height
//        newData.gender = gender
//        newData.bloodType = bloodType
//        newData.wheelChair = wheelChair
//        newData.organDonar = OrganDonar
//    }
//
//    func saveData() {
//        do {
//            try container.viewContext.save()
//        } catch let error {
//            print("Error in saving. \(error) ⚠️")
//        }
//    }
//}
