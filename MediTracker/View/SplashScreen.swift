//
//  SplashScreen.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 15/12/22.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(K.AppImg.splashimg)
                .resizable()
                .scaledToFill()
            
            LottieView(lottieFile: K.AppImg.lottieFile)
                .frame(width: 200, height: 200)
            
            Text(K.AppImg.appTitle)
                .font(.title2.bold())
                .foregroundColor(.primary)
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
