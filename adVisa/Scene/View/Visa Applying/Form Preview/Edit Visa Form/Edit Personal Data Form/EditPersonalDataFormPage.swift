//
//  PersonalDataFormPage.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct EditPersonalDataFormPage: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel = EditVisaFormViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 10){
                Text("Personal Data")
                    .foregroundStyle(Color(.primaryWhite))
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                
                Text("Preview and complete your personal data")
                    .foregroundStyle(Color(.primaryWhite))
                    .font(.system(size: 15))
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(Color(.primaryBlue))
            
            VStack {
                switch(viewModel.pageStep) {
                    
                case 1:
                    EditBiodataForm(viewModel: viewModel)
                    
                case 2:
                    EditPassportDataForm(viewModel: viewModel)
                    
                    Button {
                        dismiss()
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
                    
                default:
                    Text("Page Error to Load...")
                        .font(.title)
                    
                    Spacer()
                }
            }
            .padding(.vertical, 20)
        }
    }
}

#Preview {
    EditPersonalDataFormPage()
}
