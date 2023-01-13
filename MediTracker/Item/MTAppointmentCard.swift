//
//  AppointmentCard.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 23/12/22.
//

import SwiftUI

struct MTAppointmentCard: View {
    var day: String
    var date: Date = .init()
    var time: String
    var doctorName: String
    var department: String
    
    var body: some View {
        HStack (alignment: .center, spacing: 20) {
            // left section
            VStack (alignment: .center, spacing: 8) {
                Text(date.toString("EE"))
                    .customFont(16, weight: .regular)
                    .foregroundColor(.secondary)
                Rectangle()
                    .frame(width: 20, height: 1)
                    .foregroundColor(.black.opacity(0.2))
                Text(date.toString("dd"))
                    .customFont(20, weight: .bold)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            
            // right section
            VStack (alignment: .leading, spacing: 10) {
                HStack (alignment: .center) {
                    Text("Your appointments")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                
                VStack (alignment: .leading, spacing: 2) {
                    Text(doctorName)
//                        .font(.body.bold())
                        .customFont(16, weight: .bold)
                        .foregroundColor(.white)
                    Text(department)
                        .font(.caption.bold())
                        .foregroundColor(.white)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(30)
        .background(Color(K.BrandColors.pink).gradient)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .shadow(color: Color.pink.opacity(0.3), radius: 10, x: 0, y: 10)
        .padding(.horizontal)
    }
}

struct MTAppointmentCard_Previews: PreviewProvider {
    static var previews: some View {
        MTAppointmentCard(day: "Tue", time: "10:00 am - 11:00 am", doctorName: "Dr. Lawrence Leiter", department: "General Surgeon")
    }
}

/*
 // MARK: Appointment Card
 HStack (alignment: .center, spacing: 20) {
 // left section
 Image(systemName: "calendar")
 .font(.system(size: 60).bold()).foregroundColor(.white)
 
 // right section
 VStack (alignment: .leading, spacing: 10) {
 Text("Appointments")
 .font(.title2.bold())
 .foregroundColor(.white)
 Text("Manage your Calendar")
 .font(.footnote)
 .foregroundColor(.white)
 
 HStack (alignment: .center, spacing: 2) {
 Text("Next Appointment")
 .font(.caption.bold())
 .foregroundColor(.white)
 Spacer()
 VStack {
 Text(date.toString("EE/dd/MM"))
 .padding(5)
 .customFont(14, weight: .medium)
 .foregroundColor(.secondary)
 }
 .background(.white.gradient)
 .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
 }
 }
 }
 .frame(maxWidth: .infinity, alignment: .leading)
 .padding(30)
 .background(Color(K.BrandColors.pink))
 .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
 .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
 .shadow(color: Color.pink.opacity(0.3), radius: 10, x: 0, y: 10)
 .padding(.horizontal)
 */
