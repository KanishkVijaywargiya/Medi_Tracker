//
//  MTGlassButton.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 23/12/22.
//

import SwiftUI

struct MTGlassButton: View {
    var iconName: String = "chevron.backward"
    var iconSize: CGFloat = 12
    
    var body: some View {
        Image(systemName: iconName)
            .font(.system(size: iconSize, weight: .bold))
            .foregroundColor(.white)
            .padding(.all, 10)
            .background(BlurView(style: .systemMaterialDark))
            .mask(Circle())
    }
}

struct MTGlassButton_Previews: PreviewProvider {
    static var previews: some View {
        MTGlassButton()
    }
}