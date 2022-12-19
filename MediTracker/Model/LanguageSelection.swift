//
//  LanguageSelection.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 19/12/22.
//

import SwiftUI

struct LanguageSelection {
    var langName: String
    var img1: String
    var img2: String
    var checkLangName: Language
}

var languageSelection = [
    LanguageSelection(langName: "English", img1: "engimg1", img2: "engimg2", checkLangName: .english_us),
    LanguageSelection(langName: "हिंदी", img1: "hindi1", img2: "hindi2", checkLangName: .hindi_ind)
]
