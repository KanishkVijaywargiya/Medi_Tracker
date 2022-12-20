//
//  CountryModel.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 20/12/22.
//

import SwiftUI

struct CountryModel: Identifiable {
    var id = UUID()
    var flag: String
    var countryName: String
    var countryCode: String
}
