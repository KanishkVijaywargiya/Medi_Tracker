//
//  ProfileViewModel.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 26/12/22.
//

// TODO: solve small bugs related to user data avail, then home screen otherwise user intro screen
// TODO: develop edit screen for profile
// TODO: add allergies in profile view & save it to core data

// TODO: solve small bugs related to verification & login screen
// TODO: disable all the text inputs fileds in login & in verification screen, when pressed on continue

// TODO: Add more localized lang. to cover whole India

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import CoreData

class ProfileViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var userProfileData: ProfileModel = .init(image: "", username: "", phoneNum: "", dateOfBirth: Date(), weight: 0.0, height: 0.0, gender: 0, bloodType: 0, wheelChair: false, organDonar: false)
    @Published var checkDataExists: Bool = false //check data avail on firestore
    
    @AppStorage("mobile_num") private var mobile_num = "" //mobile num
    
    init() {
        if !mobile_num.isEmpty {
            fetchUserData()
            checkFirestoreData()
        }
    }
    
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
                //Task {await self.fetchUserData()}
                self.fetchUserData()
            }
        }
    }
    
    
    // MARK: Fetch user data
    func fetchUserData() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        let _ = COLLECTION_USERS.document(mobile_num).getDocument { snapshot, _ in
            guard let dictionary = snapshot?.data() else { return }
            
            guard let image = dictionary["image"] as? String else { return }
            guard let username = dictionary["username"] as? String else { return }
            guard let phoneNum = dictionary["phoneNum"] as? String else { return }
            let dateOfBirth = (dictionary["dateOfBirth"] as? Timestamp)?.dateValue() ?? Date()
            guard let weight = dictionary["weight"] as? Double else { return }
            guard let height = dictionary["height"] as? Double else { return }
            guard let gender = dictionary["gender"] as? Int else { return }
            guard let bloodType = dictionary["bloodType"] as? Int else { return }
            let wheelChairNum = dictionary["wheelChair"] as? NSNumber
            let wheelChairBool = Bool(truncating: wheelChairNum ?? 1)
            let organDonar = dictionary["organDonar"] as? NSNumber
            let organDonarBool = Bool(truncating: organDonar ?? 1)
            
            self.userProfileData = ProfileModel(image: image, username: username, phoneNum: phoneNum, dateOfBirth: dateOfBirth, weight: weight, height: height, gender: gender, bloodType: bloodType, wheelChair: wheelChairBool, organDonar: organDonarBool)
        }
    }
    
    // MARK: Check if data is avail in firebase firestore
    func checkFirestoreData() {
        let _ = COLLECTION_USERS.document(mobile_num).getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let _ = data {
                    self.checkDataExists = true
                } else {
                    self.checkDataExists = false
                }
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
