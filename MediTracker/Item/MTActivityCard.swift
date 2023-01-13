//
//  MTActivityCard.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 23/12/22.
//

import SwiftUI

struct MTActivityCard: View {
    var title: String
    var data: String
    var iconName: String
    var chartBar: String
    var color: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(color.gradient)
                .frame(width: 170, height: 170)
            
            VStack (alignment: .center, spacing: 40) {
                HStack (alignment: .top, spacing: 40) {
                    VStack (alignment: .leading, spacing: 10) {
                        Text(title)
                            .font(.system(size: 22)).fontWeight(.medium)
                        Text(data)
                            .font(.body).fontWeight(.medium)
                            .foregroundColor(.secondary)
                    }
                    Image(systemName: iconName)
                        .font(.title.bold())
                        .foregroundColor(.purple.opacity(0.5))
                }
                Image(systemName: chartBar)
                    .font(.system(size: 45, weight: .bold))
                    .foregroundColor(.purple.opacity(0.5))
            }
        }.clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct MTActivityCard_Previews: PreviewProvider {
    static var previews: some View {
        MTActivityCard(title: "Steps", data: "3,456", iconName: "figure.step.training", chartBar: "chart.bar", color: Color(K.BrandColors.pastelPurple))
    }
}
