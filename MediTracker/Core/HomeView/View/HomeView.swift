//
//  HomeView.swift
//  MediTracker
//
//  Created by MANAS VIJAYWARGIYA on 15/12/22.
//

import SwiftUI
import Firebase

/*
 TODO:
 2. make full screen cover instead of medium for localization
 3. add functionality of scroll to top in language screen
 4. add accordian design modification to normal cards of language selection
 5. add more languages
 6. need to check the verification manual typing & button calling func.
 */


struct HomeView: View {
    @State private var showIntro: Bool = false //show or hide user intro screen
    @State private var showLanguageSheet: Bool = false //localization
    @State private var showProfileView: Bool = false //show profile page
    @State private var profileImage: String = "" //profile image
    @State private var dob: Date = Date() //date of birth
    @State private var nameText: String = "" //name text in onReceive
    
    @ObservedObject var profileVM: ProfileViewModel //profile viewModel
    @AppStorage("mobile_num") private var mobile_num = "" //mobile num
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            Color.white.opacity(0.1).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack (alignment: .leading, spacing: 40) {
                    headerSection //header section
                    
                    MTAppointmentCard(day: "Tue", date: "21", time: "10:00 am - 11:00 am", doctorName: "Dr. Lawrence Leiter", department: "General Surgeon") // appointment card
                    
                    medicationSection //medication card
                    
                    dailyActivityCard //activity card
                }
            }
        }
        .fullScreenCover(isPresented: $showProfileView, content: {
            ProfileView()
        })
        .sheet(isPresented: $showLanguageSheet) {
            LanguageSheet().presentationDetents([.medium])
        }//for lang. select
        .onAppear {
            DispatchQueue.main.async {
                if UserDefaults.standard.UserIntroScreenShown {
                    self.showIntro = false
                } else {
                    self.showIntro = true
                }
            }
        }//for one time user intro screen
        .fullScreenCover(isPresented: $showIntro) { UserIntroScreen() }//user intro screen
        .onReceive(profileVM.$userProfileData) { newValue in
            if (newValue != nil) {
                nameText = newValue?.username ?? "asdfghjkl"
                profileImage = newValue?.image ?? ""
                dob = newValue?.dateOfBirth ?? Date()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(profileVM: ProfileViewModel())
    }
}

extension HomeView {
    private var headerSection: some View {
        HStack (alignment: .center) {
            // title & user text
            VStack(alignment: .leading, spacing: 6) {
                Text("Good Morning,")
                    .font(.title2.bold())
                    .foregroundColor(.secondary)
                Text(nameText).font(.title3.bold())
            }
            
            Spacer()
            
            //localization icon
            GlassButton(
                iconName: LocalizationService.shared.langText,
                action: { self.showLanguageSheet.toggle() }
            )
            .padding()
            
            //profile icon
            AsyncImage(url: URL(string: profileImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 32, height: 32)
                    .padding(.all, 6)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay { Circle().stroke(Color.black.opacity(0.3), lineWidth: 2) }
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 0.2)) {
                            self.showProfileView = true
                        }
                    }
            } placeholder: {
                Image(systemName: "person.fill")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.all, 6)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay { Circle().stroke(Color.black.opacity(0.3), lineWidth: 2) }
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 0.2)) {
                            self.showProfileView = true
                        }
                    }
            }
            //            ProfileButton(profileImg: $profileImage)
            //            if let image = profileVM.userProfileData?.image {
            //                Image(image)
            //                    .font(.system(size: 32, weight: .bold))
            //                    .padding(.all, 6)
            //                    .background(Color.white)
            //                    .clipShape(Circle())
            //                    .overlay { Circle().stroke(Color.black.opacity(0.3), lineWidth: 2) }
            //                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            //                    .onTapGesture {
            //                        withAnimation(Animation.easeInOut(duration: 0.2)) {
            //                            self.showProfileView = true
            //                        }
            //                    }
            //            } else {
            //                Image(systemName: "person.fill")
            //                    .font(.system(size: 32, weight: .bold))
            //                    .padding(.all, 6)
            //                    .background(Color.white)
            //                    .clipShape(Circle())
            //                    .overlay { Circle().stroke(Color.black.opacity(0.3), lineWidth: 2) }
            //                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            //                    .onTapGesture {
            //                        withAnimation(Animation.easeInOut(duration: 0.2)) {
            //                            self.showProfileView = true
            //                        }
            //                    }
            //            }
            
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
    
    private var medicationSection: some View {
        VStack (alignment: .leading, spacing: 10) {
            //DatePicker("Date of Birth", selection: $dob, displayedComponents: .date)
            //Text(profileVM.userProfileData?.dateString ?? "")
            
            Text("Medication")
                .foregroundColor(.primary)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            // medication cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 20) {
                    ForEach(0..<5) { _ in
                        MTMedicationCard(iconName: "pill.fill", medicineName: "Vitamin C", selection: true)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    private var dailyActivityCard: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text("Daily Activity")
                .foregroundColor(.primary)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            // activity cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 16) {
                    ForEach(0..<5) { _ in
                        MTActivityCard(title: "Steps", data: "3,456", iconName: "figure.step.training", chartBar: "chart.bar")
                    }
                }.padding(.horizontal)
            }
            .padding(.vertical)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }
}
