//
//  CountryCard.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 20/12/22.
//

import SwiftUI

struct CountryCard: View {
    var flag: String
    var countryName: String
    var countryCode: String
    
    var body: some View {
        HStack {
            Text(flag)
            Text(countryName)
            Spacer()
            Text(countryCode).foregroundColor(.secondary)
        }
    }
}

struct CountryCard_Previews: PreviewProvider {
    static var previews: some View {
        CountryCard(flag: "🇮🇳", countryName: "India", countryCode: "+91")
    }
}
