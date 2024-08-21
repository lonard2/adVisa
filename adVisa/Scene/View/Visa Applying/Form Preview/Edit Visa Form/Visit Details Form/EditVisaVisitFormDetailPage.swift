//
//  EditVisaVisitDetailPage.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct EditVisaVisitDetailFormPage: View {
    @Environment(\.dismiss) private var dismiss
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
                    EditStayingPlaceForm(viewModel: viewModel)
                    
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
    EditVisaVisitDetailFormPage()
}
