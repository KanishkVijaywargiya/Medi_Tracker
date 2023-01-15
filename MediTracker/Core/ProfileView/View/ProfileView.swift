//
//  ProfileView.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 29/12/22.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismissMode
    @State private var showEditProfileView: Bool = false
    @StateObject private var vm = OTPViewModel() //using for sign out
    @EnvironmentObject var profileVM: ProfileViewModel //profile view model to get all data from home page
    
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language //localize app storage
    
    let appReleaseVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            Color.white
            
            ScrollView(showsIndicators: false) {
                VStack (alignment: .center) {
                    userImgAndName
                    
                    userDetails
                    
                    allergySection
                    
                    footerSection
                    
                    signOutSection
                    
                }.padding(.bottom, 40)
            }
            floatButtonSection
        }
        .fullScreenCover(isPresented: $showEditProfileView) {
            // add edit screen
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(ProfileViewModel())
    }
}

extension ProfileView {
    private var userImgAndName: some View {
        VStack (alignment: .center, spacing: 10) {
            AsyncImage(url: URL(string: profileVM.userProfileData.image)) { image in
                image
                    .resizable()
                    .frame(width: 250, height: 250)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16).stroke(Color.black.opacity(0.3), lineWidth: 1)
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .padding(.bottom)
            } placeholder: {
                Image(systemName: K.SFSymbols.person_fill)
                    .font(.system(size: 250))
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16).stroke(Color.black.opacity(0.3), lineWidth: 1)
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .padding(.bottom)
            }
            
            Text(profileVM.userProfileData.username)
                .font(.title2.bold())
        }
        .padding()
        .padding(.top, 40)
    }
    
    private var userDetails: some View {
        VStack (alignment: .leading, spacing: 12) {
            HStack {
                Text(K.LocalizedKey.CONTACT_NUM.localized(language_choosen))
                Spacer()
                Text(profileVM.userProfileData.phoneNum).foregroundColor(.secondary)
            }// mobile num
            divider
            HStack {
                Text(K.LocalizedKey.DOB.localized(language_choosen))
                Spacer()
                Text("\(profileVM.userProfileData.dateString)").foregroundColor(.secondary)
            }// dob
            divider
            
            
            VStack (alignment: .leading, spacing: 12) {
                Group {
                    HStack {
                        Text(K.LocalizedKey.WEIGHT.localized(language_choosen))
                        Spacer()
                        Text("\(profileVM.userProfileData.weight.asNumString())").foregroundColor(.secondary)
                    }// weight
                    divider
                    
                    HStack {
                        Text(K.LocalizedKey.HEIGHT.localized(language_choosen))
                        Spacer()
                        Text("\(profileVM.userProfileData.height.asNumString())").foregroundColor(.secondary)
                    }// height
                    divider
                    
                    HStack {
                        Text(K.LocalizedKey.GENDER.localized(language_choosen))
                        Spacer()
                        Text(K.gender[profileVM.userProfileData.gender]).foregroundColor(.secondary)
                    }
                    divider
                    
                    HStack {
                        Text(K.LocalizedKey.BLOOD_TYPE.localized(language_choosen))
                        Spacer()
                        Text(K.bloodType[profileVM.userProfileData.bloodType]).foregroundColor(.secondary)
                    }
                    divider
                }
                Group {
                    HStack {
                        Text(K.LocalizedKey.WHEEL_CHAIR.localized(language_choosen))
                        Spacer()
                        Text(profileVM.userProfileData.wheelCharValue).foregroundColor(.secondary)
                    }//wheel chair
                    divider
                    
                    HStack {
                        Text(K.LocalizedKey.ORGAN_DONAR.localized(language_choosen))
                        Spacer()
                        Text(profileVM.userProfileData.organDonarValue).foregroundColor(.secondary)//organ donar chair
                    }// organ donar
                }
            }
        }
        .tint(Color(K.BrandColors.pink))
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
        .padding(.horizontal)
    }
    
    private var allergySection: some View {
        VStack (spacing: 0) {
            HStack (alignment: .center) {
                Text(K.LocalizedKey.ALLERGIES.localized(language_choosen)).font(.title.bold()).foregroundColor(.primary)
                Spacer()
                MTAddButton(title: "Add", iconName: K.SFSymbols.plus, action: {})
            }
            .padding()
            .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 20) {
                    ForEach(0..<5) { _ in
                        MTMedicationCard(iconName: K.SFSymbols.allergyFill, medicineName: "Aspirin", selection: false)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    private var footerSection: some View {
        VStack (alignment: .center, spacing: 20) {
            Text(K.LocalizedKey.SPREAD.localized(language_choosen))
                .font(.headline)
                .padding(.top)
            Text(K.LocalizedKey.WE_LOVE.localized(language_choosen))
                .padding(.horizontal, 16)
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            HStack (spacing: 30) {
                MTGeneralButton(title: K.LocalizedKey.SHARE.localized(language_choosen), action: {})
                
                MTGeneralButton(title: K.LocalizedKey.RATE.localized(language_choosen), action: {})
            }
        }
    }
    
    private var signOutSection: some View {
        VStack (alignment: .center, spacing: 4) {
            Text(K.LocalizedKey.SIGN_OUT.localized(language_choosen))
                .font(.headline).foregroundColor(.primary)
            Text("Version: \(appReleaseVersion ?? "") (\(buildVersion ?? ""))")
                .font(.system(size: 16))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 20)
        .onTapGesture { vm.signOut() }
    }
    
    private var floatButtonSection: some View {
        HStack {
            MTGlassButton(iconName: K.SFSymbols.chevDown, iconSize: 14, action: {
                withAnimation {
                    self.dismissMode()
                }
            })
                
            Spacer()
            MTAddButton(title: "Edit", iconName: K.SFSymbols.pencil, action: {})
                .background(BlurView(style: .systemUltraThinMaterial))
                .cornerRadius(12)
        }.padding(.horizontal)
    }
    
    private var divider: some View {
        Divider().background(Color.black.blendMode(.lighten))
    }
}
