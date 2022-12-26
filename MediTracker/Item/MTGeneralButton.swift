//
//  MTGeneralButton.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 26/12/22.
//

import SwiftUI

struct MTGeneralButton: View {
    var title: String
    var action: () -> ()
    
    var body: some View {
        Button(action: {action()}) {
            Text(title)
        }
        .padding()
        .frame(width: 120)
        .background(.white)
        .foregroundColor(.primary)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct MTGeneralButton_Previews: PreviewProvider {
    static var previews: some View {
        MTGeneralButton(title: "General", action: {})
    }
}
