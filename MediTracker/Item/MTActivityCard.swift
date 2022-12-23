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
    
    var body: some View {
        VStack (alignment: .center, spacing: 10) {
            HStack (alignment: .top, spacing: 20) {
                VStack (alignment: .leading, spacing: 8) {
                    Text(title)
                        .foregroundColor(.white)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Text(data)
                        .foregroundColor(.white)
                        .font(.title2.bold())
                }
                Image(systemName: iconName)
                    .font(.title.bold())
                    .foregroundColor(.purple.opacity(0.5))
            }
            // need to replace with actual bar chart
            Image(systemName: chartBar)
                .font(.system(size: 45, weight: .bold))
                .foregroundColor(.purple.opacity(0.5))
        }
        .padding()
        .background(Color(K.BrandColors.pastelPurple))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct MTActivityCard_Previews: PreviewProvider {
    static var previews: some View {
        MTActivityCard(title: "Steps", data: "3,456", iconName: "figure.step.training", chartBar: "chart.bar")
    }
}
