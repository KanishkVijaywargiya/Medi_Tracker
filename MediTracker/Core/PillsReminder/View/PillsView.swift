//
//  PillsView.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 19/01/23.
//

import SwiftUI

struct PillsView: View {
    @State private var addPills: Bool = false //to open adding pills sheet
    @ObservedObject var pillsViewModel: PillsCoreDataVM
    
    var body: some View {
        VStack (spacing: 40) {
            headerView //header
            
            filterCard //morning, af, eve card for pills
            
            // medicine cards
            ScrollView {
                ForEach(pillsViewModel.pillsEntity) { pills in
                    medicineCard(pills)
                }
            }
        }
        .fullScreenCover(isPresented: $addPills) {
            AddPills(pillsVM: pillsViewModel)
        }
        .navigationBarHidden(true)
    }
}
 
struct PillsView_Previews: PreviewProvider {
    static var previews: some View {
        PillsView(pillsViewModel: PillsCoreDataVM())
    }
}

extension PillsView {
    private var headerView: some View {
        HStack (alignment: .center) {
            Text("Medicine Calendar")
                .font(.system(size: 22, weight: .bold))
            Spacer()
            
            Button {addPills.toggle()} label: {
                HStack (spacing: 10) {
                    Image(systemName: K.SFSymbols.plus)
                    Text("Add").customFont(15, weight: .regular)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background { Capsule().fill(Color(K.BrandColors.pink).gradient) }
                .foregroundColor(.white)
            }
        }
        .padding()
    }
    
    private var filterCard: some View {
        HStack (alignment: .center) {
            Image(displayImageWRTTime())
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 30, height: 150)
                .mask {
                    Rectangle().clipShape(Capsule())
                }
                .overlay {
                    Text(displayGreetingTextForPills())
                        .kerning(3)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background {
                            Color.black.opacity(0.5)
                        }
                        .clipShape(Capsule())
                }
        }
    }
    
    private func medicineCard(_ pills: PillsEntity) -> some View {
        VStack {
            HStack (alignment: .top) {
                Image(systemName: "pill")
                    .font(.system(size: 35, weight: .medium))
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(22)
                
                VStack (alignment: .leading, spacing: 3) {
                    Text(pills.medicineName ?? "Vitamin C")
                        .font(.title3).fontWeight(.semibold)
                    Text("\(pills.medicineForm?.capitalized ?? "") \(pills.intake?.lowercased() ?? "")")
                        .font(.headline).fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Text("\(pillsViewModel.convertTimeToDays(pills) > 1 ? "\(pillsViewModel.convertTimeToDays(pills)) days" : "\(pillsViewModel.convertTimeToDays(pills)) day")")
                    .font(.footnote).fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 5)
                    .background {
                        LinearGradient (
                            gradient: Gradient(
                                colors: [
                                    Color(K.BrandColors.pastelOrange),
                                    Color(K.BrandColors.pink)
                                ]
                            ),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 10)
        .background {Color.gray.opacity(0.1)}
        .cornerRadius(22, corners: [.topLeft, .bottomRight])
        .padding(.horizontal, 10)
        .shadow(color: Color.black.opacity(0.3), radius: 5)
    }
}
