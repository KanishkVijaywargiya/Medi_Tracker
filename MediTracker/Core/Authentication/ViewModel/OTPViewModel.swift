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
    
    // MARK: Verification
    //    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 6)
    @Published var verificationCode: String = ""
    
    // MARK: Error
    @Published var showAlert: Bool = false
    @Published var verificationAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var verificationAlertTitle: String = ""
    
    @Published var isLoading: Bool = false
    @Published var navigationTag: String?
    
    // MARK: app storage for login status
    @AppStorage("log_status") private var log_status = false
    
    // MARK: app storage for localization
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language
    
    // MARK: app storage for mobile number
    @AppStorage("mobile_num") private var mobile_num = ""
    
    //otp text
    var otpValue: String = "" {
        didSet {
            if otpValue.count == 6 {
                Task {await verifyOTP(otpText: otpValue)}
            }
        }
    }
    
    
    // MARK: Sending OTP
    func sendOTP(countryCode: String) async {
        if isLoading { return }
        if number.isEmpty || number.count < 10 {
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.isLoading = false
                self.showAlert.toggle()
                self.alertTitle = K.LocalizedKey.VALID_NUM.localized(self.language_choosen)
                self.countryCode = ""
            }
        } else {
            do {
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else { return }
                    self.isLoading = true
                }
                let result = try await
                PhoneAuthProvider.provider().verifyPhoneNumber("+\(countryCode)\(number)", uiDelegate: nil)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.verificationCode = result
                    self.navigationTag = K.LocalizedKey.VERIFICATION
                    self.countryCode = countryCode
                }
            } catch {
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else { return }
                    self.isLoading = false
                    self.showAlert.toggle()
                    self.alertTitle = K.LocalizedKey.SOMETHING_WRONG.localized(self.language_choosen)
                    self.countryCode = ""
                }
            }
        }
    }
    
    // MARK: Verify OTP
    private func verifyOTP(otpText: String) async {
        do {
            DispatchQueue.main.async {
                self.isLoading = true
            }
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpText)
            
            let _ = try await Auth.auth().signIn(with: credential)
            
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.isLoading = false
                self.log_status = true
                self.mobile_num = "\(self.countryCode)-\(self.number)"
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading = false
                self.verificationAlert.toggle()
                self.verificationAlertTitle = K.LocalizedKey.SOMETHING_WRONG.localized(self.language_choosen)
            }
        }
    }
    
    // MARK: Sign Out
    func signOut() {
        do {
            try Auth.auth().signOut()
            log_status = false
            self.mobile_num = ""
            UserDefaults.standard.UserIntroScreenShown = false
        } catch {
            
        }
    }
}
