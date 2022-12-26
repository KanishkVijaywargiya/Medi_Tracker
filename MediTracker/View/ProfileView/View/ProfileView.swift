//
//  ProfileView.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 23/12/22.
//

import SwiftUI
import Combine

enum CameraType {
    case camera, photoLibrary
}

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vm = OTPViewModel()
    @StateObject private var profileVM = ProfileViewModel()
    
    // MARK: For image picker
    @State private var openActionSheet = false
    @State private var openCameraRoll = false
    @State private var cameraType: CameraType = .photoLibrary
    @Binding var imageSelected: UIImage
    
    
    // MARK: Personal infos
    @Binding var userame: String
    @AppStorage("mobile_num") private var mobile_num = "" // MARK: app storage for mobile number
    @State private var dob = Date()
    private let textLimit = 20
    
    // MARK: Medical infos
    @State private var weight: Double = 0.0
    @State private var height: Double = 0.0
    
    @State private var genderSelection = 0
    var gender = ["Male", "Female", "Other"]
    
    @State private var bloodTypeSelection = 0
    var bloodType = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
    
    @State private var wheelChairSelection: Bool = false
    @State private var organDonarSelection: Bool = false
    
    let appReleaseVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            Color.white
            
            ScrollView(showsIndicators: false) {
                VStack (alignment: .center) {
                    // MARK: Username & User pic section
                    userImgSection
                    
                    // MARK: User detail section
                    userInfoSection
                    
                    // MARK: Allergies section
                    VStack (alignment: .leading, spacing: 20) {
                        // allergy title & add section
                        allergyTitle
                        
                        // alergy card section
                        allergyCard
                    }
                    
                    // MARK: Share & rate our app section
                    footerSection
                    
                    signout
                    
                }.padding(.bottom, 40)
                
            }.scrollDismissesKeyboard(.immediately)
            
            closeButton
        }
        
        .ignoresSafeArea()
        .sheet(isPresented: $openCameraRoll, content: {
            if cameraType == .camera {
                ImagePicker(selectedImage: $imageSelected, sourceType: .camera)
            } else {
                ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
            }
        })// open camera role or photo library according to selection
        .confirmationDialog("What do you want to open?", isPresented: $openActionSheet) {
            Button(action: {
                openCameraRoll = true
                cameraType = .camera
            }) {
                Text("Camera")
            }
            Button(action: {
                openCameraRoll = true
                cameraType = .photoLibrary
            }) {
                Text("Photo Gallery")
            }
            Button("Cancel", role: .cancel) {
                openActionSheet = false
            }
        } message: {
            Text("What do you want to open?")
        }// options for camera or photo library
    }
    
    func limitText(_ upper: Int) {
        if userame.count > upper {
            userame = String(userame.prefix(upper))
        }
    }// limit the text for textField
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(imageSelected: .constant(UIImage()), userame: .constant(""))
    }
}

extension ProfileView {
    private var userImgSection: some View {
        VStack (alignment: .center, spacing: 10) {
            profileImage
            textField
        }
        .padding()
        .padding(.top, 50)
    }// top section
    
    private var profileImage: some View {
        Button(action: {self.openActionSheet.toggle()}) {
            ZStack {
                ProfileImage(imageSelected: $imageSelected)
            }
        }
        .padding(.bottom)
    }// top section
    
    private var textField: some View {
        TextField("Enter your name", text: $userame)
            .foregroundColor(.black.opacity(0.7))
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 16).stroke(Color.black.opacity(0.3), lineWidth: 1)
            }
            .onReceive(Just(userame)) { _ in limitText(textLimit)}
    }// top section
    
    
    private var userInfoSection: some View {
        VStack (alignment: .leading) {
            personalInfo
            
            medicalInfo
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
        .padding(.horizontal)
    }// mid section
    
    private var personalInfo: some View {
        VStack {
            HStack {
                Text("Contact Number")
                Spacer()
                Text(mobile_num).foregroundColor(.secondary)
            }// mobile num
            divider
            DatePicker("Date of Birth", selection: $dob, displayedComponents: .date)
            divider
        }.tint(Color(K.BrandColors.pink))
    }// mid section
    
    private var medicalInfo: some View {
        VStack {
            Group {
                HStack {
                    Text("Weight")
                    Spacer()
                    TextField("Enter your weight", value: $weight, format: .number)
                    //TextField("Enter your weight", text: $weight)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .onReceive(Just(weight)) { _ in limitText(textLimit)}
                    Text("Kg").foregroundColor(.secondary)
                }// weight
                divider
                
                HStack {
                    Text("Height")
                    Spacer()
                    TextField("Enter your height", value: $height, format: .number)
//                    TextField("Enter your height", text: $height, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .onReceive(Just(height)) { _ in limitText(textLimit)}
                    Text("cm").foregroundColor(.secondary)
                }// height
                divider
                
                HStack {
                    Text("Gender")
                    Spacer()
                    Picker("Gender", selection: $genderSelection) {
                        ForEach(0..<gender.count, id: \.self) {
                            Text(self.gender[$0]).tag($0)
                        }
                    }// gender
                }
                divider
                
                HStack {
                    Text("Blood Type")
                    Spacer()
                    Picker("Blood Type", selection: $bloodTypeSelection) {
                        ForEach(0..<bloodType.count, id: \.self) {
                            Text(self.bloodType[$0]).tag($0)
                        }
                    }// blood type
                }
                divider
            }
            Group {
                HStack (spacing: 20) {
                    Toggle("Wheel chair", isOn: $wheelChairSelection)
                    Text(wheelChairSelection ? "Yes" : "No")
                        .foregroundColor(.secondary)
                        .animation(.easeIn, value: wheelChairSelection)
                }// wheel chair
                divider
                
                HStack (spacing: 20) {
                    Toggle("Organ Donar", isOn: $organDonarSelection)
                    Text(organDonarSelection ? "Yes" : "No")
                        .foregroundColor(.secondary)
                        .animation(.easeIn, value: organDonarSelection)
                }// organ donar
            }
        }
        .tint(Color(K.BrandColors.pink))
    }// mid section
    
    private var allergyTitle: some View {
        HStack (alignment: .center) {
            Text("My Allergies").font(.title.bold()).foregroundColor(.primary)
            Spacer()
            MTAddButton(title: "Add", iconName: "plus", action: {})
        }
        .padding()
        .padding(.top, 20)
    }// allergy section
    
    private var allergyCard: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 20) {
                ForEach(0..<5) { _ in
                    MTMedicationCard(iconName: "allergens.fill", medicineName: "Aspirin", selection: false)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }// allergy section
    
    
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
            
            footerButton
        }
    }// footer section
    
    private var footerButton: some View {
        HStack (spacing: 30) {
            MTGeneralButton(title: "Share", action: {})
            
            MTGeneralButton(title: "Rate", action: {})
        }
    }// footer section
    
    
    private var signout: some View {
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
    }// sign out section
    
    private var closeButton: some View {
        MTGlassButton(iconName: "square.and.arrow.up.fill", iconSize: 14)
            .padding(.trailing, 8)
            .padding(.top, 45)
            .onTapGesture {
                DispatchQueue.global(qos: .background).async {
                    guard let image = imageSelected as UIImage? else { return }
                    store(image: image, forKey: "ProfileImage", withStorageType: .userDefaults)
                }
                presentationMode.wrappedValue.dismiss()
            }
    }
    
    private var divider: some View {
        Divider().background(Color.black.blendMode(.lighten))
    }
}
