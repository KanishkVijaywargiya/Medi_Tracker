//
//  AddAppointmentView.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 07/01/23.
//

import SwiftUI

struct AddAppointmentView: View {
    var onAdd: (AppointmentModel) -> () /// - Callback
    @Environment(\.dismiss) private var dismissMode
    
    @State private var hospitalName: String = ""
    @State private var doctorName: String = ""
    @State private var description: String = ""
    @State private var dateAdded: Date = .init()
    @State private var departmentName: Department = .cardio
    
    //category animation properties
    @State private var animateColor: Color = Department.cardio.color
    @State private var animate: Bool = false
    
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .leading, spacing: 10) {
                Button {
                    dismissMode()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
                }

                Text("Create New Appointment")
                    .customFont(28, weight: .light)
                    .foregroundColor(.white)
                    .padding(.vertical, 15)

                TitleView("Hospital name")
                TextField("Enter your hospital name", text: $hospitalName)
                    .customFont(16, weight: .regular)
                    .tint(.white)
                    .padding(.top, 2)

                Rectangle()
                    .fill(.white.opacity(0.7))
                    .frame(height: 1)

                TitleView("Doctor name").padding(.top, 2)
                TextField("Enter your doctor's name", text: $doctorName)
                    .customFont(16, weight: .regular)
                    .tint(.white)
                    .padding(.top, 2)

                Rectangle()
                    .fill(.white.opacity(0.7))
                    .frame(height: 1)

                TitleView("Date").padding(.top, 15)

                HStack (alignment: .bottom, spacing: 12) {
                    dateText

                    timeText
                }
                .padding(.bottom, 15)
            }
            .hAlign(.leading)
            .padding(15)
            .background {
                ZStack {
                    departmentName.color

                    //use to pop out new color from bottom trailing as a scalling effect
                    GeometryReader {
                        let size = $0.size
                        Rectangle()
                            .fill(animateColor)
                            .mask {
                                Circle()
                            }
                            .frame(width: animate ? size.width * 2 : 0, height: animate ? size.height * 2 : 0)
                            .offset(animate ? CGSize(width: -size.width / 2, height: -size.height / 2) : size)
                    }.clipped()
                }.ignoresSafeArea()
            }

            VStack (alignment: .leading, spacing: 10) {
                TitleView("Description".uppercased(), .gray)

                TextField("About your appointment", text: $description, axis: .vertical)
                    .customFont(16, weight: .regular)
                    .padding(.top, 2)
                    .lineLimit(5)

                Rectangle()
                    .fill(.black.opacity(0.2))
                    .frame(height: 1)

                TitleView("Department".uppercased(), .gray)
                    .padding(.top, 15)

                gridView //grid view for departments

                createAppointmentButton // create appointment

            }.padding(15)
        }
        .vAlign(.top)
    }
}

struct AddAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddAppointmentView { appointments in
        }
    }
}

extension AddAppointmentView {
    private func TitleView(_ value: String, _ color: Color = .white.opacity(0.7)) -> some View {
        Text(value).customFont(12, weight: .regular)
            .foregroundColor(color)
    }
    
    private var dateText: some View {
        HStack (spacing: 12) {
            Text(dateAdded.toString("EEEE dd MMMM")).customFont(16, weight: .regular)
            
            // MARK: Custom Date Picker
            Image(systemName: "calendar")
                .font(.title3)
                .foregroundColor(.white)
                .overlay {
                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                        .blendMode(.destinationOver)//we didn't used opacity 0 as it will hide the view but blend mode will not
                }
        }
        .offset(y: -5)
        .overlay (alignment: .bottom) {
            Rectangle()
                .fill(.white.opacity(0.7))
                .frame(height: 1)
                .offset(y: 5)
        }
    }
    
    private var timeText: some View {
        HStack (spacing: 12) {
            Text(dateAdded.toString("hh:mm a")).customFont(16, weight: .regular)
            
            // MARK: Custom Date Picker
            Image(systemName: "clock")
                .font(.title3)
                .foregroundColor(.white)
                .overlay {
                    DatePicker("", selection: $dateAdded, displayedComponents: [.hourAndMinute])
                        .blendMode(.destinationOver)//we didn't used opacity 0 as it will hide the view but blend mode will not
                }
        }
        .offset(y: -5)
        .overlay (alignment: .bottom) {
            Rectangle()
                .fill(.white.opacity(0.7))
                .frame(height: 1)
                .offset(y: 5)
        }
    }
    
    private var gridView: some View {
        ScrollView (showsIndicators: false) {
            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 2), spacing: 15) {
                ForEach(Department.allCases, id: \.rawValue) { department in
                    Text(department.description.uppercased())
                        .customFont(12, weight: .bold)
                        .hAlign(.center)
                        .padding(.vertical, 10)
                        .background {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(department.color.opacity(0.25))
                        }
                        .foregroundColor(department.color)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            guard !animate else { return }//avoid simultaneous tapping
                            animateColor = department.color
                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1, blendDuration: 1)) {
                                animate = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                animate = false
                                departmentName = department
                            }
                        }
                }
            }
            .padding(.top, 5)
        }.frame(height: 200)
    }
    
    private var createAppointmentButton: some View {
        Button {
            let appointment = AppointmentModel(dateAdded: dateAdded, hospitalName: hospitalName, doctorName: doctorName, description: description, departmentName: departmentName)
            onAdd(appointment)
            dismissMode()
        } label: {
            Text("Create Appointment")
                .customFont(16, weight: .regular)
                .foregroundColor(.white)
                .padding(.vertical, 15)
                .hAlign(.center)
                .background { Capsule().fill(animateColor.gradient) }
        }
        .padding(.top, 20)
        .vAlign(.bottom)
        .disabled(
            animate || hospitalName == "" || doctorName == "" || departmentName.rawValue == ""
        )
        .opacity(
            (hospitalName == "" || doctorName == "" || departmentName.rawValue == "")
            ? 0.6 : 1
        )
    }
}
