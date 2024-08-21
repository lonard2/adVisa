//
//  GeneralInformationForm.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct GeneralInformationForm: View {
    
    @ObservedObject var viewModel: VisaPromptViewModel
    
    var body: some View {
        Text("Japan Visa")
            .font(.system(size: 24))
            .fontWeight(.semibold)
        
        VStack(alignment: .leading, spacing: 12) {
            Text("How long do you want to go?")
                .font(.system(size: 17))
                .fontWeight(.semibold)
            
            HStack() {
                DatePicker("", selection: $viewModel.startDate, in: Date()...,  displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .onChange(of: viewModel.startDate, {
                        if viewModel.endDate < viewModel.startDate {
                            viewModel.endDate = viewModel.startDate
                        }
                })
                
                Text(" - ")
                
                DatePicker("", selection: $viewModel.endDate, in: viewModel.startDate..., displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
            }
            
        }
        
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Which Passport do you own?")
                .font(.system(size: 17))
                .fontWeight(.semibold)
            
            Picker(selection: $viewModel.passportType) {
                VStack {
                    Image("Passport")
                    Text("Regular Passport")
                }.tag("Regular Passport")
                
                VStack {
                    Image("e_passport")
                    Text("E-Passport")
                }.tag("E-Passport")
                
            } label: {
                Text("Passport Type")
            }
            
        }
        
        VStack(alignment: .leading, spacing: 12) {
            Text("What is your purpose of visiting Japan?")
                .font(.system(size: 17))
                .fontWeight(.semibold)
            
            Picker(selection: $viewModel.travelPurpose) {
                Text("Holiday").tag("Holiday")
                
            } label: {
                Text("Travel Purpose")
            }
        }
        
        Spacer()
        
        Button {
            
            viewModel.nextForm()
            
        } label: {
            Text("Continue")
                .padding(.vertical, 7)
                .frame(maxWidth: .infinity)
                .font(.system(size: 15))
                .foregroundStyle(Color(.primaryWhite))
                .background(Color.primaryBlue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    GeneralInformationForm(viewModel: VisaPromptViewModel())
}
