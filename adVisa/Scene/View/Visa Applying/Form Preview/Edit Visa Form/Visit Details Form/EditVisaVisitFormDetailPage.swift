//
//  EditVisaVisitDetailPage.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct EditVisaVisitDetailFormPage: View {
    @ObservedObject var viewModel = EditVisaFormViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 10){
                Text("Visit Details")
                    .foregroundStyle(Color(.primaryWhite))
                    .font(.system(size: 22))
                    .bold()
                
                Text("Preview and complete your visit details")
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
                    EditVisitMeansForm(viewModel: viewModel)
                    
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
    EditVisaVisitDetailFormPage()
}
