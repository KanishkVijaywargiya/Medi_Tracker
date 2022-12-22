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
    
    @StateObject var vm = OTPViewModel()
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            Color.white.opacity(0.1).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack (alignment: .leading, spacing: 40) {
                    // MARK: Header Section
                    HStack (alignment: .center) {
                        // title & user text
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Good Morning,")
                                .font(.title2.bold())
                                .foregroundColor(.secondary)
                            Text("John Carter").font(.title3.bold())
                        }
                        
                        Spacer()
                        
                        // localization icon
                        GlassButton(
                            iconName: LocalizationService.shared.langText,
                            action: { self.showLanguageSheet.toggle() }
                        )
                        .padding()
                        
                        // profile icon
                        Image(systemName: "person.fill")
                            .font(.system(size: 32, weight: .bold))
                            .padding(.all, 6)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay { Circle().stroke(Color.black.opacity(0.3), lineWidth: 2) }
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            .onTapGesture {
                                vm.signOut()
                            }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    
                    
                    // MARK: Appointment Card
                    HStack (alignment: .center, spacing: 20) {
                        // left section
                        VStack (alignment: .center, spacing: 8) {
                            Text("Tue").font(.body).foregroundColor(.secondary)
                            Rectangle()
                                .frame(width: 20, height: 1)
                                .foregroundColor(.black.opacity(0.2))
                            Text("21").font(.title3.bold()).foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        
                        // right section
                        VStack (alignment: .leading, spacing: 10) {
                            Text("Your appointments")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                            Text("10:00 am - 11:00 am")
                                .font(.footnote)
                                .foregroundColor(.white)
                            
                            VStack (alignment: .leading, spacing: 2) {
                                Text("Dr. Lawrence Leiter")
                                    .font(.body.bold())
                                    .foregroundColor(.white)
                                Text("General Surgeon")
                                    .font(.caption.bold())
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(30)
                    .background(Color(K.BrandColors.pink))
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .shadow(color: Color.pink.opacity(0.3), radius: 10, x: 0, y: 10)
                    .padding(.horizontal)
                    
                    
                    // MARK: Medication Card
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
                                    VStack (alignment: .center, spacing: 10) {
                                        Image(systemName: "pill.fill")
                                            .font(.title.bold())
                                            .foregroundColor(Color(K.BrandColors.pink))
                                        
                                        Text("Vitamin C")
                                            .foregroundColor(.secondary)
                                            .fontWeight(.medium)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                            .stroke(Color(K.BrandColors.pink), lineWidth: 1)
                                    }
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                        }
                    }
                    
                    
                    // MARK: Daily activity Card
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Daily Activity")
                            .foregroundColor(.primary)
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        // activity cards
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 0) {
                                ForEach(0..<5) { _ in
                                    VStack (alignment: .center, spacing: 10) {
                                        HStack (alignment: .top, spacing: 20) {
                                            VStack (alignment: .leading, spacing: 8) {
                                                Text("Steps")
                                                    .foregroundColor(.white)
                                                    .font(.footnote)
                                                    .fontWeight(.semibold)
                                                
                                                Text("3,456")
                                                    .foregroundColor(.white)
                                                    .font(.title2.bold())
                                            }
                                            Image(systemName: "figure.step.training")
                                                .font(.title.bold())
                                                .foregroundColor(.purple.opacity(0.5))
                                        }
                                        // need to replace with actual bar chart
                                        Image(systemName: "chart.bar")
                                            .font(.system(size: 45, weight: .bold))
                                            .foregroundColor(.purple.opacity(0.5))
                                    }
                                    .padding()
                                    .background(Color(K.BrandColors.pastelPurple))
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.vertical)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                }
            }
            
            Spacer()
        }
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
