//
//  PersonalDataFormPage.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct EditPersonalDataFormPage: View {
    
    @ObservedObject var viewModel = EditVisaFormViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 10){
                Text("VISA FORM")
                    .foregroundStyle(Color(.primaryWhite))
                    .font(.system(size: 22))
                    .bold()
                
                Text("Preview and complete your data")
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
                    
                default:
                    Text("Page Error to Load...")
                        .font(.title)
                }
            }
            .padding(.vertical, 20)
        }
    }
}

#Preview {
    EditPersonalDataFormPage()
}
