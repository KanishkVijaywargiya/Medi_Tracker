//
//  BindingExtensions.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 21/01/23.
//

import SwiftUI

extension Binding where Value == String {
    func limit(_ length: Int) -> Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        
        return self
    }
}
