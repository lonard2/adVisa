//
//  CompanyInformationForm.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct CompanyInformationForm: View {
    @ObservedObject var viewModel: VisaFormViewModel
    
    var body: some View {
        VStack(spacing: 23) {
            VStack(alignment: .leading, spacing: 8) {
                Text("The company name you currently work for:")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                TextField("Company Name", text: $viewModel.companyName)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 6)
                    .background(Color(.primaryWhite))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("The company's address:")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                TextField("Company's Address", text: $viewModel.companyAddress)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 6)
                    .background(Color(.primaryWhite))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("The company's phone number:")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                TextField("Company's Phone Number", text: $viewModel.companyPhoneNumber)
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
    CompanyInformationForm(viewModel: VisaFormViewModel())
}
