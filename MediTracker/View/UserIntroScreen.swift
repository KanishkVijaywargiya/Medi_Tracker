//
//  UserIntroScreen.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 26/12/22.
//

import SwiftUI

struct UserIntroScreen: View {
    @Environment(\.dismiss) private var dismissMode
    @State private var showHome: Bool = false
    
    var body: some View {
        ZStack {
            MTButton(action: {
                self.showHome = true
                UserDefaults.standard.UserIntroScreenShown = true
                self.dismissMode()
            }, title: "Save", hexCode: K.BrandColors.pink)
        }
        .fullScreenCover(isPresented: $showHome) {
            HomeView()
        }
    }
}

struct UserIntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserIntroScreen()
    }
}
