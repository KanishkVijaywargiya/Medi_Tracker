//
//  ListOfCountries.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 13/12/22.
//

import SwiftUI

struct ListOfCountries: View {
    @Environment(\.dismiss) var dismissMode
    @Binding var countryCode: String
    @Binding var countryFlag: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "chevron.down")
                    .padding(.trailing)
                    .onTapGesture { self.dismissMode() }
                Text("List of Countries")
                    .foregroundColor(.primary)
                    .font(.title.bold())
            }.padding(.leading)
            
            List(Country.instace.countryDictionary.sorted(by: <), id: \.key) { key, value in
                HStack {
                    Text("\(self.flag(country: key))")
                    Text("\(self.countryName(countryCode: key) ?? key)")
                    Spacer()
                    Text("+\(value)").foregroundColor(.secondary)
                }
                .background(Color.white)
                .onTapGesture {
                    self.countryCode = value
                    self.countryFlag = self.flag(country: key)
                    self.dismissMode()
                }
            }.listStyle(PlainListStyle())
        }
    }
    
    func countryName(countryCode: String) -> String? {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: countryCode)
    }
    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var flag = ""
        for v in country.unicodeScalars {
            flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return flag
    }
}

struct ListOfCountries_Previews: PreviewProvider {
    static var previews: some View {
        ListOfCountries(countryCode: .constant("+91"), countryFlag: .constant("🇮🇳"))
    }
}


