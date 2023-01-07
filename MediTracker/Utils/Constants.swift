//
//  Constants.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 21/12/22.
//

import SwiftUI

struct K {
    struct BrandColors {
        static let pink = "AppPrimary"
        static let black = "Black"
        
        // MARK: Other color shades
        static let codeRed = "codeRed"
        
        static let darkBlue = "DarkBlue"
        static let pastelBlue = "PastelBlue"
        static let pastelBlue2 = "PastelBlue2"
        static let pastelBlue3 = "PastelBlue3"
        static let pastelBlue4 = "PastelBlue4"
        static let codeEng = "codeEnglish"
        
        static let pastelGreen = "PastelGreen"
        static let pastelGreen2 = "PastelGreen2"
        static let pastelGreen3 = "PastelGreen3"
        static let codeGreen = "codeGreen"
        
        static let pastelOrange = "PastelOrange"
        static let codeOrange = "codeOrange"
        
        static let pastelPink = "pastelPink"
        static let pastelPink2 = "PastelPink2"
        static let codePink = "codePink"
        
        static let pastelPurple = "PastelPurple"
        static let codePurple = "codePurple"
        
        static let pastelYellow = "PastelYellow"
        static let codeBrown = "codeBrown"
    }
    
    struct SFSymbols {
        // MARK: Login Screen
        static let arrowTriangleDownFill = "arrowtriangle.down.fill"
        static let ellipsis = "ellipsis"
        static let appleLogin = "apple.logo"
        
        // MARK: List of Countries Screen
        static let chevronDown = "chevron.down"
        
        // MARK: Localization Glass Button
        static let characBubble = "character.bubble"
        static let characBubbleFill = "character.bubble.fill.ja"
        static let globe = "globe"
        static let chevBack = "chevron.backward"
        
        // MARK: Localization Language Card
        static let larFillCircle = "largecircle.fill.circle"
        static let circle = "circle"
    }
    
    struct AppImg {
        static let appLogo = "a"
        static let bgLoginImg = "bglogin"
        static let googleLogin = "g"
        
        // MARK: Splash Screen
        static let splashimg = "splashimg"
        static let lottieFile = "HeartLottie"
        static let appTitle = "Medi Tracker"
    }
    
    struct LocalizedKey {
        // MARK: Login Screen
        static let MED_TRACKER_APP = "MED_TRACKER_APP"
        static let Enter_MOB_NUM = "Enter_MOB_NUM"
        static let CONTINUE = "CONTINUE"
        static let CONTINUING_AGREE = "CONTINUING_AGREE"
        static let TERMS_SERVICES = "TERMS_SERVICES"
        static let PRIVACY_POLICY = "PRIVACY_POLICY"
        static let CONTENT_POLICIES = "CONTENT_POLICIES"
        static let NO_CONNECTION = "NO_CONNECTION"
        static let OR = "OR"
        static let LOGIN_SIGNUP = "LOGIN_SIGNUP"
        
        // MARK: Verification Screen
        static let VERIFICATION_CODE = "VERIFICATION_CODE"
        static let OTP_LIMIT = "OTP_LIMIT"
        static let OTP_VERIFY = "OTP_VERIFY"
        static let SMS_RESEND = "SMS_RESEND"
        static let OTHER_LOGIN = "OTHER_LOGIN"
        
        // MARK: List of Countries Screen
        static let SEARCH = "SEARCH"
        static let COUNTRIES_LIST = "COUNTRIES_LIST"
        
        // MARK: Localization Language Sheet
        static let SELECT_LANG = "SELECT_LANG"
        
        // MARK: OTP ViewModel
        static let VALID_NUM = "VALID_NUM"
        static let VERIFICATION = "VERIFICATION"
        static let SOMETHING_WRONG = "SOMETHING_WRONG"
    }
    
    struct NavigationTag {
        static let verification = "VERIFICATION"
    }
    
    //general
    static let bloodType = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
    static let gender = ["Male", "Female", "Other"]
    
}
