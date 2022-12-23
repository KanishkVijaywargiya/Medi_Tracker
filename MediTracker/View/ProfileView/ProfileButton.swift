//
//  ProfileButton.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 23/12/22.
//

import SwiftUI

struct ProfileButton: View {
    @Binding var profileImg: UIImage
    
    var body: some View {
        ZStack {
            if profileImg == UIImage() {
                Image(systemName: "person.fill")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.all, 6)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay { Circle().stroke(Color.black.opacity(0.3), lineWidth: 2) }
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            } else {
                Image(uiImage: profileImg)
                    .resizable()
                    .frame(width: 38, height: 38)
                    .scaledToFill()
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay { Circle().stroke(Color.black.opacity(0.3), lineWidth: 2) }
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            }
        }
    }
}

struct ProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButton(profileImg: .constant(UIImage()))
    }
}
