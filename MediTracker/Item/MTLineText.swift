//
//  MTLineText.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 14/12/22.
//

import SwiftUI

struct MTLineText: View {
    var title: String
    var opacityVal: Double
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black.opacity(opacityVal))
            
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.secondary)
                .padding()
                .background(Color.white)
        }
    }
}

struct MTLineText_Previews: PreviewProvider {
    static var previews: some View {
        MTLineText(title: "Log in or sign up", opacityVal: 0.3)
    }
}
