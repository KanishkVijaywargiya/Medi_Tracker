//
//  GlassButton.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 14/12/22.
//

import SwiftUI

struct GlassButton: View {
    var iconName: String = "chevron.backward"
    var iconSize: CGFloat = 12
    
    var body: some View {
        Image(systemName: iconName)
            .font(.system(size: iconSize, weight: .bold))
            .foregroundColor(.white)
            .padding(.all, 8)
            .padding([.leading, .trailing], 3)
            .background(BlurView(style: .systemMaterialDark))
            .mask(Capsule())
    }
}

struct GlassButton_Previews: PreviewProvider {
    static var previews: some View {
        GlassButton()
    }
}
