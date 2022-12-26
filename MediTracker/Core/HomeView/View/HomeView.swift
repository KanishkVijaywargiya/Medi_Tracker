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
    // MARK: used for localization sheet
    @State private var showLanguageSheet: Bool = false
    
    // MARK: Profile page
    @State private var showProfileView: Bool = false
    @AppStorage("name") var name = ""
    @State private var profileImage: UIImage = retrieveImage(forKey: "ProfileImage", inStorageType: .userDefaults)
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            Color.white.opacity(0.1).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack (alignment: .leading, spacing: 40) {
                    // MARK: Header Section
                    headerSection
                    
                    
                    // MARK: Appointment Card
                    MTAppointmentCard(day: "Tue", date: "21", time: "10:00 am - 11:00 am", doctorName: "Dr. Lawrence Leiter", department: "General Surgeon")
                    
                    
                    // MARK: Medication Card
                    medicationSection
                    
                    
                    // MARK: Daily activity Card
                    dailyActivityCard
                }
            }
        }
        .fullScreenCover(isPresented: $showProfileView, content: {
            ProfileView(imageSelected: $profileImage, userame: $name)
                .animation(Animation.spring(), value: name)
        })
        .sheet(isPresented: $showLanguageSheet) {
            LanguageSheet().presentationDetents([.medium])
        }//for lang. select
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
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
                Text("\(name)").font(.title3.bold())
            }
            
            Spacer()
            
            // localization icon
            GlassButton(
                iconName: LocalizationService.shared.langText,
                action: { self.showLanguageSheet.toggle() }
            )
            .padding()
            
            // profile icon
            ProfileButton(profileImg: $profileImage)
                .onTapGesture {
                    withAnimation(Animation.easeInOut(duration: 0.2)) {
                        self.showProfileView = true
                    }
                }
             
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
    
    private var medicationSection: some View {
        VStack (alignment: .leading, spacing: 10) {
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
