//
//  ListOfCountriesViewModel.swift
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

class ListOfCountriesViewModel: ObservableObject {
    @Published var countryArray: [CountryModel] = []
    
    func getCountryName() {
        var flagIcon: String = ""
        var name: String = ""
        var code: String = ""
        var items: [CountryModel] = []
        for (key, value) in Country.instace.countryDictionary.sorted(by: <) {
            flagIcon = flag(country: key)
            name = countryName(countryCode: key) ?? key
            code = "+\(value)"
            items.append(CountryModel(flag: flagIcon, countryName: name, countryCode: code))
        }
        DispatchQueue.main.async {
            self.countryArray = items
        }
    }
    
    private func countryName(countryCode: String) -> String? {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: countryCode)
    }
    
    private func flag(country: String) -> String {
        let base : UInt32 = 127397
        var flag = ""
        for v in country.unicodeScalars {
            flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return flag
    }
}
