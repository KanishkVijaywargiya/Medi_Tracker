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
            Image("splashimg")
                .resizable()
                .scaledToFill()
            
            LottieView(lottieFile: "HeartLottie")
                .frame(width: 200, height: 200)
            
            Text("Medi Tracker")
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
