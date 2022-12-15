//
//  AuthenticationView.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 16/12/22.
//

import SwiftUI
import AwesomeNetwork

struct AuthenticationView: View {
    @AppStorage("log_status") private var log_status = false
    
    var body: some View {
        VStack {
            if log_status {
                           HomeView().navigationTitle("Home")
                       } else {
                           Login()
                       }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView().environmentObject(NetworkConnection())
    }
}
