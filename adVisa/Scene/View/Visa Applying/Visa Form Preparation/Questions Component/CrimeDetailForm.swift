//
//  CrimeDetailForm.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct CrimeDetailForm: View {
    @ObservedObject var viewModel: VisaFormViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 23) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("If you check one of the boxes, please explain more.")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                TextField("More Details...", text: $viewModel.crimeDetails)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 6)
                    .background(Color(.primaryWhite))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        
        Spacer()
        
        NavigationLink {
            ItineraryDetailsPage()
                .navigationBarBackButtonHidden(true)
        } label: {
            Text("Continue")
                .padding(.vertical, 7)
                .frame(maxWidth: .infinity)
                .font(.system(size: 15))
                .foregroundStyle(Color(.primaryWhite))
                .background(Color(.primaryBlue))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .onTapGesture {
            viewModel.resetFormPage()
        }
    }
}

#Preview {
    CrimeDetailForm(viewModel: VisaFormViewModel())
}
