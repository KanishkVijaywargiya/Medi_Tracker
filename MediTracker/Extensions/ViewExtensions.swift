//
//  ViewExtensions.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 07/01/23.
//

import Foundation
import SwiftUI

extension View {
    func customFont(_ size: CGFloat, weight: CustomFont) -> some View {
        self
            .font(.custom("", size: size)) //write the name of custom font
            .fontWeight(weight.weight)
    }//used for font extension
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }//used for rounded corner radius
    
    func hAlign(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }//horizontal spacer
    
    func vAlign(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }//vertical spacer
}
