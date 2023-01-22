//
//  Verification.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 11/12/22.
//

import SwiftUI

struct Verification: View {
    @Environment(\.dismiss) private var dismissMode //use to close screen
    @EnvironmentObject var vm: OTPViewModel //otp view model
    //    @FocusState var activeField: OTPField? // focus state for TextField
    
    @State private var timeRemaining = 20 //otp resend timer state
    @State private var showTimer: Bool = true //otp resend timer state
    @State private var count: Int = 0 //otp resend timer state
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @StateObject private var profileVM = ProfileViewModel() //fetch/check of data
    
    var mobileNum: String //mobile num
    var countryCode: String //country code
    
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language //localization
    
    @State private var otpText: String = "" //new
    @FocusState private var isKeyboardShowing: Bool //new
    
    var body: some View {
        VStack {
            title
            otpFields
            verifyOTPButton
            
            if count == 2 { limitOTPText } else { resendButton }
            otherLoginMethods
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle(K.NavigationTag.verification.localized(language_choosen))
        .onReceive(timer) { _ in
            if timeRemaining > 1 {
                timeRemaining -= 1
            } else if timeRemaining == 1 {
                showTimer = false
            }
        }//resend otp button timer
        .onChange(of: otpText) { newValue in
            if newValue.count == 6 {
                vm.otpValue = newValue
            }
        }//verify otp
        .onChange(of: profileVM.checkDataExists) { _ in
            profileVM.checkFirestoreData()
            profileVM.fetchUserData()
        }//check firestore data & fetch user
        .showToast(title: vm.verificationAlertTitle, isPresented: $vm.verificationAlert, color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), duration: 5, alignment: .top, toastType: .offsetToast, image: Image(K.AppImg.appLogo))
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    vm.otpValue = otpText
                    isKeyboardShowing.toggle()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
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
    
    private var limitOTPText: some View {
        Text(K.LocalizedKey.OTP_LIMIT.localized(language_choosen))
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.all, 20)
    }
    
    private var verifyOTPButton: some View {
        ZStack(alignment: .center) {
            MTButton(action: {
                vm.otpValue = otpText
            }, title: vm.isLoading ? "" : K.LocalizedKey.OTP_VERIFY.localized(language_choosen), hexCode: K.BrandColors.pink)
            if vm.isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }.frame(height: 52)
            }
        }
        .padding(.top, 10)
        .disableWithOpacity(otpText.count < 6)
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
}


//new
extension Verification {
    private var otpFields: some View {
        HStack (spacing: 0) {
            ForEach(0..<6, id: \.self) { index in
                OTPTextBox(index)
            }
        }
        .background {
            TextField("", text: $otpText.limit(6)) //add limit
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
            /// - hiding it out
                .frame(width: 1, height: 1)
                .opacity(0.001)
                .blendMode(.screen)
                .focused($isKeyboardShowing)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isKeyboardShowing.toggle()
        }
        .padding(.bottom, 20)
        .padding(.top, 10)
    }
    
    /// - OTP Text Boxes
    @ViewBuilder
    func OTPTextBox(_ index: Int) -> some View {
        ZStack {
            // Safe check
            if otpText.count > index {
                /// - Finding char at index
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
            } else {
                Text(" ")
            }
        }
        .frame(width: 45, height: 45)
        .background {
            /// - Highlighting the current text box
            let status = (isKeyboardShowing && otpText.count == index)
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(status ? Color(K.BrandColors.pink) : .gray, lineWidth: status ? 1 : 0.5)
                .animation(.easeInOut(duration: 0.2), value: status)
        }
        .frame(maxWidth: .infinity)
    }
}
