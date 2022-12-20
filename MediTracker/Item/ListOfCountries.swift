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
    
    @StateObject private var vm = ListOfCountriesViewModel()
    @State private var searchText: String = ""
    
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
            
            List(vm.countryArray, id: \.id) { item in
                CountryCard(flag: item.flag, countryName: item.countryName, countryCode: item.countryCode)
                    .background(Color.white)
                    .onTapGesture {
                        self.countryCode = item.countryCode
                        self.countryFlag = item.flag
                        self.dismissMode()
                    }
            }.listStyle(PlainListStyle())
        }
        .searchable(text: $searchText)
        .onAppear {
            vm.getCountryName()
        }
    }
}

struct ListOfCountries_Previews: PreviewProvider {
    static var previews: some View {
        ListOfCountries(countryCode: .constant("+91"), countryFlag: .constant("🇮🇳"))
    }
}


