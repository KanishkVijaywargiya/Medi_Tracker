//
//  ContentView.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 11/12/22.
//

import SwiftUI
import AwesomeNetwork

struct ContentView: View {
    @State private var splashView: Bool = true
    
    var body: some View {
        VStack {
            if splashView {
                SplashScreen()
            } else {
                NavigationView {
                    AuthenticationView()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut) {
                    self.splashView = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(NetworkConnection())
    }
}
