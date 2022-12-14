//
//  Button.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 14/12/22.
//

import SwiftUI

struct MTButton: View {
    var action: () -> ()
    var title: String
    var hexCode: String
    
    var body: some View {
        Button {action()} label: {
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(hex: hexCode))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct MTButton_Previews: PreviewProvider {
    static var previews: some View {
        MTButton(action: {}, title: "Continue", hexCode: "#E6425E")
    }
}
