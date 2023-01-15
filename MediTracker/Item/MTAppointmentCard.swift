//
//  AppointmentCard.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 23/12/22.
//

import SwiftUI

struct MTAppointmentCard: View {
    var day: String
    var date: String
    var time: String
    var doctorName: String
    var department: String
    var check: Bool = false
    
    var body: some View {
        if check {
            HStack (alignment: .center, spacing: 20) {
                leftSection
                
                // right section
                VStack (alignment: .leading, spacing: 10) {
                    appointmentText
                    
                    Text(time)
                        .customFont(16, weight: .bold)
                        .foregroundColor(.white)
                    
                    VStack (alignment: .leading, spacing: 2) {
                        Text("Dr. \(doctorName)")
                            .font(.body.bold())
                            .foregroundColor(.white)
                        Text(department)
                            .font(.caption.bold())
                            .foregroundColor(.white)
                    }
                }//text, time, doc & depart name
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(30)
            .background(Color(K.BrandColors.pink).gradient)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            .shadow(color: Color.pink.opacity(0.3), radius: 10, x: 0, y: 10)
            .padding(.horizontal)
        } else {
            HStack (alignment: .center, spacing: 20) {
                leftSection
                
                // right section
                VStack (alignment: .leading, spacing: 10) {
                    VStack (alignment: .leading, spacing: 2) {
                        appointmentText
                        Text("Manage your Calendar")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }//upper part
                    
                    Text("No Upcoming Schedules")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
//                    HStack (alignment: .center, spacing: 2) {
//                        Text("No Upcoming Schedules")
//                            .font(.caption.bold())
//                            .foregroundColor(.white)
//                            .multilineTextAlignment(.leading)
//                        Spacer()
//
//                        VStack {
//                            Text(time)
//                                .padding(5)
////                                .font(.footnote)
//                                .customFont(12, weight: .medium)
//                                .foregroundColor(.secondary)
//                        }
//                        .background(.white.gradient)
//                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
//                    } //nxt appointment with time
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
}

struct MTAppointmentCard_Previews: PreviewProvider {
    static var previews: some View {
        MTAppointmentCard(day: Date().toString("EE"), date: Date().toString("dd"), time: Date().toString("hh:mm a"), doctorName: "Dr. Lawrence Leiter", department: "General Surgeon")
    }
}

extension MTAppointmentCard {
    private var leftSection: some View {
        VStack (alignment: .center, spacing: 8) {
            Text(day)
                .customFont(16, weight: .regular)
                .foregroundColor(.secondary)
            Rectangle()
                .frame(width: 20, height: 1)
                .foregroundColor(.black.opacity(0.2))
            Text(date)
                .customFont(20, weight: .bold)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
    
    private var appointmentText: some View {
        HStack (alignment: .center) {
            Text("Your appointments")
                .font(.title2.bold())
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
        }
    }
}
