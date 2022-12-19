//
//  LanguageSheet.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 19/12/22.
//

import SwiftUI

struct LanguageSheet: View {
    @Environment(\.dismiss) private var dismissMode
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language
    
    var body: some View {
        VStack {
            Button {
                LocalizationService.shared.language = .hindi_ind
                self.dismissMode()
            } label: {
                HStack {
                    Text("Hindi")
                    if language_choosen == .hindi_ind {
                        Image(systemName: "checkmark.seal")
                    }
                }
            }
            
            Button {
                LocalizationService.shared.language = .english_us
                self.dismissMode()
            } label: {
                HStack {
                    Text("English")
                    if language_choosen == .english_us {
                        Image(systemName: "checkmark.seal")
                    }
                }
            }
        }
    }
}

struct LanguageSheet_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSheet()
    }
}
