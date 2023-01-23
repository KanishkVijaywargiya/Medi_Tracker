//
//  Health.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 22/01/23.
//

import SwiftUI

struct HealthView: View {
    @EnvironmentObject private var healthVM: HealthKitViewModel
    
    var body: some View {
        VStack {
            if healthVM.isAuthorized {
                VStack {
                    Text("Today's step count").font(.title3)
                    
                    Text(healthVM.userStepCount)
                        .font(.largeTitle.bold())
                }
            } else {
                VStack {
                    Text("Please Authorize Health").font(.title3)
                    
                    MTButton(action: {
                        healthVM.healthRequest()
                    }, title: "Authorize Health Kit", hexCode: K.BrandColors.pink)
                    .frame(width: 320)
                }.padding()
            }
        }
    }
}

struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView().environmentObject(HealthKitViewModel())
    }
}
