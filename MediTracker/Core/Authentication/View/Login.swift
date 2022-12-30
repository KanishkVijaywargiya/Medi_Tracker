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
    @State private var countryCode: String = "+91"
    @State private var countryFlag: String = "🇮🇳"
    
    // MARK: used for localization sheet
    @State private var showLanguageSheet: Bool = false
    
    // MARK: app storage for localization
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                ScrollView {
                    bgImg
                    VStack {
                        title
                        
                        MTLineText(title: K.LocalizedKey.LOGIN_SIGNUP.localized(language_choosen), opacityVal: 0.3)
                        
                        countryCodeAndNum
                        
                        continueButton
                        
                        MTLineText(title: K.LocalizedKey.OR.localized(language_choosen), opacityVal: 0.2)
                        
                        socialLogin
                    }
                    .padding(.horizontal)
                }
                .scrollDismissesKeyboard(.immediately)
                
                footerText.padding(.bottom, 20)
            }
            localization
        }
        .padding(.bottom, 15)
        .edgesIgnoringSafeArea(.all)
        .background {
            NavigationLink(tag: K.NavigationTag.verification, selection: $vm.navigationTag) {
                Verification(mobileNum: vm.number, countryCode: countryCode).environmentObject(vm)
            } label: {}.labelsHidden()
        }
        .showToast(title: networkMonitor.connected ? vm.alertTitle : K.LocalizedKey.NO_CONNECTION.localized(language_choosen), isPresented: $vm.showAlert, color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), duration: 5, alignment: .top, toastType: .offsetToast, image: Image(K.AppImg.appLogo))
        .fullScreenCover(isPresented: $listOfCountry) {
            ListOfCountries(countryCode: $countryCode, countryFlag: $countryFlag)
        }//country code with country flag
        .sheet(isPresented: $showLanguageSheet) {
            LanguageSheet().presentationDetents([.medium])
        }//for lang. select
        .environmentObject(networkMonitor)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().environmentObject(NetworkConnection())
    }
}

extension Login {
    private var bgImg: some View {
        Image(K.AppImg.bgLoginImg)
            .resizable()
            .cornerRadius(60, corners: [.bottomLeft, .bottomRight])
            .frame(height: 340)
            .scaledToFit()
            .edgesIgnoringSafeArea(.top)
    }// MARK: BG Img
    
    private var title: some View {
        Text(K.LocalizedKey.MED_TRACKER_APP.localized(language_choosen))
            .font(.system(size: 22, weight: .bold))
            .frame(maxWidth: .infinity)
            .foregroundColor(.primary)
            .multilineTextAlignment(.center)
            .padding(.top)
    }// MARK: Title
    
    private var countryCodeAndNum: some View {
        HStack {
            // code section
            //TODO: full screen modal
            Button {self.listOfCountry.toggle()} label: {
                HStack {
                    Text(countryFlag)
                        .font(.system(size: 35))
                    Image(systemName: K.SFSymbols.arrowTriangleDownFill)
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
                Text(countryCode)
                    .foregroundColor(.primary)
                    .font(.callout.bold())
                TextField(LocalizedStringKey(K.LocalizedKey.Enter_MOB_NUM.localized(language_choosen)), text: $vm.number)
                    .foregroundColor(.primary)
                    .font(.callout.bold())
                    .keyboardType(.phonePad)
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
    
    private var continueButton: some View {
        ZStack(alignment: .center) {
            MTButton(action: {
                Task{await vm.sendOTP(countryCode: countryCode)}
            }, title: vm.isLoading ? "" : K.LocalizedKey.CONTINUE.localized(language_choosen), hexCode: K.BrandColors.pink)
            
            if vm.isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }.frame(height: 52)
            }
        }.padding(.top, 10)
    }
    
    private var socialLogin: some View {
        HStack(spacing: 60) {
            MTSocialLoginButton(action: {}, imageName: K.AppImg.googleLogin)
            MTSocialLoginButton(action: {}, imageName: K.SFSymbols.appleLogin, imageCheck: true)
            MTSocialLoginButton(action: {}, imageName: K.SFSymbols.ellipsis, imageCheck: true)
        }.padding(.bottom)
    }// MARK: social login
    
    private var footerText: some View {
        VStack {
            Text(K.LocalizedKey.CONTINUING_AGREE.localized(language_choosen))
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(Color(.systemGray))
                .padding(.bottom, 1)
            
            HStack(spacing: 15) {
                FooterText(text: K.LocalizedKey.TERMS_SERVICES.localized(language_choosen), action: {})
                
                FooterText(text: K.LocalizedKey.PRIVACY_POLICY.localized(language_choosen), action: {})
                
                FooterText(text: K.LocalizedKey.CONTENT_POLICIES.localized(language_choosen), action: {})
            }
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.secondary)
        }
    }// MARK: Footer text
    
    private var localization: some View {
        GlassButton(action: {
            self.showLanguageSheet.toggle()
        })
            .padding(.leading, 12)
            .padding(.top, 50)
    }// MARK: button for localization
}
