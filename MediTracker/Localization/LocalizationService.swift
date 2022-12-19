//
//  LocalizationServices.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 19/12/22.
//

import SwiftUI

class LocalizationService {
    static let shared = LocalizationService() // MARK: singleton class
    @AppStorage("language_choosen") private var language_choosen: String = ""
    
    private init() {}
    
    // MARK: computed property
    var language: Language {
        get {
            return Language(rawValue: language_choosen) ?? .english_us
        }
        set {
            if newValue != language {
                self.language_choosen = newValue.rawValue
            }
        }
    }
    
    // MARK: computed property for getting lang. text
    var langText: String {
        switch language {
        case .hindi_ind: return "हिंदी"
        default: return ""
        }
    }
}

// MARK: this LocalizationService class will do following things:
/// - Provide the current language.
/// - Save the language in UserDefaults / AppStorage to keep chosen language between app launches.
