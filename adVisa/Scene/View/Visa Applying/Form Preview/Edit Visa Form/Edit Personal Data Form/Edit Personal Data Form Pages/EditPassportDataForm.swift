//
//  EditPassportDataForm.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct EditPassportDataForm: View {
    @ObservedObject var viewModel: EditVisaFormViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Passport Type")
                        .font(.system(size: 17))
                    
                    Picker(selection: $viewModel.passportType) {
                        Text("Official").tag(PassportTypeEnum.official)
                        Text("Diplomatic").tag(PassportTypeEnum.diplomatic)
                        Text("Ordinary").tag(PassportTypeEnum.ordinary)
                        Text("Other").tag(PassportTypeEnum.other)
                        
                    } label: {
                        Text("passportType")
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Passport No.")
                        .font(.system(size: 17))
                    
                    TextField("Your Passport Number", text: $viewModel.passportNumber)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        .textInputAutocapitalization(.words)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Passport Place of Issue")
                        .font(.system(size: 17))
                    
                    TextField("The City Your Passport Issued In", text: $viewModel.passportPlaceOfIssue)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        .textInputAutocapitalization(.words)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Passport Date of Issue")
                        .font(.system(size: 17))
                    
                    DatePicker("", selection: $viewModel.passportDateOfIssue, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Passport Issuing Authority")
                        .font(.system(size: 17))
                    
                    TextField("Authority That Issue Your Passport", text: $viewModel.passportPlaceOfIssue)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Passport Date of Issue")
                        .font(.system(size: 17))
                    
                    DatePicker("", selection: $viewModel.passportExpiredDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                }
                
            }
            .padding(.horizontal, 36)
            .padding(.vertical, 24)
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
                .background(Color(.primaryBlue))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(12)
    }
}

#Preview {
    EditPassportDataForm(viewModel: EditVisaFormViewModel())
}
