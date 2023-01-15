//
//  CalendarView.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 07/01/23.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentDay: Date = .init()
    @State private var appointments: [AppointmentModel] = sampleAppointments
    @State private var addAppointments: Bool = false //use to open appointment view
    @State private var nameText: String = "" //name text in onReceive
    @ObservedObject var profileVM: ProfileViewModel //profile viewModel
    @ObservedObject var appointVM: AppointmentCoreDataVM //appointment core data vm
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            timeLine.padding(15)
        }
        .safeAreaInset(edge: .top, spacing: 0) { headerView }
        .fullScreenCover(isPresented: $addAppointments) {
            AddAppointmentView(vm: appointVM)
//            AddAppointmentView(onAdd: { appointment in
//                appointVM.addAppointments(appointment: appointment)
//            }, vm: appointVM)
        }
        .onReceive(profileVM.$userProfileData) { newValue in
            nameText = newValue.username
        }
        .navigationBarHidden(true)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(profileVM: ProfileViewModel(), appointVM: AppointmentCoreDataVM())
    }
}

extension CalendarView {
    private var headerView: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 6) {
                    Text("Today").customFont(30, weight: .light)
                    Text(nameText).customFont(14, weight: .light)
                }.hAlign(.leading)
                
                Button {
                    addAppointments.toggle()
                } label: {
                    HStack (spacing: 10) {
                        Image(systemName: "plus")
                        Text("Add Task").customFont(15, weight: .regular)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background { Capsule().fill(Color(K.BrandColors.pink).gradient) }
                    .foregroundColor(.white)
                }
                
            }
            Text(Date()
                .toString("MMM YYYY")).customFont(16, weight: .medium)
                .hAlign(.leading)
                .padding(.top, 15)
            
            weekRow
        }
        .padding(15)
        .background {
            VStack (spacing: 0) {
                Color.white
                
                /// - Gradient opacity background
                Rectangle()
                    .fill(.linearGradient(
                        colors: [
                            .white,
                            .clear
                        ],
                        startPoint: .top,
                        endPoint: .bottom))
                    .frame(height: 20)
            }.ignoresSafeArea()
        }
    }
    
    //week row
    private var weekRow: some View {
        HStack (spacing: 0) {
            let weeks = Calendar.current.currentWeek
            ForEach(weeks) { weekDay in
                let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                VStack (spacing: 6) {
                    Text(weekDay.string.prefix(3)).customFont(12, weight: .medium)
                    Text(weekDay.date.toString("dd")).customFont(16, weight: status ? .medium : .regular)
                }
                .foregroundColor (status ? Color(K.BrandColors.pink) : .gray)//highlight current active day
                .hAlign(.center)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentDay = weekDay.date
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, -15)
    }
    
    //time line view
    private var timeLine: some View {
        ScrollViewReader { proxy in
            let hours = Calendar.current.hours
            let midHour = hours[hours.count / 2]
            
            VStack {
                ForEach(hours, id: \.self) { hour in
                    TimeLineViewRow(hour).id(hour)
                }
            }
            .onAppear {
                proxy.scrollTo(midHour)
            }//because timeline view begins at 12:00 am, we want it to began with 12:00 PM, which is mid of day, so we use scroll view reader proxy to set it to mid day
        }
    }
    
    // time line view row
    private func TimeLineViewRow(_ date: Date) -> some View {
        HStack (alignment: .top) {
            Text(date.toString("h a"))
                .customFont(14, weight: .regular)
                .frame(width: 45, alignment: .leading)
            
            /// - Filtering appointments
            let calendar = Calendar.current
            let filteredAppointments = appointVM.appointmentEntities.filter {
                if
                    let hour = calendar.dateComponents([.hour], from: date).hour,
                    let appointmentHour = calendar
                        .dateComponents(
                            [.hour],
                            from: $0.dateAdded ?? Date()
                        ).hour,
                    hour == appointmentHour &&
                        calendar.isDate(
                            $0.dateAdded ?? Date(),
                            inSameDayAs: currentDay
                        ) {
                    return true
                }//filtering appointments based on hour & also verify whether the date is same as selected week day
                return false
            }
            
            if filteredAppointments.isEmpty {
                Rectangle().stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
                    .frame(height: 0.5)
                    .offset(y: 10)
            } else {
                /// - Appointment View
                VStack (spacing: 10) {
                    ForEach(filteredAppointments, id: \.self) { appointment in
                        AppointmentViewRow(appointment)
                    }
                }
            }
        }
        .hAlign(.leading)
        .padding(.vertical, 15)
    }
    
    // appointment view row
    private func AppointmentViewRow(_ appointment: AppointmentEntity) -> some View {
        VStack (alignment: .leading, spacing: 8) {
            Text(appointment.hospitalName ?? "")
                .customFont(18, weight: .bold)
                .foregroundColor(Department(rawValue: appointment.departmentName ?? "")?.color)
            
            Text(appointment.doctorName ?? "")
                .customFont(16, weight: .bold)
                .foregroundColor(Department(rawValue: appointment.departmentName ?? "")?.color)
            
            Text(Department(rawValue: appointment.departmentName ?? "")?.description ?? "")
                .customFont(14, weight: .bold)
                .foregroundColor(Department(rawValue: appointment.departmentName ?? "")?.color)
            
            if appointment.descriptions != "" {
                Text(appointment.descriptions ?? "").lineLimit(2)
                    .customFont(14, weight: .light)
                    .foregroundColor(Department(rawValue: appointment.departmentName ?? "")?.color)
            }
        }
        .hAlign(.leading)
        .padding(12)
        .background {
            ZStack (alignment: .leading) {
                Rectangle()
                    .fill(Department(rawValue: appointment.departmentName ?? "")?.color ?? Color(.clear))
                    .frame(width: 4)
                Rectangle()
                    .fill(Department(rawValue: appointment.departmentName ?? "")?.color.opacity(0.25) ?? Color(hex: ""))
            }
        }
        .cornerRadius(12, corners: [.topRight, .bottomRight])
    }
}
