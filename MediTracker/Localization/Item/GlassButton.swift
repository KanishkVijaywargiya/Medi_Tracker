//
//  GlassButton.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 14/12/22.
//

import SwiftUI

struct GlassButton: View {
    var action: () -> ()
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language
    
    var body: some View {
        if language_choosen == .english_us {
            languageSymbol
        } else {
            globeWithLangText
        }
    }
}

struct GlassButton_Previews: PreviewProvider {
    static var previews: some View {
        GlassButton(action: {}).previewLayout(.sizeThatFits)
    }
}

extension GlassButton {
    private var languageSymbol: some View {
        Image(systemName: K.SFSymbols.characBubble)
            .font(.title2.bold())
            .foregroundColor(Color(K.BrandColors.pink))
        
            .overlay {
                Image(systemName: K.SFSymbols.characBubbleFill)
                    .font(.title2.bold())
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white,
                        Color(K.BrandColors.pink)
                    )
                    .offset(x: 17, y: 5)
            }
            .foregroundColor(Color.orange)
            .onTapGesture(perform: action)
    }
    
    private var globeWithLangText: some View {
        HStack(alignment: .center) {
            Image(systemName: K.SFSymbols.globe)
                .font(.title2.bold())
                .foregroundColor(Color(K.BrandColors.pink))
            Text(LocalizationService.shared.langText).foregroundColor(Color(K.BrandColors.pink)).bold()
        }.onTapGesture(perform: action)
    }
}
