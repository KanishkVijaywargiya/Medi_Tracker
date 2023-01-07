//
//  DateExtension.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 07/01/23.
//

import SwiftUI

extension Date {
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
