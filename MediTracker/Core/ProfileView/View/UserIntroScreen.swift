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
    
    @State private var openActionSheet = false// image picker
    @State private var openCameraRoll = false// image picker
    @State private var cameraType: CameraType = .photoLibrary// image picker
    @State private var imageSelected = UIImage()// image picker
    @State private var userame: String = ""// username
    @State private var dob = Date()// dob
    @State private var weight: Double = 0.0// weight
    @State private var height: Double = 0.0// height
    @State private var genderSelection = 0// gender
    @State private var bloodTypeSelection = 0// blood type
    @State private var wheelChairSelection: Bool = false// wheel chair
    @State private var organDonarSelection: Bool = false// organ donar
    @State private var path = [Int]()// using for navigation stack
    
    private let textLimit = 20// text field limit
    
    @StateObject private var vm = ProfileViewModel()// profile view model
    @AppStorage("mobile_num") private var mobile_num = ""// mobile num
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack (alignment: .topTrailing) {
                Color.white
                
                ScrollView(showsIndicators: false) {
                    VStack (alignment: .center) {
                        userImgAndName
                        
                        userDetails
                        
                        saveButton
                        
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
            .navigationDestination(for: Int.self) { _ in
                HomeView(profileVM: ProfileViewModel())
            }
            .navigationBarHidden(true)
        }
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
    private var userImgAndName: some View {
        VStack (alignment: .center, spacing: 10) {
            Button(action: {self.openActionSheet.toggle()}) {
                ZStack {
                    ProfileImage(imageSelected: $imageSelected)
                }
            }
            .padding(.bottom)
            
            TextField("Enter your name", text: $userame)
                .foregroundColor(.black.opacity(0.7))
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 16).stroke(Color.black.opacity(0.3), lineWidth: 1)
                }
                .onReceive(Just(userame)) { _ in limitText(textLimit)}
        }
        .padding()
        .padding(.top, 50)
    }
    
    private var userDetails: some View {
        VStack (alignment: .leading, spacing: 12) {
            HStack {
                Text("Contact Number")
                Spacer()
                Text(mobile_num).foregroundColor(.secondary)
            }// mobile num
            divider
            DatePicker("Date of Birth", selection: $dob, displayedComponents: .date)
            divider
            
            VStack (alignment: .leading, spacing: 12) {
                Group {
                    HStack {
                        Text("Weight")
                        Spacer()
                        TextField("Enter your weight", value: $weight, format: .number)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.trailing)
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
                            .onReceive(Just(height)) { _ in limitText(textLimit)}
                        Text("cm").foregroundColor(.secondary)
                    }// height
                    divider
                    
                    HStack {
                        Text("Gender")
                        Spacer()
                        Picker("Gender", selection: $genderSelection) {
                            ForEach(0..<K.gender.count, id: \.self) {
                                Text(K.gender[$0]).tag($0)
                            }
                        }// gender
                    }
                    divider
                    
                    HStack {
                        Text("Blood Type")
                        Spacer()
                        Picker("Blood Type", selection: $bloodTypeSelection) {
                            ForEach(0..<K.bloodType.count, id: \.self) {
                                Text(K.bloodType[$0]).tag($0)
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
        }
        .tint(Color(K.BrandColors.pink))
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
        .padding(.horizontal)
    }
    
    private var divider: some View {
        Divider().background(Color.black.blendMode(.lighten))
    }
    
    private var saveButton: some View {
        MTButton(action: {
            uploadProfile()
        }, title: "Save", hexCode: K.BrandColors.pink).padding()
    }
    
    private func uploadProfile() {
        vm.uploadUserProfile(image: imageSelected, username: userame, phoneNum: mobile_num, dateOfBirth: dob, weight: weight, height: height, gender: genderSelection, bloodType: bloodTypeSelection, wheelChair: wheelChairSelection, organDonar: organDonarSelection) { returnedBool in
            if returnedBool {
                UserDefaults.standard.UserIntroScreenShown = true
                //self.dismissMode()
                path.append(0)
            }
        }
    }
}
