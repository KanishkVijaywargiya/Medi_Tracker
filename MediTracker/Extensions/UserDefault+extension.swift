//
//  UserDefault+extension.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 26/12/22.
//

import SwiftUI

extension UserDefaults {
    var UserIntroScreenShown: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "userIntroPage") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userIntroPage")
        }
    }
}
