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
    
    // MARK: For Username
    @AppStorage("name") private var name = ""
    @State private var openActionSheet = false
    @Binding var saveName: String
    let textLimit = 20
    
    // MARK: For image picker
    @State private var openCameraRoll = false
    @State private var cameraType: CameraType = .photoLibrary
    @Binding var imageSelected: UIImage
    
    // MARK: app storage for mobile number
    @AppStorage("mobile_num") private var mobile_num = ""
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            Color.white
            
            ScrollView(showsIndicators: false) {
                VStack (alignment: .leading) {
                    // MARK: Username & User pic section
                    VStack (alignment: .center, spacing: 10) {
                        profileImage
                        textField
                    }
                    .padding()
                    .padding(.top, 50)
                    
                    
                    // MARK: User detail section
                    VStack (alignment: .leading) {
                        Group {
                            HStack (alignment: .center) {
                                Text("Contact Number")
                                Spacer()
                                Text(mobile_num)
                            }
                            
                            divider
                            
                            HStack (alignment: .center) {
                                Text("Date of Birth")
                                Spacer()
                                Text("01/01/1999")
                            }
                            
                            divider
                            
                            HStack (alignment: .center) {
                                Text("Weight")
                                Spacer()
                                Text("70Kg")
                            }
                            
                            divider
                            
                            HStack (alignment: .center) {
                                Text("Height")
                                Spacer()
                                Text("170cm")
                            }
                            
                            divider
                        }
                        
                        Group {
                            HStack (alignment: .center) {
                                Text("Gender")
                                Spacer()
                                Text("Male")
                            }
                            
                            divider
                            
                            HStack (alignment: .center) {
                                Text("Blood Type")
                                Spacer()
                                Text("B+")
                            }
                            
                            divider
                            
                            HStack (alignment: .center) {
                                Text("Wheel chair")
                                Spacer()
                                Text("No")
                            }
                            
                            divider
                            
                            HStack (alignment: .center) {
                                Text("Organ Donar")
                                Spacer()
                                Text("No")
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    
                    // MARK: User allergies section
                    
                    
                    // MARK: If you like this app, please share & rate
                }
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
        if saveName.count > upper {
            saveName = String(saveName.prefix(upper))
        }
    }// limit the text for textField
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(saveName: .constant(""), imageSelected: .constant(UIImage()))
    }
}

extension ProfileView {
    private var profileImage: some View {
        Button(action: {self.openActionSheet.toggle()}) {
            ZStack {
                ProfileImage(imageSelected: $imageSelected)
            }
        }
        .padding(.bottom)
    }
    
    private var textField: some View {
        TextField("Enter your name", text: $saveName)
            .foregroundColor(.black.opacity(0.7))
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 16).stroke(Color.black.opacity(0.3), lineWidth: 1)
            }
            .onReceive(Just(saveName)) { _ in limitText(textLimit)}
    }
    
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
        Divider().background(Color.black).blendMode(.overlay)
    }
}
