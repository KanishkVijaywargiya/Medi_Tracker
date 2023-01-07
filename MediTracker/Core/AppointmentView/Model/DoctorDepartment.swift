//
//  Department.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 07/01/23.
//

import Foundation
import SwiftUI

// MARK: Doctor Department Enum with Color codes
enum Department: String, CaseIterable, CustomStringConvertible {
    case genearal = "General Surgeon"
    case physician = "Genearl Physician"
    case anesthetics = "Anesthetics"
    case cardio = "Cardiology"
    case ent = "ENT"
    case gas = "Gastroenterology"
    case gyne = "Gynecology"
    case neurology = "Neurology"
    case dermatology = "Dermatology"
    
    var description: String {
        return self.rawValue
    }
    
    var color: Color {
        switch self {
        case .genearal: return Color(K.BrandColors.codeGreen)
        case .physician: return Color(K.BrandColors.darkBlue)
        case .anesthetics: return Color(K.BrandColors.codePurple)
        case .cardio: return Color(K.BrandColors.pink)
        case .ent: return Color(K.BrandColors.codeBrown)//
        case .gas: return Color(K.BrandColors.codeEng)//
        case .gyne: return Color(K.BrandColors.codeRed)
        case .neurology: return Color(K.BrandColors.pastelGreen3)
        case .dermatology: return Color(K.BrandColors.codeOrange)
        }
    }
}

