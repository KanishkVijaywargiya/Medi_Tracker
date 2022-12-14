//
//  Login.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 11/12/22.
//

import SwiftUI
import AwesomeToast
import AwesomeNetwork

struct Login: View {
    @EnvironmentObject private var networkMonitor: NetworkConnection
    @StateObject var vm = OTPViewModel()
    @State private var listOfCountry: Bool = false
    @State private var countryCode: String = "91"
    @State private var countryFlag: String = "🇮🇳"
    
    /*
     TODO
     3. search functionality should be there in full screen cover to search Country by it's name or code.
     10. localization.
     13. refractoring of codes
     ----------------------------------------------------------------------------
     1. social logins: Google, Apple & email authentication we can integrate.
     2. ellipsis will help to open email auth screen.
     3. Terms & conditions, privacy policy needs to be added, either make a web page & display or use full screen.
     ------------- COMPLETED ----------------
     1. Display list of country name & there respective flags in a full screen cover.
     2. Full screen cover should open when clicked on code button & closing should also need to handle.
     4. after selection of country, modal should closed.
     5. selected country flag should come & shown in code button.
     6. selected country code should replace hardcoded value in number field.
     7. UI Responsiveness, adaptive to multiple size class
     8. Functionality check.
     9. need to have a default value i.e. indian flag & +91 code.
     11. Keyboard closing.
     12. show alert when clicked without num.
     */
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                ScrollView {
                    bgImg
                    VStack {
                        title
                        
                        MTLineText(title: "Log in or sign up", opacityVal: 0.3)
                        
                        countryCodeAndNum
                        
                        MTButton(action: {
                            Task{await vm.sendOTP(countryCode: countryCode)}
                        }, title: "Continue", hexCode: "#E6425E")
                        
                        MTLineText(title: "or", opacityVal: 0.2)
                        
                        socialLogin
                        footerText
                    }
                    .padding(.horizontal)
                }
                .scrollDismissesKeyboard(.immediately)
            }
            localization
        }
        .padding(.bottom, 15)
        .edgesIgnoringSafeArea(.all)
        .background {
            NavigationLink(tag: "VERIFICATION", selection: $vm.navigationTag) {
                Verification().environmentObject(vm)
            } label: {}.labelsHidden()
        }
        .showToast(title: networkMonitor.connected ? vm.alertTitle : "Could not connect to the internet", isPresented: $vm.showAlert, color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), duration: 5, alignment: .top, toastType: .offsetToast, image: Image("a"))
        .fullScreenCover(isPresented: $listOfCountry) {
            ListOfCountries(countryCode: $countryCode, countryFlag: $countryFlag)
        }
        .environmentObject(networkMonitor)
        
        
        //        VStack {
        //            loginView
        //            verifyButton
        //        }
        //        .navigationTitle("Login")
        //        .padding()
        //        .frame(maxHeight: .infinity, alignment: .top)
        //        .background {
        //            NavigationLink(tag: "VERIFICATION", selection: $vm.navigationTag) {
        //                Verification().environmentObject(vm)
        //            } label: {}.labelsHidden()
        //
        //        }
        //        .alert(vm.errorMsg, isPresented: $vm.showAlert) {}
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().environmentObject(NetworkConnection())
    }
}

extension Login {
    private var bgImg: some View {
        Image("bglogin")
            .resizable()
            .cornerRadius(60, corners: [.bottomLeft, .bottomRight])
            .frame(height: 340)
            .scaledToFit()
            .edgesIgnoringSafeArea(.top)
    }// MARK: BG Img
    
    private var title: some View {
        Text("India's #1 Medical Record Tracker app")
            .font(.system(size: 22, weight: .bold))
            .frame(maxWidth: .infinity)
            .foregroundColor(.primary)
            .multilineTextAlignment(.center)
            .frame(width: UIScreen.main.bounds.width - 30)
    }// MARK: Title
    
