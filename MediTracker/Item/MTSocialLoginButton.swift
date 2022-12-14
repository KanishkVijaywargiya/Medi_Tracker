//
//  MTSocialLoginButtons.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 14/12/22.
//

import SwiftUI

struct MTSocialLoginButton: View {
    var action: () -> ()
    var imageName: String
    var imageCheck: Bool = false
    
    var body: some View {
        Button {action()} label: {
            if imageCheck {
                Image(systemName: imageName)
                    .resizable()
                    .foregroundColor(.primary)
                    .scaledToFit()
                    .frame(width: 22, height: 22)
            } else {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 22, height: 22)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black.opacity(0.1), lineWidth: 1.9)
                .blendMode(.normal)
                .opacity(0.7)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 2, y: 2)
        .background(Color.white)
    }
}

struct MTSocialLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        MTSocialLoginButton(action: {}, imageName: "apple.logo", imageCheck: true)
    }
}
