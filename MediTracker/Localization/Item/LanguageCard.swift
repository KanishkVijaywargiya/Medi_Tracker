//
//  LanguageItem.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 19/12/22.
//

import SwiftUI

struct LanguageCard: View {
    var isClicked: Bool = false
    var item: LanguageSelection
    let action: () -> ()
    
    var body: some View {
            HStack {
                Image(systemName: self.isClicked ? K.SFSymbols.larFillCircle : K.SFSymbols.circle)
                    .foregroundColor(Color(isClicked ? K.BrandColors.pink : K.BrandColors.black))
                Text(item.langName)
                Spacer()
            }
            .padding([.vertical, .horizontal], 18)
            .padding()
            .background(isClicked ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay {
                HStack {
                    Spacer()
                    Image(self.isClicked ? item.img1 : item.img2)
                        .resizable()
                        .frame(width: 100, height: 80)
                        .padding(.trailing, 8)
                }
            }
            .onTapGesture(perform: action)
    }
}

struct LanguageCard_Previews: PreviewProvider {
    static var previews: some View {
        LanguageCard(item: languageSelection[0], action: {})
    }
}
