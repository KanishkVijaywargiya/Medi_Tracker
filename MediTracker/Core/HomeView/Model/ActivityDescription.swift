//
//  ActivityModel.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 11/01/23.
//

import Foundation
import SwiftUI

// MARK: Daily Activity Card Enum with Color codes
enum Description: String, CaseIterable {
    case step = "Daily Steps"
    case heart = "Heart Rate"
    case weights = "Weight"
    case sleep = "Sleep"
    
    var activityDescription: String {
        return self.rawValue
    }
    
    var activityColor: Color {
        switch self {
        case .step: return Color(K.BrandColors.codePurple)
        case .heart: return Color(K.BrandColors.codePink)
        case .weights: return Color(K.BrandColors.codeGreen)
        case .sleep: return Color(K.BrandColors.codeOrange)
        }
    }
}
