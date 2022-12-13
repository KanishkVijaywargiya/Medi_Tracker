//
//  Login.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 11/12/22.
//

import SwiftUI

struct Login: View {
    @StateObject var vm = OTPViewModel()
    
    /*
     TODO
     1. Display list of country name & there respective flags in a full screen cover.
     2. Full screen cover should open when clicked on code button & closing should also need to handle.
     3. search functionality should be there in full screen cover to search Country by it's name or code.
     4. after selection of country, modal should closed.
     5. selected country flag should come & shown in code button.
     6. selected country code should replace hardcoded value in number field.
     -----------
     1. social logins: Google, Apple & email authentication we can integrate.
     2. ellipsis will help to open email auth screen.
     3. Terms & conditions, privacy policy needs to be added, either make a web page & display or use full screen.
     */
    
    var body: some View {
        VStack {
            bgImg
            
            Spacer()
                        
            VStack {
                title
                loginSignUpText
                countryCodeAndNum
                continueButton
                orSection
                socialLogin
                footerText
            }
            .padding([.leading, .trailing])
        }
        .padding(.bottom, 15)
        .edgesIgnoringSafeArea(.all)
        .background {
            NavigationLink(tag: "VERIFICATION", selection: $vm.navigationTag) {
                Verification().environmentObject(vm)
            } label: {}.labelsHidden()
        }
        .alert(vm.errorMsg, isPresented: $vm.showAlert) {}
        
        
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
        Login()
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
    
    private var loginSignUpText: some View {
        ZStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black.opacity(0.3))
            
            Text("Log in or sign up")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.secondary)
                .padding()
                .background(Color.white)
        }
    }// MARK: log in or sign up section
    
    private var countryCodeAndNum: some View {
        HStack {
            // code section
            //TODO: full screen modal
            Button {} label: {
                HStack {
                    Image(systemName: "flag")
                    Image(systemName: "arrowtriangle.down.fill")
                        .foregroundColor(.secondary)
                }
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
            
            // number section
            HStack {
                Text("+91")
                    .foregroundColor(.primary)
                    .font(.callout.bold())
                TextField("Enter Mobile Number", text: $vm.number)
                    .foregroundColor(.primary)
                    .font(.callout.bold())
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
        Button {Task{await vm.sendOTP()}} label: {
            Text("Continue")
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#E6425E"))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .padding(.top, 10)
    }// MARK: continue button
    
    private var orSection: some View {
        ZStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.2))
            
            Text("or")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.secondary)
                .padding()
                .background(Color.white)
        }
    }// MARK: or section
    
    private var socialLogin: some View {
        HStack(spacing: 60) {
            Button {} label: {
                Image("g")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 22, height: 22)
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
            
            // apple login button
            Button {} label: {
                Image("a")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 22, height: 22)
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
            
            // more login option button
            Button {} label: {
                Image(systemName: "ellipsis")
                    .font(.title3.bold())
            }
            .padding([.top, .bottom], 8)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black.opacity(0.1), lineWidth: 1.9)
                    .blendMode(.normal)
                    .opacity(0.7)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 2, y: 2)
            .background(Color.white)
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
    
    //------------------------------------------------------------------------------------------
    
    private var loginView: some View {
        HStack(spacing: 10) {
            countryCode
            mobileNumber
        }.padding(.vertical)
    }
    
    // MARK: Code
    private var countryCode: some View {
        VStack(spacing: 8) {
            TextField("+91", text: $vm.code)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
            
            Rectangle()
                .fill(vm.code == "" ? .gray.opacity(0.35) : .blue)
                .frame(height: 2)
        }.frame(width: 40)
    }
    
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
        Button {Task{await vm.sendOTP()}} label: {
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
        .disabled(vm.code == "" || vm.number == "")
        .opacity(vm.code == "" || vm.number == "" ? 0.4 : 1)
    }
}