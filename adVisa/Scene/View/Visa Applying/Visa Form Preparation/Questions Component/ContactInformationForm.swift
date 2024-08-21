//
//  contactInformationForm.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct ContactInformationForm: View {
    @ObservedObject var viewModel: VisaFormViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 23) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Do your current address have a telephone number?")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                Picker(selection: $viewModel.hasHomeTelephone) {
                    Text("Yes").tag(true)
                    Text("No").tag(false)
                    
                } label: {
                    Text("otherName")
                }
                .pickerStyle(.palette)
            }
            
            if(viewModel.hasHomeTelephone) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your current address telephone number:")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        TextField("Home Telephone Number", text: $viewModel.currentAddress)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 6)
                            .background(Color(.primaryWhite))
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                            .keyboardType(.numbersAndPunctuation)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Your current mobile phone number:")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                TextField("Mobile Phone Number", text: $viewModel.currentAddress)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 6)
                    .background(Color(.primaryWhite))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                    .keyboardType(.numbersAndPunctuation)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Your current email address:")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                TextField("Email Address", text: $viewModel.currentAddress)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 6)
                    .background(Color(.primaryWhite))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
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
    ContactInformationForm(viewModel: VisaFormViewModel())
}
