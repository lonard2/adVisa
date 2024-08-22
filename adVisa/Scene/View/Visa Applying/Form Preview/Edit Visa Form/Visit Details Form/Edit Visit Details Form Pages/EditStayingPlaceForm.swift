//
//  EditStayingPlaceForm.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct EditStayingPlaceForm: View {
    @ObservedObject var viewModel: EditVisaFormViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Name of Place You Intends to Stay")
                        .font(.system(size: 17))
                    
                    TextField("Your Accomodation Name", text: $viewModel.portOfEntry)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Address of Place You Intends yo Stay")
                        .font(.system(size: 17))
                    
                    TextField("Your Accomodation Address", text: $viewModel.shipAirplaneName)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Phone No. of Place You Intends to Stay")
                        .font(.system(size: 17))
                    
                    TextField("Your Accomodation Phone Number", text: $viewModel.shipAirplaneName)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color(.primaryWhite))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                        .keyboardType(.numbersAndPunctuation)
                }
                
            }
            .padding(.horizontal, 36)
            .padding(.vertical, 24)
        }
        
        Spacer()
    }
}

#Preview {
    EditStayingPlaceForm(viewModel: EditVisaFormViewModel())
}
