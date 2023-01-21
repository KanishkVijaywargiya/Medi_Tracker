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
    case night
}

private func getGreetingText() -> Greeting {
    let now = Date()
    let hour = Calendar.current.component(.hour, from: now)
    
    if hour < 12 {
        return .morning
    } else if hour < 17 {
        return .afternoon
    } else if hour < 20 {
        return .evening
    } else {
        return .night
    }
}

// used in home view
func displayGreeting() -> String {
    let currentGreeting = getGreetingText()
    
    switch currentGreeting {
    case .morning: return K.LocalizedKey.GOOD_MOR
    case .afternoon: return K.LocalizedKey.GOOD_AFTER
    case .evening: return K.LocalizedKey.GOOD_EVE
    case .night: return K.LocalizedKey.GOOD_EVE
    }
}

//used in pills view
func displayGreetingTextForPills() -> String {
    let currentGreeting = getGreetingText()
    
    switch currentGreeting {
    case .morning: return "Morning"
    case .afternoon: return "Afternoon"
    case .evening: return "Evening"
    case .night: return "Evening"
    }
}

//used in pills view - change image
func displayImageWRTTime() -> String {
    let currentGreeting = getGreetingText()
    
    switch currentGreeting {
    case .morning: return "morning"
    case .afternoon: return "afternoon"
    case .evening: return "evening"
    case .night: return "night"
    }
}


