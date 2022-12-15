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
    @Environment(\.dismiss) private var dismissMode
    @EnvironmentObject var vm: OTPViewModel
    @FocusState var activeField: OTPField? // MARK: TextField FocusState
    
    // MARK: timer variables to activate resend button
    @State private var timeRemaining = 5
    @State private var showTimer: Bool = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var count: Int = 0
    
    // MARK: Mobile num with country code in title
    var mobileNum: String
    var countryCode: String
    
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
        .navigationTitle("Verification")
        .onChange(of: vm.otpFields) { newValue in
            otpCondition(value: newValue)
        }
        .onReceive(timer) { _ in
            if timeRemaining > 1 {
                timeRemaining -= 1
            } else if timeRemaining == 1 {
                showTimer = false
            }
        }
        .onChange(of: vm.otpText) { newValue in
            print(newValue)
            if newValue.count == 6 {
                Task{await vm.verifyOTP()}
            }
        }
        .showToast(title: vm.verificationAlertTitle, isPresented: $vm.verificationAlert, color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), duration: 5, alignment: .top, toastType: .offsetToast, image: Image("a"))
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
            Text("We have sent a verification code to")
            Text("+\(countryCode)-\(mobileNum)").bold()
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
                                    activeField == activeStateForIndex(index: item) ? Color(hex: "#E6425E") : Color.black.opacity(0.1), lineWidth: 1.9)
                                .blendMode(.normal)
                                .opacity(0.7)
                                .frame(height: 40)
                        )
                }.frame(width: 40)
            }
        }
    }// MARK: OTP Fields
    
    private var limitOTPText: some View {
        Text("OTP limit exceeded, please try again after some time!")
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.all, 20)
    }
    
    private var verifyOTPButton: some View {
        ZStack(alignment: .center) {
            MTButton(action: {
                Task{await vm.verifyOTP()}
            }, title: vm.isLoading ? "" : "Verify OTP", hexCode: "#E6425E")
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
            self.timeRemaining = 5
            self.showTimer = true
            withAnimation(.easeIn) {
                self.count += 1
            }
        } label: {
            HStack {
                Text("Resend SMS")
                    .foregroundColor(showTimer ? .primary : Color(hex: "#E6425E"))
                if showTimer {
                    Text("in \(timeRemaining)")
                        .foregroundColor(.primary)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .disabled(showTimer)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(showTimer ? Color.black.opacity(0.3) : Color(hex: "#E6425E"), lineWidth: 1)
                .blendMode(.normal)
                .opacity(0.7)
                .frame(height: 40)
        )
        .padding(.top)
    }// MARK: Resend
    
    private var otherLoginMethods: some View {
        VStack {
            Button {self.dismissMode()} label: {
                Text("Try other login methods")
                    .font(.footnote.bold())
                    .foregroundColor(Color(hex: "#E6425E"))
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
