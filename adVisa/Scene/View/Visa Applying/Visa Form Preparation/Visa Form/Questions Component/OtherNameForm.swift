//
//  OtherNameForm.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct OtherNameForm: View {
    @ObservedObject var viewModel: VisaFormViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 23) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Do you have other names registered legally before?")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                Picker(selection: $viewModel.hasOtherName) {
                    Text("Yes").tag(true)
                    Text("No").tag(false)
                    
                } label: {
                    Text("otherName")
                }
                .pickerStyle(.palette)
            }
            
            if(viewModel.hasOtherName) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("What was it?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        TextField("Prior Legal Names", text: $viewModel.otherName)
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
    OtherNameForm(viewModel: VisaFormViewModel())
}
