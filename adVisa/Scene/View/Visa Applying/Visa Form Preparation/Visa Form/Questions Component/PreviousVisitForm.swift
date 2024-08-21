//
//  PreviousVisitForm.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct PreviousVisitForm: View {
    @ObservedObject var viewModel: VisaFormViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 23) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Have you ever been to Japan before?")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                Picker(selection: $viewModel.everBeenToJapan) {
                    Text("Yes").tag(true)
                    Text("No").tag(false)
                    
                } label: {
                    Text("otherName")
                }
                .pickerStyle(.palette)
            }
            
            if(viewModel.everBeenToJapan) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("For how many days?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        Stepper(value: $viewModel.dayCountInJapanBefore, in: 0...365) {
                            TextField("Days", value: $viewModel.dayCountInJapanBefore, formatter: NumberFormatter())
                                .padding(.vertical, 4)
                                .background(Color(.primaryWhite))
                                .frame(maxWidth: .infinity)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.defaultGray, lineWidth: 0.5))
                                .multilineTextAlignment(.center)
                        }
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
    PreviousVisitForm(viewModel: VisaFormViewModel())
}
