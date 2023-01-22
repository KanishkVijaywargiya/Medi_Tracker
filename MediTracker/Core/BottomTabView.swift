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
    
    var body: some View {
        var handler: Binding<Int> { Binding(
            get: { self.tabSelection },
            set: {
                if $0 == self.tabSelection {
                    tappedTwice = true
                }
                self.tabSelection = $0
            }
        )}
        
        return ScrollViewReader { proxy in
            TabView(selection: handler) {
                HomeView(appointVM: appointVM, profileVM: vm)
                    .onChange(of: tappedTwice) { tapped in
                        if tapped {
                            withAnimation {
                                proxy.scrollTo(1)
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
                                proxy.scrollTo(2)
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
                                proxy.scrollTo(3)
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
