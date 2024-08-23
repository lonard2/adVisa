//
//  GuarantorForm.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct GuarantorForm: View {
    @ObservedObject var viewModel: VisaFormViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 23) {
            ScrollView() {
                VStack(alignment: .leading, spacing: 23) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Do you have any guarantor in Japan?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        Picker(selection: $viewModel.hasGuarantor) {
                            Text("Yes").tag(true)
                            Text("No").tag(false)
                            
                        } label: {
                            Text("hasGuarantor")
                        }
                        .pickerStyle(.palette)
                    }
                    
                    if(viewModel.hasGuarantor) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("They are...")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            Picker(selection: $viewModel.guarantorGender) {
                                Text("Male").tag(GenderEnum.male)
                                Text("Female").tag(GenderEnum.female)
                                
                            } label: {
                                Text("guarantorGender")
                            }
                            .pickerStyle(.palette)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What is \(viewModel.guarantorGender == GenderEnum.male ? "his" : "her") name?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Guarantor's Name", text: $viewModel.guarantorName)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What is \(viewModel.guarantorGender == GenderEnum.male ? "his" : "her") phone number?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Guarantor's Phone Number", text: $viewModel.guarantorPhoneNumber)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                                .keyboardType(.numbersAndPunctuation)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Where does \(viewModel.guarantorGender == GenderEnum.male ? "he" : "she") live?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Guarantor's Address", text: $viewModel.guarantorAddress)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("When does \(viewModel.guarantorGender == GenderEnum.male ? "he" : "she") born?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            DatePicker("", selection: $viewModel.guarantorBirthDate, displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What is your relationship \(viewModel.guarantorGender == GenderEnum.male ? "him" : "her")?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Guarantor's Relationship With You", text: $viewModel.relationshipWithGuarantor)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What is \(viewModel.guarantorGender == GenderEnum.male ? "his" : "her") job?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Guarantor's Job", text: $viewModel.guarantorJob)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What is \(viewModel.guarantorGender == GenderEnum.male ? "his" : "her") position in that job?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Guarantor's Position", text: $viewModel.guarantorJobPosition)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What is \(viewModel.guarantorGender == GenderEnum.male ? "his" : "her") nationality?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Guarantor's Nationality", text: $viewModel.guarantorNationality)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What is \(viewModel.guarantorGender == GenderEnum.male ? "his" : "her") immigration status?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Guarantor's Immigration Status", text: $viewModel.guarantorImmigrationStatus)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        }
                        
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        
        Spacer()
        
        Button {
            if viewModel.hasGuarantor {
                viewModel.saveGuarantorData()
            }
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
    }
}

#Preview {
    GuarantorForm(viewModel: VisaFormViewModel())
}
