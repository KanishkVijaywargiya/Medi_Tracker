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
    
    @ObservedObject var vm: ProfileViewModel // profile view model
    @ObservedObject var appointVM: AppointmentCoreDataVM //appointment CoreData
    
    @AppStorage("mobile_num") private var mobile_num = ""// mobile num
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language //localize app storage
    
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
            .confirmationDialog(K.LocalizedKey.WAT_OPEN.localized(language_choosen), isPresented: $openActionSheet) {
                Button(action: {
                    openCameraRoll = true
                    cameraType = .camera
                }) {
                    Text(K.LocalizedKey.CAMERA.localized(language_choosen))
                }
                Button(action: {
                    openCameraRoll = true
                    cameraType = .photoLibrary
                }) {
                    Text(K.LocalizedKey.GALLERY.localized(language_choosen))
                }
                Button(K.LocalizedKey.CANCEL.localized(language_choosen), role: .cancel) {
                    openActionSheet = false
                }
            } message: {
                Text(K.LocalizedKey.WAT_OPEN.localized(language_choosen))
            }// options for camera or photo library
            .navigationDestination(for: Int.self) { _ in
                HomeView(appointVM: appointVM, profileVM: vm)
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
        UserIntroScreen(vm: ProfileViewModel(), appointVM: AppointmentCoreDataVM())
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
            
            TextField(K.LocalizedKey.ENTER_NAME.localized(language_choosen), text: $userame)
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
                Text(K.LocalizedKey.CONTACT_NUM.localized(language_choosen))
                Spacer()
                Text(mobile_num).foregroundColor(.secondary)
            }// mobile num
            divider
            DatePicker(K.LocalizedKey.DOB.localized(language_choosen), selection: $dob, displayedComponents: .date)
            divider
            
            VStack (alignment: .leading, spacing: 12) {
                Group {
                    HStack {
                        Text(K.LocalizedKey.WEIGHT.localized(language_choosen))
                        Spacer()
                        TextField(K.LocalizedKey.ENTER_WEIGHT.localized(language_choosen), value: $weight, format: .number)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.trailing)
                            .onReceive(Just(weight)) { _ in limitText(textLimit)}
                        Text("Kg".localized(language_choosen)).foregroundColor(.secondary)
                    }// weight
                    divider
                    
                    HStack {
                        Text(K.LocalizedKey.HEIGHT.localized(language_choosen))
                        Spacer()
                        TextField(K.LocalizedKey.ENTER_HEIGHT.localized(language_choosen), value: $height, format: .number)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.trailing)
                            .onReceive(Just(height)) { _ in limitText(textLimit)}
                        Text("cm".localized(language_choosen)).foregroundColor(.secondary)
                    }// height
                    divider
                    
                    HStack {
                        Text(K.LocalizedKey.GENDER.localized(language_choosen))
                        Spacer()
                        Picker(K.LocalizedKey.GENDER.localized(language_choosen), selection: $genderSelection) {
                            ForEach(0..<K.gender.count, id: \.self) {
                                Text(K.gender[$0]).tag($0)
                            }
                        }// gender
                    }
                    divider
                    
                    HStack {
                        Text(K.LocalizedKey.BLOOD_TYPE.localized(language_choosen))
                        Spacer()
                        Picker(K.LocalizedKey.BLOOD_TYPE.localized(language_choosen), selection: $bloodTypeSelection) {
                            ForEach(0..<K.bloodType.count, id: \.self) {
                                Text(K.bloodType[$0]).tag($0)
                            }
                        }// blood type
                    }
                    divider
                }
                Group {
                    HStack (spacing: 20) {
                        Toggle(K.LocalizedKey.WHEEL_CHAIR.localized(language_choosen), isOn: $wheelChairSelection)
                        Text(wheelChairSelection ? K.LocalizedKey.YES.localized(language_choosen) : K.LocalizedKey.NO.localized(language_choosen))
                            .foregroundColor(.secondary)
                            .animation(.easeIn, value: wheelChairSelection)
                    }// wheel chair
                    divider
                    
                    HStack (spacing: 20) {
                        Toggle(K.LocalizedKey.ORGAN_DONAR.localized(language_choosen), isOn: $organDonarSelection)
                        Text(organDonarSelection ? K.LocalizedKey.YES.localized(language_choosen) : K.LocalizedKey.NO.localized(language_choosen))
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
        }, title: K.LocalizedKey.SAVE.localized(language_choosen), hexCode: K.BrandColors.pink).padding()
    }
    
    private func uploadProfile() {
        vm.uploadUserProfile(image: imageSelected, username: userame, phoneNum: mobile_num, dateOfBirth: dob, weight: weight, height: height, gender: genderSelection, bloodType: bloodTypeSelection, wheelChair: wheelChairSelection, organDonar: organDonarSelection) { returnedBool in
            if returnedBool {
                UserDefaults.standard.UserIntroScreenShown = true
                path.append(0)
            }
        }
    }
}
