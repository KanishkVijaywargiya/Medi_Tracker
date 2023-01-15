//
//  Verification.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 11/12/22.
//

import SwiftUI

enum OTPField {
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}// MARK: focus state enum for otp text fields

struct Verification: View {
    @Environment(\.dismiss) private var dismissMode //use to close screen
    @EnvironmentObject var vm: OTPViewModel //otp view model
    @FocusState var activeField: OTPField? // focus state for TextField
    
    @State private var timeRemaining = 20 //otp resend timer state
    @State private var showTimer: Bool = true //otp resend timer state
    @State private var count: Int = 0 //otp resend timer state
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @StateObject private var profileVM = ProfileViewModel() //fetch/check of data
    
    var mobileNum: String //mobile num
    var countryCode: String //country code
    
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language //localization
    
    var body: some View {
        VStack {
            title
            otpFields
            
            if !checkStates() { verifyOTPButton.padding(.top) }
            
            if count == 2 { limitOTPText } else { resendButton }
            otherLoginMethods
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle(K.NavigationTag.verification.localized(language_choosen))
        .onChange(of: vm.otpFields) { newValue in
            otpCondition(value: newValue)
        }//otp condition
        .onReceive(timer) { _ in
            if timeRemaining > 1 {
                timeRemaining -= 1
            } else if timeRemaining == 1 {
                showTimer = false
            }
        }//resend otp button timer
        .onChange(of: vm.otpText) { newValue in
            if newValue.count == 6 {
                Task{
                    await vm.verifyOTP(countryCode: countryCode)
                    //await profileVM.fetchUserData()
                }
            }
        }//verify otp
        .onChange(of: profileVM.checkDataExists) { _ in
            profileVM.checkFirestoreData()
            profileVM.fetchUserData()
        }//check firestore data & fetch user
        .showToast(title: vm.verificationAlertTitle, isPresented: $vm.verificationAlert, color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), duration: 5, alignment: .top, toastType: .offsetToast, image: Image(K.AppImg.appLogo))
    }
}

struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        Verification(mobileNum: "9123235319", countryCode: "91").environmentObject(OTPViewModel())
    }
}

extension Verification {
    private var title: some View {
        VStack {
            Text(K.LocalizedKey.VERIFICATION_CODE.localized(language_choosen))
            Text("\(countryCode)-\(mobileNum)").bold()
        }.padding(.bottom, 40)
    }// MARK: title with user phone number
    
    private var otpFields: some View {
        HStack(spacing: 14) {
            ForEach(0..<6, id: \.self) { item in
                VStack(spacing: 8) {
                    TextField("", text: $vm.otpFields[item])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeField, equals: activeStateForIndex(index: item))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    activeField == activeStateForIndex(index: item) ? Color(K.BrandColors.pink) : Color.black.opacity(0.1), lineWidth: 1.9)
                                .blendMode(.normal)
                                .opacity(0.7)
                                .frame(height: 40)
                        )
                }.frame(width: 40)
            }
        }
    }// MARK: OTP Fields
    
    private var limitOTPText: some View {
        Text(K.LocalizedKey.OTP_LIMIT.localized(language_choosen))
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.all, 20)
    }
    
    private var verifyOTPButton: some View {
        ZStack(alignment: .center) {
            MTButton(action: {
                Task{await vm.verifyOTP(countryCode: countryCode)}
            }, title: vm.isLoading ? "" : K.LocalizedKey.OTP_VERIFY.localized(language_choosen), hexCode: K.BrandColors.pink)
            if vm.isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }.frame(height: 52)
            }
        }.padding(.top, 10)
    }// MARK: Verify blue button
    
    private var resendButton: some View {
        Button {
            Task{await vm.sendOTP(countryCode: countryCode)}
            self.timeRemaining = 20
            self.showTimer = true
            withAnimation(.easeIn) {
                self.count += 1
            }
        } label: {
            HStack {
                Text(K.LocalizedKey.SMS_RESEND.localized(language_choosen))
                    .foregroundColor(showTimer ? .primary : Color(K.BrandColors.pink))
                if showTimer {
                    Text("in \(timeRemaining)")
                        .foregroundColor(.primary)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
        }
        .padding()
        .disabled(showTimer)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(showTimer ? Color.black.opacity(0.3) : Color(K.BrandColors.pink), lineWidth: 1)
                .blendMode(.normal)
                .opacity(0.7)
                .frame(height: 40)
        )
        .padding(.top)
    }// MARK: Resend
    
    private var otherLoginMethods: some View {
        VStack {
            Button {self.dismissMode()} label: {
                Text(K.LocalizedKey.OTHER_LOGIN.localized(language_choosen))
                    .font(.footnote.bold())
                    .foregroundColor(Color(K.BrandColors.pink))
            }
        }
    }// MARK: Other login method text
    
    // MARK: Conditions for Custom OTP Field & limiting only one text
    private func otpCondition(value: [String]) {
        for index in 0..<6 {
            if value[index].count == 6 {
                DispatchQueue.main.async {
                    vm.otpText = value[index]
                    vm.otpFields[index] = ""
                    
                    //updating all text fields with value
                    for item in vm.otpText.enumerated() {
                        vm.otpFields[item.offset] = String(item.element)
                    }
                }
                return
            }
        }//checking if otp is pressed
        
        for index in 0..<5 {
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField {
                activeField = activeStateForIndex(index: index + 1)
            }
        }//moving to next field if current field is filled
        
        for index in 1...5 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activeStateForIndex(index: index - 1)
            }
        }//moving backward if current field is empty & previous is not
        
        for index in 0..<6 {
            if value[index].count > 1 {
                vm.otpFields[index] = String(value[index].last!)
            }
        }//limiting to only one text
    }
    
    // MARK: Switch cases for handling active state for otpFields
    private func activeStateForIndex(index: Int) -> OTPField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        case 3: return .field4
        case 4: return .field5
        default: return .field6
        }
    }
    
    // MARK: used to disable the verify OTP Button
    private func checkStates() -> Bool {
        for index in 0..<6 {
            if vm.otpFields[index].isEmpty { return true }
        }
        return false
    }
}
