//
//  AddPills.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 19/01/23.
//

import SwiftUI

struct AddPills: View {
    @Environment(\.dismiss) private var dismissMode
    @State private var medicineName: String = ""
    @State private var selectMedicineForm = 0
    @State private var howToUse = 0
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    var body: some View {
        VStack {
            ZStack (alignment: .topLeading) {
                Image("addpillsbg")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 380)
                    .overlay {
                        VStack (alignment: .leading, spacing: 20) {
                            nameOfMedicine
                            
                            medicineForm
                            
                            intakeGuidance
                            
                            beginDateText
                            
                            endDateText
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(K.BrandColors.pastelBlue3).gradient)
                        .cornerRadius(30)
                        .padding()
                        .offset(y: 380)
                        .shadow(color: Color.black.opacity(0.3), radius: 5)
                    }
                
                MTGlassButton(iconName: K.SFSymbols.chevDown, iconSize: 22, action: {self.dismissMode()})
                    .padding()
                    .padding(.top, 30)
            }
            
            Spacer()
            
            MTButton(action: {}, title: "Save changes", hexCode: K.BrandColors.pink)
                .padding()
                .disabled(medicineName == "")
        }
        .padding(.bottom, 20)
        .ignoresSafeArea()
    }
}

struct AddPills_Previews: PreviewProvider {
    static var previews: some View {
        AddPills()
    }
}

extension AddPills {
    private var nameOfMedicine: some View {
        VStack {
            TextField("Please enter name of medicine", text: $medicineName)
                .customFont(16, weight: .regular)
                .foregroundColor(.black)
                .padding(.top, 2)
        }
        .padding()
        .padding([.top, .bottom], 10)
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.white.opacity(0.7), lineWidth: 1)
        }
    }
    
    private var medicineForm: some View {
        HStack {
            Text("Form of medicine")
            Spacer()
            Picker("Medicine Form", selection: $selectMedicineForm) {
                ForEach(0..<K.medicineForm.count, id: \.self) {
                    Text(K.medicineForm[$0]).tag($0)
                        .font(.headline).fontWeight(.semibold)
                }
            }.accentColor(.black)
        }
        .padding()
        .padding([.top, .bottom], 10)
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.white.opacity(0.7), lineWidth: 1)
        }
    }
    
    private var intakeGuidance: some View {
        HStack {
            Text("How to use")
            Spacer()
            Picker("How to use", selection: $howToUse) {
                ForEach(0..<K.howToUse.count, id: \.self) {
                    Text(K.howToUse[$0]).tag($0)
                }
            }
            .accentColor(.black)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.white.opacity(0.6), lineWidth: 1)
        }
    }
    
    private var beginDateText: some View {
        HStack (spacing: 12) {
            Text("Begin: \(startDate.toString("EE dd MMMM"))").customFont(16, weight: .regular)
            Spacer()
            // MARK: Custom Date Picker
            Image(systemName: K.SFSymbols.calendar)
                .font(.title3)
                .foregroundColor(.black)
                .overlay {
                    DatePicker("", selection: $startDate, displayedComponents: [.date])
                        .blendMode(.destinationOver)
                }
        }
        .padding()
        .padding([.top, .bottom], 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.white.opacity(0.7), lineWidth: 1)
        }
    }
    
    private var endDateText: some View {
        HStack (spacing: 12) {
            Text("Finish: \(startDate.toString("EE dd MMMM"))").customFont(16, weight: .regular)
            Spacer()
            // MARK: Custom Date Picker
            Image(systemName: K.SFSymbols.calendar)
                .font(.title3)
                .foregroundColor(.black)
                .overlay {
                    DatePicker("", selection: $endDate, displayedComponents: [.date])
                        .blendMode(.destinationOver)
                }
        }
        .padding()
        .padding([.top, .bottom], 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.white.opacity(0.8), lineWidth: 1)
        }
    }
}
