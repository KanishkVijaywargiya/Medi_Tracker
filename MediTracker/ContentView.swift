//
//  ContentView.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 11/12/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @AppStorage("log_status") private var log_status = false
    var body: some View {
        NavigationView {
            if log_status {
                Text("Home").navigationTitle("Home")
            } else {
                Login()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
