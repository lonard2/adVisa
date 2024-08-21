//
//  BiodataForm.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct EditBiodataForm: View {
    @ObservedObject var viewModel: EditVisaFormViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Surname")
                        .font(.system(size: 17))
                    
                    TextField("Your Surname", text: $viewModel.surname)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Given & Middle Names")
                        .font(.system(size: 17))
                    
                    TextField("Your Given and Middle Name", text: $viewModel.givenName)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Date of Birth")
                        .font(.system(size: 17))
                    
                    DatePicker("", selection: $viewModel.birthDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Place of Birth")
                        .font(.system(size: 17))
                    
                    TextField("City, Province, Country", text: $viewModel.givenName)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        .textInputAutocapitalization(.words)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Sex")
                        .font(.system(size: 17))
                    
                    Picker(selection: $viewModel.sex) {
                        Text("Male").tag(GenderEnum.male)
                        Text("Female").tag(GenderEnum.female)
                        
                    } label: {
                        Text("gender")
                    }
                    .pickerStyle(.palette)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Marital Status")
                        .font(.system(size: 17))
                    
                    Picker(selection: $viewModel.maritalStatus) {
                        Text("Single").tag(MaritalStatusEnum.single)
                        Text("Married").tag(MaritalStatusEnum.married)
                        Text("Divorced").tag(MaritalStatusEnum.divorced)
                        Text("Widowed").tag(MaritalStatusEnum.widowed)
                        
                    } label: {
                        Text("maritalStatus")
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nationality")
                        .font(.system(size: 17))
                    
                    TextField("Your current nationality", text: $viewModel.nationality)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        .textInputAutocapitalization(.words)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("ID no.")
                        .font(.system(size: 17))
                    
                    TextField("Your Identity Card Number", text: $viewModel.idNumber)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        .keyboardType(.numberPad)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Current Proffession")
                        .font(.system(size: 17))
                    
                    TextField("Your Current Proffession", text: $viewModel.proffesion)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
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
    EditBiodataForm(viewModel: EditVisaFormViewModel())
}
