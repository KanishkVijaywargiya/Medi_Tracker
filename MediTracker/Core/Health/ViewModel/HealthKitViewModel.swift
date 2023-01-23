//
//  HealthKitViewModel.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 23/01/23.
//

import SwiftUI
import HealthKit

class HealthKitViewModel: ObservableObject {
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    
    @Published var userStepCount = ""
    @Published var isAuthorized = false
    
    init() {
        healthRequest()
    }
    
    func healthRequest() {
        healthKitManager.setupHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
            self.readStepsTakenToday()
        }
    }
    
    private func changeAuthorizationStatus() {
        guard let stepQtyType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
        let status = self.healthStore.authorizationStatus(for: stepQtyType)
        
        switch status {
        case .notDetermined: isAuthorized = false
        case .sharingDenied: isAuthorized = false
        case .sharingAuthorized:
            DispatchQueue.main.async {
                self.isAuthorized = true
            }
        @unknown default: isAuthorized = false
        }
    }
    
    private func readStepsTakenToday() {
        healthKitManager.readStepCount(forToday: Date(), healthStore: healthStore) { step in
            if step != 0.0 {
                DispatchQueue.main.async {
                    self.userStepCount = String(format: "%.0f", step)
                }
            }
        }
    }
}
