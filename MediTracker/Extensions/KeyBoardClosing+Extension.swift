//
//  KeyBoardClosing.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 13/01/23.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
