//
//  PillsCoreDataVM.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 19/01/23.
//

import SwiftUI
import CoreData
import UserNotifications


class PillsCoreDataVM: ObservableObject {
    let container: NSPersistentContainer
    @Published var pillsEntity: [PillsEntity] = []
    @Published var isLoading: Bool = false
    
    init() {
        container = NSPersistentContainer(name: "MediTrackerContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data \(error.localizedDescription) ⚠️")
                return
            } else {
                print("Successfully loaded pills core data!✅")
            }
        }
        
        fetchPills()
    }
    
    private func fetchPills() {
        let request = NSFetchRequest<PillsEntity>(entityName: "PillsEntity")
        do {
            pillsEntity = try container.viewContext.fetch(request)
            isLoading = false
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    func addPills(_ pills: PillsModel) {
        isLoading = true
        let newPills = PillsEntity(context: container.viewContext)
        newPills.id = UUID()
        newPills.medicineName = pills.medicineName
        newPills.medicineForm = pills.medicineForm
        newPills.intake = pills.intake
        newPills.startDate = pills.startDate
        newPills.endDate = pills.endDate        
        saveData(pills)
    }
    
    private func saveData(_ pills: PillsModel) {
        do {
            try container.viewContext.save()
            fetchPills()
        } catch let error {
            print("Error Saving!⚠️ \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    func convertTimeToDays(_ pills: PillsEntity) -> Int {
        let interval = pills.endDate?.timeIntervalSince(pills.startDate ?? Date()) ?? 0.0
        let days = Int(interval / (60*60*24))
        if days == 0 {
            return days + 1
        } else {
            return days
        }
        //return days
    }
}
