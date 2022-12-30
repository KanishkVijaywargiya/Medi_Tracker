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
    //@EnvironmentObject var profileVM: ProfileViewModel
    
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
        ProfileView()
    }
}

extension ProfileView {
    private var userImgAndName: some View {
        VStack (alignment: .center, spacing: 10) {
            Image(systemName: "person.fill")
                .font(.system(size: 250))
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(16)
                .overlay {
                    RoundedRectangle(cornerRadius: 16).stroke(Color.black.opacity(0.3), lineWidth: 1)
                }
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .padding(.bottom)
            
            Text("Kanishk Vijaywargiya")
                .font(.title2.bold())
        }
        .padding()
        .padding(.top, 40)
    }
    
    private var userDetails: some View {
        VStack (alignment: .leading, spacing: 12) {
            HStack {
                Text("Contact Number")
                Spacer()
                Text("+91-9123235319").foregroundColor(.secondary)
            }// mobile num
            divider
            HStack {
                Text("Date of Birth")
                Spacer()
                Text("01-Jan-1999").foregroundColor(.secondary)
            }// dob
            divider
            
            
            VStack (alignment: .leading, spacing: 12) {
                Group {
                    HStack {
                        Text("Weight")
                        Spacer()
                        Text("70 Kg").foregroundColor(.secondary)
                    }// weight
                    divider
                    
                    HStack {
                        Text("Height")
                        Spacer()
                        Text("175 cm").foregroundColor(.secondary)
                    }// height
                    divider
                    
                    HStack {
                        Text("Gender")
                        Spacer()
                        Text("Male").foregroundColor(.secondary)
                    }
                    divider
                    
                    HStack {
                        Text("Blood Type")
                        Spacer()
                        Text("B+").foregroundColor(.secondary)
                    }
                    divider
                }
                Group {
                    HStack {
                        Text("Wheel Chair")
                        Spacer()
                        Text("No").foregroundColor(.secondary)
                    }//wheel chair
                    divider
                    
                    HStack {
                        Text("Organ Donar")
                        Spacer()
                        Text("No").foregroundColor(.secondary)//organ donar chair
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
                Text("My Allergies").font(.title.bold()).foregroundColor(.primary)
                Spacer()
                MTAddButton(title: "Add", iconName: "plus", action: {})
            }
            .padding()
            .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 20) {
                    ForEach(0..<5) { _ in
                        MTMedicationCard(iconName: "allergens.fill", medicineName: "Aspirin", selection: false)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    private var footerSection: some View {
        VStack (alignment: .center, spacing: 20) {
            Text("Spread the word")
                .font(.headline)
                .padding(.top)
            Text("We love hearing from our users, enjoying our app, please rate us on the AppStore")
                .padding(.horizontal, 16)
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            HStack (spacing: 30) {
                MTGeneralButton(title: "Share", action: {})
                
                MTGeneralButton(title: "Rate", action: {})
            }
        }
    }
    
    private var signOutSection: some View {
        VStack (alignment: .center, spacing: 4) {
            Text("Sign Out")
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
            MTGlassButton(iconName: "chevron.down", iconSize: 14, action: {
                withAnimation {
                    self.dismissMode()
                }
            })
                
            Spacer()
            MTAddButton(title: "Edit", iconName: "pencil", action: {})
                .background(BlurView(style: .systemUltraThinMaterial))
                .cornerRadius(12)
        }.padding(.horizontal)
    }
    
    private var divider: some View {
        Divider().background(Color.black.blendMode(.lighten))
    }
}
