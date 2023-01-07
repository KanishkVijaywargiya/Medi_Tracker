//
//  FontsExtension.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 07/01/23.
//

import Foundation
import SwiftUI

enum CustomFont {
    case light
    case bold
    case medium
    case regular
    
    var weight: Font.Weight {
        switch self {
        case .light: return .light
        case .bold: return .bold
        case .medium: return .medium
        case .regular: return .regular
        }
    }
}

