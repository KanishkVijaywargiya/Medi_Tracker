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
                .font(.title2.bold())
                .foregroundColor(Color(hex: "#E6425E"))
            
                .overlay {
                    Image(systemName: "character.bubble.fill.ja")
                        .font(.title2.bold())
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white,
                            Color(hex: "#E6425E")
                        )
                        .offset(x: 17, y: 5)
                }
                .foregroundColor(Color.orange)
                .onTapGesture(perform: action)
        } else {
            HStack(alignment: .center) {
                Image(systemName: "globe")
                    .font(.title2.bold())
                    .foregroundColor(Color(hex: "#E6425E"))
                Text(iconName).foregroundColor(Color(hex: "#E6425E")).bold()
            }.onTapGesture(perform: action)
        }
    }
}

struct GlassButton_Previews: PreviewProvider {
    static var previews: some View {
        GlassButton(action: {}).previewLayout(.sizeThatFits)
    }
}
