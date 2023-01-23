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
    
    @State private var scrollOffset: CGFloat = 0 //statusbar background on scroll
    
    @ObservedObject var appointVM: AppointmentCoreDataVM //appointment CoreData
    @ObservedObject var profileVM: ProfileViewModel //profile viewModel
    
    @AppStorage("mobile_num") private var mobile_num = "" //mobile num
    @AppStorage("language_choosen") private var language_choosen = LocalizationService.shared.language //localize app storage
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            headerSection //header section
                .id("HOME")
            
            appointmentSection //appointment card
            
            medicationSection //medication card
            
            dailyActivityGridCard //activity card
        }
        .fullScreenCover(isPresented: $showProfileView, content: {
            ProfileView().environmentObject(ProfileViewModel())
        })
        .sheet(isPresented: $showLanguageSheet) {
            LanguageSheet().presentationDetents([.medium])
        }//for lang. select
        .onReceive(profileVM.$userProfileData) { newValue in
            nameText = newValue.username
            profileImage = newValue.image
            dob = newValue.dateOfBirth
        }
        .onAppear { UIApplication.shared.applicationIconBadgeNumber = 0 }
        .onAppear {appointVM.filterLatestData()}
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(appointVM: AppointmentCoreDataVM(), profileVM: ProfileViewModel())
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
                    .id(1) //used fo scrollToTop when tapped on bottom tab
                Text(nameText).font(.title3.bold()).foregroundColor(Color(K.BrandColors.pink))
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
    
    private var appointmentSection: some View {
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
                                department: item.departmentName ?? ""
                            )
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .padding(.horizontal)
                        }
                    }.frame(height: 230)
                }
            } else {
                MTAppointmentCard()
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
            }
        }
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
                ForEach(1..<5) { itme in
                    MTActivityCard(title: "Steps", data: "3,456", iconName: "figure.step.training", chartBar: "chart.bar", color: Color(K.BrandColors.pastelPurple))
                }
            }
        }
    }
}
