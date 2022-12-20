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
                        
                        MTLineText(title: "LOGIN_SIGNUP".localized(language_choosen), opacityVal: 0.3)
                        
                        countryCodeAndNum
                        
                        continueButton
                        
                        MTLineText(title: "OR".localized(language_choosen), opacityVal: 0.2)
                        
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
            NavigationLink(tag: "VERIFICATION", selection: $vm.navigationTag) {
                Verification(mobileNum: vm.number, countryCode: countryCode).environmentObject(vm)
            } label: {}.labelsHidden()
        }
        .showToast(title: networkMonitor.connected ? vm.alertTitle : "NO_CONNECTION".localized(language_choosen), isPresented: $vm.showAlert, color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), duration: 5, alignment: .top, toastType: .offsetToast, image: Image("a"))
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
        Image("bglogin")
            .resizable()
            .cornerRadius(60, corners: [.bottomLeft, .bottomRight])
            .frame(height: 340)
            .scaledToFit()
            .edgesIgnoringSafeArea(.top)
    }// MARK: BG Img
    
    private var title: some View {
        Text("MED_TRACKER_APP".localized(language_choosen))
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
                Text(countryCode)
                    .foregroundColor(.primary)
                    .font(.callout.bold())
                TextField(LocalizedStringKey("Enter_MOB_NUM".localized(language_choosen)), text: $vm.number)
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
            }, title: vm.isLoading ? "" : "CONTINUE".localized(language_choosen), hexCode: "#E6425E")
            
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
            MTSocialLoginButton(action: {}, imageName: "g")
            MTSocialLoginButton(action: {}, imageName: "apple.logo", imageCheck: true)
            MTSocialLoginButton(action: {}, imageName: "ellipsis", imageCheck: true)
        }.padding(.bottom)
    }// MARK: social login
    
    private var footerText: some View {
        VStack {
            Text("CONTINUING_AGREE".localized(language_choosen))
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(Color(.systemGray))
                .padding(.bottom, 1)
            
            HStack(spacing: 15) {
                Text("TERMS_SERVICES".localized(language_choosen))
                    .overlay {
                        Rectangle()
                            .foregroundColor(.black.opacity(0.1))
                            .frame(height: 2)
                            .padding(.top)
                    }
                Text("PRIVACY_POLICY".localized(language_choosen))
                    .overlay {
                        Rectangle()
                            .foregroundColor(.black.opacity(0.1))
                            .frame(height: 2)
                            .padding(.top)
                    }
                Text("CONTENT_POLICIES".localized(language_choosen))
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
        GlassButton(iconName: LocalizationService.shared.langText, action: {
            self.showLanguageSheet.toggle()
        })
            .padding(.leading, 12)
            .padding(.top, 50)
    }// MARK: button for localization
}
