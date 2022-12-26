//
//  ProfileImage.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 23/12/22.
//

import SwiftUI

struct ProfileImage: View {
    @Binding var imageSelected: UIImage
    
    var body: some View {
        if imageSelected == UIImage() {
            Image(systemName: "person.fill")
                .font(.system(size: 250))
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(16)
                .overlay {
                    RoundedRectangle(cornerRadius: 16).stroke(Color.black.opacity(0.3), lineWidth: 1)
                }
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        } else {
            Image(uiImage: imageSelected)
                .resizable()
                .frame(width: 250, height: 250)
                .scaledToFill()
                .background(Color.white)
                .cornerRadius(16)
                .overlay {
                    RoundedRectangle(cornerRadius: 16).stroke(Color.black.opacity(0.3), lineWidth: 1)
                }
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(imageSelected: .constant(UIImage()))
    }
}
