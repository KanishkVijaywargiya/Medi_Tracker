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
        NavigationStack {
            VStack(alignment: .leading) {
                title
                listSection
            }
            .onChange(of: searchText, perform: { newValue in
                vm.getCountryName(text: searchText)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.down")
                        .padding(.trailing)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                self.dismissMode()
                            }
                        }
                }
            }// closing button for full sheet
        }.searchable(text: $searchText)
    }
}

struct ListOfCountries_Previews: PreviewProvider {
    static var previews: some View {
        ListOfCountries(countryCode: .constant("+91"), countryFlag: .constant("🇮🇳"))
    }
}

extension ListOfCountries {
    private var title: some View {
        Text("List of Countries")
            .foregroundColor(.primary)
            .font(.title.bold())
            .padding(.leading)
    }
    
    private var listSection: some View {
        List(vm.countryArray, id: \.id) { item in
            CountryCard(flag: item.flag, countryName: item.countryName, countryCode: item.countryCode)
                .background(Color.white)
                .onTapGesture {
                    withAnimation(.easeOut) {
                        self.countryCode = item.countryCode
                        self.countryFlag = item.flag
                        self.dismissMode()
                    }
                }
        }.listStyle(PlainListStyle())
    }
}


