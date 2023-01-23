//
//  BottomTabView.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 22/01/23.
//

import SwiftUI

struct BottomTabView: View {
    @State private var tabSelection = 1
    @State private var tappedTwice = false
    
    @ObservedObject var vm: ProfileViewModel
    @ObservedObject var appointVM: AppointmentCoreDataVM //appointment CoreData
    @ObservedObject var medicineVM: PillsCoreDataVM //Pills CoreData
    
    var handler: Binding<Int> { Binding(
        get: { self.tabSelection },
        set: {
            if $0 == self.tabSelection {
                tappedTwice = true
            }
            self.tabSelection = $0
        }
    )}
    
    var body: some View {
        ScrollViewReader { proxy in
            TabView(selection: handler) {
                HomeView(appointVM: appointVM, profileVM: vm)
                    .onChange(of: tappedTwice) { tapped in
                        if tapped {
                            withAnimation {
                                proxy.scrollTo("HOME")
                            }
                            self.tappedTwice = false
                        }
                    }
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }.tag(1)
                
                PillsView(pillsViewModel: medicineVM)
                    .onChange(of: tappedTwice) { tapped in
                        if tapped {
                            withAnimation {
                                proxy.scrollTo("PILLS")
                            }
                            self.tappedTwice = false
                        }
                    }
                    .tabItem {
                        Label("Pills", systemImage: "pills.fill")
                    }.tag(2)
                
                HealthView()
                    .onChange(of: tappedTwice) { tapped in
                        if tapped {
                            withAnimation {
                                proxy.scrollTo("HEALTH")
                            }
                            self.tappedTwice = false
                        }
                    }
                    .tabItem {
                        Label("Health", systemImage: "heart.fill")
                    }.tag(3)
            }
            .tint(Color(K.BrandColors.pink))
        }
    }
}

struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabView(vm: ProfileViewModel(), appointVM: AppointmentCoreDataVM(), medicineVM: PillsCoreDataVM())
    }
}
