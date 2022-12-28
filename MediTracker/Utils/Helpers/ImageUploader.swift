//
//  ImageUploader.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 28/12/22.
//

import SwiftUI
import FirebaseStorage

enum UploadType {
    case profile
    case medPrescription
     
    var filePath: StorageReference {
        let fileName = NSUUID().uuidString
        switch self {
        case .profile:
            return Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        case .medPrescription:
            return Storage.storage().reference(withPath: "/prescription/\(fileName)")
        }
    }
}

struct ImageUploader {
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let ref = type.filePath
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            print("Successfully uploaded image")
            
            ref.downloadURL { url, _ in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
