//
//  AppointmentCard.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 23/12/22.
//

import SwiftUI
struct MTAppointmentCard: View {
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language //localize app storage
    var day: String
    var date: String
    var time: String
    var doctorName: String
    var department: String
    
    init(day: String? = Date().toString(K.DateSymb.DAY), date: String? = Date().toString(K.DateSymb.DATE), time: String? = Date().toString(K.DateSymb.TIME), doctorName: String? = "", department: String? = "") {
        self.day = day ?? Date().toString(K.DateSymb.DAY)
        self.date = date ?? Date().toString(K.DateSymb.DATE)
        self.time = time ?? Date().toString(K.DateSymb.TIME)
        self.doctorName = doctorName ?? ""
        self.department = department ?? ""
    }
    
    var body: some View {
        HStack(alignment: .top) {
            leftSection
            
            rightSection
        }
        .padding(30)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(K.BrandColors.pink).gradient)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .shadow(color: Color.pink.opacity(0.3), radius: 10, x: 0, y: 10)
    }
}
struct MTAppointmentCard_Previews: PreviewProvider {
    static var previews: some View {
        MTAppointmentCard(day: Date().toString("EE"), date: Date().toString("dd"), time: Date().toString("hh:mm a"), doctorName: "Dr. Lawrence Leiter", department: "General Surgeon")
    }
}
extension MTAppointmentCard {
    private var leftSection: some View {
        VStack {
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
    
    private var rightSection: some View {
        VStack(alignment: .leading, spacing: doctorName.isEmpty ? 20 : 5) {
            HStack(alignment: .center) {
                Text(K.LocalizedKey.YOUR_APPOINT.localized(language_choosen))
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .lineLimit(1)
                Spacer()
                Image(systemName: K.SFSymbols.chevRight)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading) {
                if !doctorName.isEmpty {
                    VStack (alignment: .leading, spacing: 2) {
                        Text(time)
                            .customFont(16, weight: .bold)
                            .foregroundColor(.white)
                            .lineLimit(1)
                        Text("Dr. \(doctorName)")
                            .font(.body.bold())
                            .foregroundColor(.white)
                            .lineLimit(1)
                        Text(department)
                            .font(.caption.bold())
                            .foregroundColor(.white)
                            .lineLimit(1)
                    }
                } else {
                    Text(K.LocalizedKey.NO_SCHEDULE.localized(language_choosen))
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                }
            }
        }
        .padding(.leading, 8)
    }
}
