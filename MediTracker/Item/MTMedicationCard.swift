//
//  MTMedicationCard.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 23/12/22.
//

import SwiftUI

struct MTMedicationCard: View {
    var iconName: String
    var medicineName: String
    
    var body: some View {
        VStack (alignment: .center, spacing: 10) {
            Image(systemName: iconName)
                .font(.title.bold())
                .foregroundColor(Color(K.BrandColors.pink))
            
            Text(medicineName)
                .foregroundColor(.secondary)
                .fontWeight(.medium)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color(K.BrandColors.pink), lineWidth: 1)
        }
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct MTMedicationCard_Previews: PreviewProvider {
    static var previews: some View {
        MTMedicationCard(iconName: "pill.fill", medicineName: "Vitamin C")
    }
}
