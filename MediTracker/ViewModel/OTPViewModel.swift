//
//  OTPViewModel.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 11/12/22.
//

import SwiftUI
import Firebase
import AwesomeNetwork

class OTPViewModel: ObservableObject {
    // MARK: Login Data
    @Published var number: String = ""
    @Published var countryCode: String = ""
    
    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 6)
    
    // MARK: Error
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    
    // MARK: OTP Credentials
    @Published var verificationCode: String = ""
    
    @Published var isLoading: Bool = false
    @Published var navigationTag: String?
    
    @AppStorage("log_status") private var log_status = false
    
    // MARK: Sending OTP
    func sendOTP(countryCode: String) async {
            if isLoading { return }
            if number.isEmpty || number.count < 10 {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.showAlert.toggle()
                    self.alertTitle = "Please enter a valid phone number."
                }
            } else {
                do {
                    DispatchQueue.main.async {
                        self.isLoading = true
                    }
                    let result = try await
                    PhoneAuthProvider.provider().verifyPhoneNumber("+\(countryCode)\(number)", uiDelegate: nil)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.verificationCode = result
                        self.navigationTag = "VERIFICATION"
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.showAlert.toggle()
                        self.alertTitle = "Something went wrong"
                        //"Could not connect to the internet"
                    }
                }
            }
    }
    //    func sendOTP(countryCode: String) async {
    //        if isLoading { return }
    //        if number.isEmpty {
    //
    //        } else {
    //            do {
    //                DispatchQueue.main.async {
    //                    self.isLoading = true
    //                }
    //                    let result = try await
    //                    PhoneAuthProvider.provider().verifyPhoneNumber("+\(countryCode)\(number)", uiDelegate: nil)
    //                    DispatchQueue.main.async {
    //                        self.isLoading = false
    //                        self.verificationCode = result
    //                        self.navigationTag = "VERIFICATION"
    //                    }
    //                } catch {
    //                    handleError(e: error.localizedDescription)
    //                }
    //        }
    //    }
    
    //    func handleError(e: String) {
    //        DispatchQueue.main.async {
//                self.isLoading = false
//                self.errorMsg = e
//                self.showAlert.toggle()
    //        }
    //    }
    
    // MARK: Verify OTP
    func verifyOTP() async {
        do {
            isLoading = true
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpText)
            
            let _ = try await Auth.auth().signIn(with: credential)
            
            DispatchQueue.main.async {[self] in
                self.isLoading = false
                self.log_status = true
            }
        } catch {
            //handleError(e: error.localizedDescription)
        }
    }
}
