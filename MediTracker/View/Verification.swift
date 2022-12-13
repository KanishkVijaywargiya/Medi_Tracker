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
}// MARK: enum for otp text fields

struct Verification: View {
    @EnvironmentObject var vm: OTPViewModel
    @FocusState var activeField: OTPField? // MARK: TextField FocusState
    
    /* TODO
     1. auto verification without any button click.
     2. resend functionality should work & gets activate only after 6-8 sec. of 1st OTP with red border.
     3. try "other login methods" button should navigate back to login screen.
     4. alert should be added when verification is a success / error.
     5. add a back button to navigate back to login screen.
     */
    
    var body: some View {
        VStack {
            title
            otpFields
            resendButton
            otherLoginMethods
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("Verification")
        .onChange(of: vm.otpFields) { newValue in
            otpCondition(value: newValue)
        }
        .alert(vm.errorMsg, isPresented: $vm.showAlert) {}
        
        //        VStack {
        //            otpField
        //            verifyButton
        //            resendOTPButton
        //        }
        //        .padding()
        //        .frame(maxHeight: .infinity, alignment: .top)
        //        .navigationTitle("Verification")
        //        .onChange(of: vm.otpFields) { newValue in
        //            otpCondition(value: newValue)
        //        }
        //        .alert(vm.errorMsg, isPresented: $vm.showAlert) {}
    }
}

struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        Verification().environmentObject(OTPViewModel())
    }
}

extension Verification {
    private var title: some View {
        VStack {
            Text("We have sent a verification code to")
            Text("+91-9123235319")
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
    
    private var resendButton: some View {
        Button {} label: {
            Text("Resend")
                .foregroundColor(.primary)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black.opacity(0.3), lineWidth: 1)
                .blendMode(.normal)
                .opacity(0.7)
                .frame(height: 40)
        )
        .padding(.top)
    }// MARK: Resend
    
    private var otherLoginMethods: some View {
        VStack {
            Button {} label: {
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
        }//moving to next field if user entered value to current field
        
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
    
    // MARK: used to disable the verify blue button
    private func checkStates() -> Bool {
        for index in 0..<6 {
            if vm.otpFields[index].isEmpty { return true }
        }
        return false
    }
    
    // MARK: Verify blue button
    private var verifyButton: some View {
        Button {Task{await vm.verifyOTP()}} label: {
            Text("Verify")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.blue)
                        .opacity(vm.isLoading ? 0 : 1)
                }
                .overlay {
                    ProgressView().opacity(vm.isLoading ? 1 : 0)
                }
        }
        .disabled(checkStates())
        .opacity(checkStates() ? 0.4 : 1)
        .padding(.vertical)
    }
    
    //--------------------------------------------------------------------------------------
    
    // MARK: Custom OTP TextField
    private var otpField: some View {
        HStack(spacing: 14) {
            ForEach(0..<6, id: \.self) { item in
                VStack(spacing: 8) {
                    TextField("", text: $vm.otpFields[item])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeField, equals: activeStateForIndex(index: item))
                    
                    Rectangle()
                        .fill(activeField == activeStateForIndex(index: item) ? .blue : .gray.opacity(0.3))
                        .frame(height: 4)
                }.frame(width: 40)
            }
        }
    }
    
}
