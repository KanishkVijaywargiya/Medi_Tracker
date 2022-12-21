//
//  FooterText.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 21/12/22.
//

import SwiftUI

struct FooterText: View {
    var text: String
    var action: () -> ()
    var body: some View {
        Text(text)
            .overlay {
                Rectangle()
                    .foregroundColor(.black.opacity(0.1))
                    .frame(height: 2)
                    .padding(.top)
            }
            .onTapGesture { action() }
    }
}

struct FooterText_Previews: PreviewProvider {
    static var previews: some View {
        FooterText(text: "Terms & Conditions", action: {})
    }
}
