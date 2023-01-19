//
//  HomeView.swift
//  MediTracker
//
//  Created by MANAS VIJAYWARGIYA on 15/12/22.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @State private var showLanguageSheet: Bool = false //localization
    @State private var showProfileView: Bool = false //show profile page
    @State private var profileImage: String = "" //profile image
    @State private var dob: Date = Date() //date of birth
    @State private var nameText: String = "" //name text in onReceive
    
    @StateObject var appointVM = AppointmentCoreDataVM() //appointment core data vm
    @StateObject var medicineVM = PillsCoreDataVM()
    @ObservedObject var profileVM: ProfileViewModel //profile viewModel
    @AppStorage("mobile_num") private var mobile_num = "" //mobile num
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language //localize app storage
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            ScrollView(showsIndicators: false) {
                VStack (alignment: .leading, spacing: 20) {
                    headerSection //header section
                    
                    NavigationLink(destination: CalendarView(profileVM: ProfileViewModel(), appointVM: appointVM)) {
                        if appointVM.appointmentItem.count > 0 {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack (spacing: 0) {
                                    ForEach(appointVM.appointmentItem, id: \.id) { item in
                                        MTAppointmentCard(
                                            day: item.dateAdded?.toString(K.DateSymb.DAY) ?? "",
                                            date: item.dateAdded?.toString(K.DateSymb.DATE) ?? "",
                                            time: item.dateAdded?.toString(K.DateSymb.TIME) ?? "",
                                            doctorName: item.doctorName ?? "",
                                            department: item.departmentName ?? "",
                                            check: true
                                        )
                                        .padding(.horizontal)
                                    }
                                }.frame(height: 230)
                            }
                        } else {
                            MTAppointmentCard(check: false)
                                .padding(.horizontal)
                        }
                    }
                    
                    medicationSection //medication card
                    
                    NavigationLink(
                        destination: PillsView(pillsViewModel: medicineVM)) {
                            Text("Medicine Reminder Screen")
                                .font(.title2.bold())
                                .foregroundColor(.primary)
                                .padding()
                                .background(Color(K.BrandColors.pastelOrange).gradient)
                                .cornerRadius(22, corners: [.topLeft, .bottomRight])
                                .padding(.leading)
                        }
                    
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
        .onAppear {appointVM.filterLatestData()}
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
                Text(displayGreeting().localized(language_choosen))
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
                Image(systemName: K.SFSymbols.person_fill)
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
        VStack (alignment: .leading, spacing: 20) {
            Text(K.LocalizedKey.MEDICA.localized(language_choosen))
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
            Text(K.LocalizedKey.D_ACTIVITY.localized(language_choosen))
                .foregroundColor(.primary)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.top, 20)
            
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                ForEach(1...5, id: \.self) { itme in
                    MTActivityCard(title: "Steps", data: "3,456", iconName: "figure.step.training", chartBar: "chart.bar", color: Color(K.BrandColors.pastelPurple))
                }
            }
        }
    }
}
