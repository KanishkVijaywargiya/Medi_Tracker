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
    @State private var showLanguageSheet: Bool = false //localization
    @State private var showProfileView: Bool = false //show profile page
    @State private var profileImage: String = "" //profile image
    @State private var dob: Date = Date() //date of birth
    @State private var nameText: String = "" //name text in onReceive
    
    @ObservedObject var profileVM: ProfileViewModel //profile viewModel
    @AppStorage("mobile_num") private var mobile_num = "" //mobile num
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            Color.white.opacity(0.1).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack (alignment: .leading, spacing: 40) {
                    headerSection //header section
                    
                    NavigationLink(destination: CalendarView(profileVM: ProfileViewModel())) {
                        MTAppointmentCard(day: "Tue", date: Date(), time: "10:00 am - 11:00 am", doctorName: "Dr. Lawrence Leiter", department: "General Surgeon") // appointment card
                    }
                    
                    medicationSection //medication card
                    
                    //dailyActivityCard
                    dailyActivityGridCard //activity card
                }
            }
        }
        .fullScreenCover(isPresented: $showProfileView, content: {
            ProfileView().environmentObject(ProfileViewModel())
        })
        .sheet(isPresented: $showLanguageSheet) {
            LanguageSheet().presentationDetents([.medium])
        }//for lang. select
        .onReceive(profileVM.$userProfileData) { newValue in
            //if (newValue) {
            nameText = newValue.username
            profileImage = newValue.image
            dob = newValue.dateOfBirth
            //}
        }
        .onAppear { UIApplication.shared.applicationIconBadgeNumber = 0 }
        .navigationBarHidden(true)
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
                action: { self.showLanguageSheet.toggle() }
            )
            .padding()
            
            //profile icon
            AsyncImage(url: URL(string: profileImage)) { image in
                image
                    .resizable()
                    .frame(width: 46, height: 46)
                    .aspectRatio(contentMode: .fill)
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
    
    private var dailyActivityGridCard: some View {
        VStack (alignment: .leading, spacing: 20) {
            Text("Daily Activity")
                .foregroundColor(.primary)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                //ForEach(Department.allCases, id: \.rawValue) { department in
                ForEach(1...5, id: \.self) { itme in
                    MTActivityCard(title: "Steps", data: "3,456", iconName: "figure.step.training", chartBar: "chart.bar", color: Color(K.BrandColors.pastelPurple))
                }
            }
        }
    }
    
//    private var dailyActivityCard: some View {
//        VStack (alignment: .leading, spacing: 10) {
//            Text("Daily Activity")
//                .foregroundColor(.primary)
//                .font(.title)
//                .fontWeight(.semibold)
//                .padding(.horizontal)
//            
//            // activity cards
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack (spacing: 16) {
//                    ForEach(0..<5) { _ in
//                        MTActivityCard(title: "Steps", data: "3,456", iconName: "figure.step.training", chartBar: "chart.bar", color: Color(K.BrandColors.codeOrange))
//                    }
//                }.padding(.horizontal)
//            }
//            .padding(.vertical)
//            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
//        }
//    }
}
