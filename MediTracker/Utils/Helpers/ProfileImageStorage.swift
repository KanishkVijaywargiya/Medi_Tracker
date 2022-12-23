//
//  ProfileImageStorage.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 23/12/22.
//

import SwiftUI

enum StorageType {
    case userDefaults
    case fileSystem
}

func store(image: UIImage, forKey key: String, withStorageType storageType: StorageType) {
//    if let pngRepresentation = image.pngData() {
    if let pngRepresentation = image.jpegData(compressionQuality: 0.3) {
        switch storageType {
        case .userDefaults:
            // save to user defaults
            UserDefaults.standard.set(pngRepresentation, forKey: key)
        case .fileSystem:
            // save to disk
            if let filePath = filePath(forKey: key) {
                do {
                    try pngRepresentation.write(to: filePath, options: .atomic)
                } catch let err {
                    print("Saving file resulted in error: ", err)
                }
            }
        }
    }
}

func retrieveImage(forKey key: String, inStorageType storageType: StorageType) -> UIImage {
    switch storageType {
    case .userDefaults:
        // retrieve image from user defaults
        if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
           let image = UIImage(data: imageData) {
            return image
        }
    case .fileSystem:
        // retrieve image from disk
        if let filePath = filePath(forKey: key),
           let fileData = FileManager.default.contents(atPath: filePath.path),
           let image = UIImage(data: fileData) {
            return image
        }
    }
    return UIImage()
}

private func filePath(forKey key: String) -> URL? {
    let fileManager = FileManager.default
    guard let documentURL = fileManager.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
    
    return documentURL.appendingPathComponent(key + ".png")
}

