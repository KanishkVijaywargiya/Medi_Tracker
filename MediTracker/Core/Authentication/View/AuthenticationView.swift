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
    
    @StateObject private var vm = ProfileViewModel()
    @StateObject private var appointVM = AppointmentCoreDataVM() //appointment CoreData
    @StateObject private var medicineVM = PillsCoreDataVM() //Pills CoreData
    
    @State private var checkData: Bool = false
    
    var body: some View {
        VStack {
            if log_status {
                if UserDefaults.standard.UserIntroScreenShown || self.checkData {
                    BottomTabView(vm: vm, appointVM: appointVM, medicineVM: medicineVM)
                } else {
                    UserIntroScreen(vm: vm, appointVM: appointVM).toolbar(.hidden, for: .navigationBar)
                }
            } else {
                Login()
            }
        }
        .onChange(of: vm.checkDataExists) { newValue in
            self.checkData = newValue
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView().environmentObject(NetworkConnection())
    }
}
