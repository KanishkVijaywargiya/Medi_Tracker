//
//  HomeView.swift
//  MediTracker
//
//  Created by MANAS VIJAYWARGIYA on 15/12/22.
//

import SwiftUI

/*
 TODO:
 2. make full screen cover instead of medium for localization
 3. add functionality of scroll to top in language screen
 4. add accordian design modification to normal cards of language selection
 5. add more languages
 6. need to check the verification manual typing & button calling func.
 */


struct HomeView: View {
    // MARK: used for localization sheet
    @State private var showLanguageSheet: Bool = false
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            Color.white.opacity(0.1).ignoresSafeArea()
            // MARK: Header Section
            HStack (alignment: .center) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Good Morning,")
                        .font(.title2.bold())
                        .foregroundColor(.secondary)
                    Text("John Carter").font(.title3.bold())
                }// user name
                
                Spacer()
                
                GlassButton(
                    iconName: LocalizationService.shared.langText,
                    action: { self.showLanguageSheet.toggle() }
                )
                .padding()
                
                Image(systemName: "person.fill")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.all, 6)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay { Circle().stroke(Color.black.opacity(0.3), lineWidth: 2) }
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showLanguageSheet) {
            LanguageSheet().presentationDetents([.medium])
        }//for lang. select
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
