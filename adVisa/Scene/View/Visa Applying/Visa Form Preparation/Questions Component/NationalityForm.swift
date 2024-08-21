//
//  NationalityForm.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct NationalityForm: View {
    @ObservedObject var viewModel: VisaFormViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 23) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Have you registered to other nationality before?")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                Picker(selection: $viewModel.hasPriorNationality) {
                    Text("Yes").tag(true)
                    Text("No").tag(false)
                    
                } label: {
                    Text("priorNationality")
                }
                .pickerStyle(.palette)
            }
            
            if(viewModel.hasPriorNationality) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("What was it?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        TextField("Prior Nationality", text: $viewModel.priorNationality)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 6)
                            .background(Color(.primaryWhite))
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Do you have any other nationality")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                Picker(selection: $viewModel.hasOtherNationality) {
                    Text("Yes").tag(true)
                    Text("No").tag(false)
                    
                } label: {
                    Text("otherNationality")
                }
                .pickerStyle(.palette)
            }
            
            if(viewModel.hasOtherNationality) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("What was it?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        TextField("Other Nationality", text: $viewModel.otherNationality)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 6)
                            .background(Color(.primaryWhite))
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
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
    NationalityForm(viewModel: VisaFormViewModel())
}
