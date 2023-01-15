//
//  MTGlassButton.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 23/12/22.
//

import SwiftUI

struct MTGlassButton: View {
    var iconName: String = K.SFSymbols.chevBack
    var iconSize: CGFloat = 12
    var action: () -> ()
    
    var body: some View {
        Image(systemName: iconName)
            .font(.system(size: iconSize, weight: .bold))
            .foregroundColor(.white)
            .padding(.all, 10)
            .background(BlurView(style: .systemMaterialDark))
            .mask(Circle())
            .onTapGesture { action() }
    }
}

struct MTGlassButton_Previews: PreviewProvider {
    static var previews: some View {
        MTGlassButton(action: {})
    }
}
