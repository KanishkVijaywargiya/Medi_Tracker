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
        static let chevLeft = "chevron.left"
        static let chevRight = "chevron.right"
        static let chevDown = "chevron.down"
        static let chevBack = "chevron.backward"
        static let arrowTriangleDownFill = "arrowtriangle.down.fill"
        static let ellipsis = "ellipsis"
        static let appleLogin = "apple.logo"
        static let characBubble = "character.bubble"
        static let characBubbleFill = "character.bubble.fill.ja"
        static let globe = "globe"
        static let larFillCircle = "largecircle.fill.circle"
        static let circle = "circle"
        static let plus = "plus"
        static let calendar = "calendar"
        static let clock = "clock"
        static let person_fill = "person.fill"
        static let pencil = "pencil"
        static let allergyFill = "allergens.fill"
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
        
        // MARK: Calendar view
        static let TODAY = "TODAY"
        static let ADD_TASK = "ADD_TASK"
        
        // MARK: Add appointment view
        static let NEW_APPOINTMENT = "NEW_APPOINTMENT"
        static let HOSPITAL_NAME = "HOSPITAL_NAME"
        static let ENTER_HOS_NAME = "ENTER_HOS_NAME"
        static let DOC_NAME = "DOC_NAME"
        static let ENTER_DOC_NAME = "ENTER_DOC_NAME"
        static let DATES = "DATES"
        static let DESCRIPTION = "DESCRIPTION"
        static let YOUR_APPOINTMENT = "YOUR_APPOINTMENT"
        static let DEPARTMENT = "DEPARTMENT"
        static let CREATE_APPOINTMENT = "CREATE_APPOINTMENT"
        
        // MARK: Home view
        static let GOOD_MOR = "GOOD_MOR"
        static let GOOD_AFTER = "GOOD_AFTER"
        static let GOOD_EVE = "GOOD_EVE"
        static let MEDICA = "MEDICA"
        static let D_ACTIVITY = "D_ACTIVITY"
        
        // MARK: Profile view
        static let WAT_OPEN = "WAT_U_WANT_TO_OPEN"
        static let CAMERA = "CAMERA"
        static let GALLERY = "GALLERY"
        static let CANCEL = "CANCEL"
        static let ENTER_NAME = "ENTER_NAME"
        static let CONTACT_NUM = "CONTACT_NUM"
        static let DOB = "DOB"
        static let WEIGHT = "WEIGHT"
        static let ENTER_WEIGHT = "ENTER_WEIGHT"
        static let HEIGHT = "HEIGHT"
        static let ENTER_HEIGHT = "ENTER_HEIGHT"
        static let GENDER = "GENDER"
        static let BLOOD_TYPE = "BLOOD_TYPE"
        static let WHEEL_CHAIR = "WHEEL_CHAIR"
        static let ORGAN_DONAR = "ORGAN_DONAR"
        static let YES = "YES"
        static let NO = "NO"
        static let SAVE = "SAVE"
        static let ALLERGIES = "ALLERGIES"
        static let SPREAD = "SPREAD"
        static let WE_LOVE = "WE_LOVE"
        static let SHARE = "SHARE"
        static let RATE = "RATE"
        static let SIGN_OUT = "SIGN_OUT"
        
        // MARK: ITEM - MTAppointmentCard
        static let MANAGE_CAL = "MANAGE_CAL"
        static let NO_SCHEDULE = "NO_SCHEDULE"
        static let YOUR_APPOINT = "YOUR_APPOINT"
        
    }
    
    struct NavigationTag {
        static let verification = "VERIFICATION"
    }
    
    struct DateSymb {
        static let DAY = "EE"
        static let DATE = "dd"
        static let TIME = "hh:mm a"
        static let HR_AM_PM = "h a"
        static let MON_YR = "MMM YYYY"
        static let DAY_DATE_MON = "EEEE dd MMMM"
    }
    
    //general
    static let bloodType = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
    static let gender = ["Male", "Female", "Other"]
    static let medicineForm = ["Tablets", "Capsules", "Syrups", "Inhalers", "Ointments", "Patches"]
    static let howToUse = ["Before Breakfast", "After Breakfast", "Before Lunch", "After Lunch", "Before Dinner", "After Dinner", "Without eating"]
    
}
