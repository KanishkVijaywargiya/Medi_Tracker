//
//  LanguageSheet.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 19/12/22.
//

import SwiftUI

struct LanguageSheet: View {
    @Environment(\.dismiss) private var dismissMode
    
    // MARK: app storage for localization
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SELECT_LANG".localized(language_choosen))
                .font(.title2.bold())
                .padding(.vertical)
            
            ForEach(languageSelection, id: \.checkLangName) { item in
                LanguageCard(isClicked: item.checkLangName == language_choosen, item: item) {
                    LocalizationService.shared.language = item.checkLangName
                    self.dismissMode()
                }
            }
            
            Spacer()
        }.padding(.horizontal)
    }
}

struct LanguageSheet_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSheet()
    }
}
