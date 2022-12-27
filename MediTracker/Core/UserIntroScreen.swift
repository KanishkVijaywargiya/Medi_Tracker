//
//  UserIntroScreen.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 26/12/22.
//

import SwiftUI
import Combine

struct UserIntroScreen: View {
    @Environment(\.dismiss) private var dismissMode
    
    // MARK: can be used for core data
    @StateObject private var profileVM = ProfileViewModel()
    
    // MARK: For image picker
    @State private var openActionSheet = false
    @State private var openCameraRoll = false
    @State private var cameraType: CameraType = .photoLibrary
    @State private var imageSelected = UIImage()
    
    // MARK: Personal infos
    @State var userame: String = ""
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
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            Color.white
            
            ScrollView(showsIndicators: false) {
                VStack (alignment: .center) {
                    // MARK: Username & User pic section
                    userImgSection
                    
                    // MARK: User detail section
                    userInfoSection
                    
                    MTButton(action: {
                        UserDefaults.standard.UserIntroScreenShown = true
                        self.dismissMode()
                    }, title: "Save", hexCode: K.BrandColors.pink).padding()
                }.padding(.bottom, 40)
            }.scrollDismissesKeyboard(.immediately)
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

struct UserIntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserIntroScreen()
    }
}

extension UserIntroScreen {
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
                        .foregroundColor(.secondary)
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
                        .foregroundColor(.secondary)
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
    
    private var divider: some View {
        Divider().background(Color.black.blendMode(.lighten))
    }
    
    private var closeButton: some View {
        MTGlassButton(iconName: "square.and.arrow.up.fill", iconSize: 14)
            .padding(.trailing, 8)
            .padding(.top, 45)
        //            .onTapGesture {
        //                DispatchQueue.global(qos: .background).async {
        //                    guard let image = imageSelected as UIImage? else { return }
        //                    store(image: image, forKey: "ProfileImage", withStorageType: .userDefaults)
        //                }
        //            }
    }
}
