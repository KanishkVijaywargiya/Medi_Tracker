//
//  AppointmentCoreDataVM.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 13/01/23.
//

import CoreData
import SwiftUI

class AppointmentCoreDataVM: ObservableObject {
    let container: NSPersistentContainer
    @Published var appointmentEntities: [AppointmentEntity] = []
    @Published var isLoading: Bool = false
    
    init() {
        container = NSPersistentContainer(name: "MediTrackerContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data \(error.localizedDescription) ⚠️")
                return
            } else {
                print("Successfully loaded core data!✅")
            }
        }
        
        fetchAppointments()
        
        let timer = Timer.scheduledTimer(withTimeInterval: 86400, repeats: true) { _ in
            self.clearData()
        }
        timer.fire()
    }
    
    private func clearData() {
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppointmentEntity")
        fetchRequest.predicate = NSPredicate(format: "dateAdded < %@", sevenDaysAgo as NSDate)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(batchDeleteRequest)
        } catch {
            print(error)
        }
    }
    
    private func fetchAppointments() {
        let request = NSFetchRequest<AppointmentEntity>(entityName: "AppointmentEntity")
        do {
            appointmentEntities = try container.viewContext.fetch(request)
            print("appointmentEntities", appointmentEntities)
            isLoading = false
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    func addAppointments(appointment: AppointmentModel) {
        isLoading = true
        let newAppointment = AppointmentEntity(context: container.viewContext)
        newAppointment.doctorName = appointment.doctorName
        newAppointment.hospitalName = appointment.hospitalName
        newAppointment.dateAdded = appointment.dateAdded
        newAppointment.descriptions = appointment.descriptions
        newAppointment.departmentName = appointment.departmentName.rawValue
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchAppointments()
        } catch let error {
            print("Error Saving!⚠️ \(error.localizedDescription)")
            isLoading = false
        }
    }
}
