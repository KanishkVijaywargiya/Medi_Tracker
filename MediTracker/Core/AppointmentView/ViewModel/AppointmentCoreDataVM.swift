//
//  AppointmentCoreDataVM.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 13/01/23.
//

import UserNotifications
import CoreData
import SwiftUI

class AppointmentCoreDataVM: ObservableObject {
    let container: NSPersistentContainer
    @Published var appointmentEntities: [AppointmentEntity] = []
    @Published var appointmentItem: [AppointmentEntity] = []// using for filtering of items for current day
    @Published var isLoading: Bool = false
    
    init() {
        container = NSPersistentContainer(name: "MediTrackerContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data \(error.localizedDescription) ⚠️")
                return
            } else {
                print("Successfully loaded appointment core data!✅")
            }
        }
        
        fetchAppointments()
        
        //MARK: timer for clearing core data things
        let timer = Timer.scheduledTimer(withTimeInterval: 86400, repeats: true) { _ in
            self.clearData()
        }
        timer.fire()
        
        //MARK: request authorization for local notifications
        requestAuthorization()
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
    } // for clearing previous data from core data from device after 7 days
    
    private func fetchAppointments() {
        let request = NSFetchRequest<AppointmentEntity>(entityName: "AppointmentEntity")
        do {
            appointmentEntities = try container.viewContext.fetch(request)
            isLoading = false
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
            isLoading = false
        }
    }// fetching data from Core data
    
    func addAppointments(_ appointment: AppointmentModel) {
        isLoading = true
        let newAppointment = AppointmentEntity(context: container.viewContext)
        newAppointment.id = UUID()
        newAppointment.doctorName = appointment.doctorName
        newAppointment.hospitalName = appointment.hospitalName
        newAppointment.dateAdded = appointment.dateAdded
        newAppointment.descriptions = appointment.descriptions
        newAppointment.departmentName = appointment.departmentName.rawValue
        saveData(appointment)
    }// adding appointments to core data
    
    private func saveData(_ appointment: AppointmentModel) {
        do {
            try container.viewContext.save()
            fetchAppointments()
            scheduleNotification(appointment)
        } catch let error {
            print("Error Saving!⚠️ \(error.localizedDescription)")
            isLoading = false
        }
    }// saving data to core data
    
    private func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error.localizedDescription) ⚠️")
            } else {
                print("Success")
            }
        }
    }// authorizing users for local notifications
    
    private func scheduleNotification(_ appointment: AppointmentModel) {
        let content = UNMutableNotificationContent()
        content.title = "Appointment Reminder"
        content.subtitle = "\(appointment.dateAdded.toString("EE/dd/MM")) - \(appointment.dateAdded.toString("hh:mm a"))"
        content.body = "Don't forget your appointment with Dr. \(appointment.doctorName) at \(appointment.hospitalName) today!"
        content.sound = .default
        content.badge = 1
        
        //calendar - 15 mins prior to schedu
        let reminderDate = Calendar.current.date(byAdding: .minute, value: -15, to: appointment.dateAdded)!
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }// scheduling the notification for users
    
    func filterLatestData() {
        if appointmentEntities.count > 0 {
            let todaysAppointmentArray = appointmentEntities.filter {
                $0.dateAdded?.toString("dd hh") ?? Date().toString("dd hh") >= Date().toString("dd hh")
            }
            guard todaysAppointmentArray.count > 0 else { return }
            appointmentItem = todaysAppointmentArray
        }
    }//use to filter the appointment items
}
