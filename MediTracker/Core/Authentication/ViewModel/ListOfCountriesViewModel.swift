//
//  ListOfCountriesViewModel.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 20/12/22.
//

import SwiftUI

class ListOfCountriesViewModel: ObservableObject {
    @Published var countryArray: [CountryModel] = []
    
    init() {
        getCountryName()
    }
    
    func getCountryName(text: String = "") {
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
            if text.isEmpty {
                self.countryArray = items
            } else {
                self.countryArray = items.filter { $0.countryName.localizedCaseInsensitiveContains(text.lowercased()) ||
                    $0.countryCode.localizedCaseInsensitiveContains(text.lowercased())
                }
            }
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
