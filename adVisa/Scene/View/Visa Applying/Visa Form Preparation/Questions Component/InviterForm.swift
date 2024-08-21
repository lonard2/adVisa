//
//  InviterForm.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct InviterForm: View {
    @ObservedObject var viewModel: VisaFormViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 23) {
            ScrollView() {
                VStack(alignment: .leading, spacing: 23) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Does someone officially invite you to visit Japan?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        Picker(selection: $viewModel.hasInviter) {
                            Text("Yes").tag(true)
                            Text("No").tag(false)
                            
                        } label: {
                            Text("hasInviter")
                        }
                        .pickerStyle(.palette)
                    }
                    
                    if(viewModel.hasInviter) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Are they the same person as your guarantor?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            Picker(selection: $viewModel.inviterSameAsGuarantor) {
                                Text("Yes").tag(true)
                                Text("No").tag(false)
                                
                            } label: {
                                Text("inviterSameAsGuarantor")
                            }
                            .pickerStyle(.palette)
                        }
                    }
                    
                    if(viewModel.hasInviter && !viewModel.inviterSameAsGuarantor) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("They are...")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            Picker(selection: $viewModel.inviterGender) {
                                Text("Male").tag(GenderEnum.male)
                                Text("Female").tag(GenderEnum.female)
                                
                            } label: {
                                Text("inviterGender")
                            }
                            .pickerStyle(.palette)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What is \(viewModel.inviterGender == GenderEnum.male ? "his" : "her") Name?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Inviter's Name", text: $viewModel.inviterName)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Where does \(viewModel.inviterGender == GenderEnum.male ? "he" : "she") live?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Inviter's Address", text: $viewModel.inviterAddress)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("When does \(viewModel.inviterGender == GenderEnum.male ? "he" : "she") born?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            DatePicker("", selection: $viewModel.inviterBirthDate, displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What is your relationship \(viewModel.inviterGender == GenderEnum.male ? "him" : "her")?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Inviter's Relationship With You", text: $viewModel.relationshipWithInviter)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What is \(viewModel.inviterGender == GenderEnum.male ? "his" : "her") job?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Inviter's Job", text: $viewModel.inviterJob)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What is \(viewModel.inviterGender == GenderEnum.male ? "his" : "her") position in that job?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Inviter's Position", text: $viewModel.inviterJobPosition)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color(.primaryWhite))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What is \(viewModel.inviterGender == GenderEnum.male ? "his" : "her") nationality?")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                            TextField("Your Inviter's Nationality", text: $viewModel.inviterJobPosition)
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
    InviterForm(viewModel: VisaFormViewModel())
}
