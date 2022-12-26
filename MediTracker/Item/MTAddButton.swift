//
//  MTAddButton.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 26/12/22.
//

import SwiftUI

struct MTAddButton: View {
    var title: String
    var iconName: String
    var action: () -> ()
    
    var body: some View {
        Button(action: {action()}) {
            HStack {
                Text(title)
                Image(systemName: iconName)
            }.font(.footnote.bold()).foregroundColor(Color(K.BrandColors.pink))
        }
        .padding(.all, 8)
        .cornerRadius(22)
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.gray.opacity(0.1))
        }
    }
}

struct MTAddButton_Previews: PreviewProvider {
    static var previews: some View {
        MTAddButton(title: "Add", iconName: "plus", action: {})
    }
}