    private var countryCodeAndNum: some View {
        HStack {
            // code section
            //TODO: full screen modal
            Button {self.listOfCountry.toggle()} label: {
                HStack {
                    Text(countryFlag)
                        .font(.system(size: 35))
                    Image(systemName: "arrowtriangle.down.fill")
                        .foregroundColor(.secondary)
                }
            }
            .padding([.top, .bottom], 4)
            .padding([.leading, .trailing], 4)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black.opacity(0.1), lineWidth: 1.9)
                    .blendMode(.normal)
                    .opacity(0.7)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 2, y: 2)
            .background(Color.white)
            
            // number section
            HStack {
                Text("+\(countryCode)")
                    .foregroundColor(.primary)
                    .font(.callout.bold())
                TextField("Enter Mobile Number", text: $vm.number)
                    .foregroundColor(.primary)
                    .font(.callout.bold())
                    .keyboardType(.numberPad)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black.opacity(0.1), lineWidth: 1.9)
                    .blendMode(.normal)
                    .opacity(0.7)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 2, y: 2)
            .background(Color.white)
        }
    }// MARK: code & number area
    
    private var socialLogin: some View {
        HStack(spacing: 60) {
            MTSocialLoginButton(action: {}, imageName: "g")
            MTSocialLoginButton(action: {}, imageName: "apple.logo", imageCheck: true)
            MTSocialLoginButton(action: {}, imageName: "ellipsis", imageCheck: true)
        }.padding(.bottom)
    }// MARK: social login
    
    private var footerText: some View {
        VStack {
            Text("By continuing, you agree to our")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(Color(.systemGray))
                .padding(.bottom, 1)
            
            HStack(spacing: 15) {
                Text("Terms of Service")
                    .overlay {
                        Rectangle()
                            .foregroundColor(.black.opacity(0.1))
                            .frame(height: 2)
                            .padding(.top)
                    }
                Text("Privacy Policy")
                    .overlay {
                        Rectangle()
                            .foregroundColor(.black.opacity(0.1))
                            .frame(height: 2)
                            .padding(.top)
                    }
                Text("Content Policies")
                    .overlay {
                        Rectangle()
                            .foregroundColor(.black.opacity(0.1))
                            .frame(height: 2)
                            .padding(.top)
                    }
            }
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.secondary)
        }
    }// MARK: Footer text
    
    private var localization: some View {
        GlassButton(iconName: "globe.central.south.asia.fill", iconSize: 20)
            .padding(.leading, 8)
            .padding(.top, 45)
            .onTapGesture {}
    }// MARK: button for localization
    //------------------------------------------------------------------------------------------
    
    //    private var loginView: some View {
    //        HStack(spacing: 10) {
    //            countryCode
    //            mobileNumber
    //        }.padding(.vertical)
    //    }
    
    // MARK: Code
    //    private var countryCode: some View {
    //        VStack(spacing: 8) {
    //            TextField("+91", text: $vm.code)
    //                .keyboardType(.numberPad)
    //                .multilineTextAlignment(.center)
    //
    //            Rectangle()
    //                .fill(vm.code == "" ? .gray.opacity(0.35) : .blue)
    //                .frame(height: 2)
    //        }.frame(width: 40)
    //    }
    
    // MARK: Number
    private var mobileNumber: some View {
        VStack(spacing: 8) {
            TextField("8805552210", text: $vm.number)
                .keyboardType(.numberPad)
            
            Rectangle()
                .fill(vm.number == "" ? .gray.opacity(0.35) : .blue)
                .frame(height: 2)
        }
    }
    
    // MARK: Verify blue button
    private var verifyButton: some View {
        Button {
            //Task{await vm.sendOTP()}
        } label: {
            Text("Login")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.blue)
                        .opacity(vm.isLoading ? 0 : 1)
                }
                .overlay(
                    ProgressView()
                        .opacity(vm.isLoading ? 1 : 0)
                )
        }
        .disabled(vm.countryCode == "" || vm.number == "")
        .opacity(vm.countryCode == "" || vm.number == "" ? 0.4 : 1)
    }
}
