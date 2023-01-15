//
//  GreetingText.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 15/01/23.
//

import Foundation

enum Greeting {
    case morning
    case afternoon
    case evening
}

private func getGreetingText() -> Greeting {
    let now = Date()
    let hour = Calendar.current.component(.hour, from: now)
    
    if hour < 12 {
        return .morning
    } else if hour < 17 {
        return .afternoon
    } else {
        return .evening
    }
}

func displayGreeting() -> String {
    let currentGreeting = getGreetingText()
    
    switch currentGreeting {
    case .morning: return K.LocalizedKey.GOOD_MOR
    case .afternoon: return K.LocalizedKey.GOOD_AFTER
    case .evening: return K.LocalizedKey.GOOD_EVE
    }
}
