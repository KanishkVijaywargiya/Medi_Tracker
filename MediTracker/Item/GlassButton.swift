//
//  GlassButton.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 14/12/22.
//

import SwiftUI

struct GlassButton: View {
    var iconName: String = "chevron.backward"
    var iconSize: CGFloat = 12
    var action: () -> ()
    
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language
    
    var body: some View {
        if language_choosen == .english_us {
            Image(systemName: "character.bubble")
                .overlay {
                    Image(systemName: "character.bubble.fill.ja")
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white,
                            Color.orange
                        )
                        //.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 40))
                        //.shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 0)
                        .offset(x: 13, y: 5)
                }
                .foregroundColor(Color.orange)
                .onTapGesture(perform: action)
        } else {
            HStack {
                Image(systemName: "globe").foregroundColor(.orange)
                Text(iconName).foregroundColor(.orange).bold()
            }.onTapGesture(perform: action)
        }
    }
}

struct GlassButton_Previews: PreviewProvider {
    static var previews: some View {
        GlassButton(action: {})
    }
}
