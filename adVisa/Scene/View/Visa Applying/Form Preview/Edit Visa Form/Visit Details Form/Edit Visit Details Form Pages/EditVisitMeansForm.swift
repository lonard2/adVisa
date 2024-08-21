//
//  EditVisitMeansForm.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct EditVisitMeansForm: View {
    @ObservedObject var viewModel: EditVisaFormViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Purpose of Visit")
                        .font(.system(size: 17))
                    
                    Picker(selection: $viewModel.purposeOfVisit) {
                        Text("Holiday").tag("Holiday")
                        
                    } label: {
                        Text("purposeOfVisit")
                    }
                    .disabled(true)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Port of Entry")
                        .font(.system(size: 17))
                    
                    TextField("Airport or Harbour you arrive at", text: $viewModel.portOfEntry)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        .textInputAutocapitalization(.words)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cruise line or Airline Name")
                        .font(.system(size: 17))
                    
                    TextField("Name of flight or cruise organization", text: $viewModel.shipAirplaneName)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        .textInputAutocapitalization(.words)
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
    EditVisitMeansForm(viewModel: EditVisaFormViewModel())
}
