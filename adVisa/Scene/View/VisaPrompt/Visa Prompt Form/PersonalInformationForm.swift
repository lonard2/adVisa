//
//  PersonalInformationForm.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct PersonalInformationForm: View {
    
    @ObservedObject var viewModel: VisaPromptViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Have your ever go to Fukushima/ Miyagi/ Iwate/ Okinawa?")
                .font(.system(size: 17))
                .fontWeight(.semibold)
            
            Picker(selection: $viewModel.visitedPlaces) {
                Text("Yes").tag(true)
                Text("No").tag(false)
                
            } label: {
                Text("visitedPlace")
            }
            .pickerStyle(.palette)
        }
        
        VStack(alignment: .leading, spacing: 12) {
            Text("Are you a student?")
                .font(.system(size: 17))
                .fontWeight(.semibold)
            
            Picker(selection: $viewModel.isStudent) {
                Text("Yes").tag(true)
                Text("No").tag(false)
                
            } label: {
                Text("isStudent")
            }
            .pickerStyle(.palette)
        }
        
        Spacer()
        
        NavigationLink {
            DocumentRequirementPage()
                .navigationBarBackButtonHidden(true)
                .onAppear{
                    viewModel.saveTraveData()
                }
        } label: {
            Text("Continue")
                .padding(.vertical, 7)
                .frame(maxWidth: .infinity)
                .font(.system(size: 15))
                .foregroundStyle(Color(.primaryWhite))
                .background(Color.primaryBlue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    PersonalInformationForm(viewModel: VisaPromptViewModel())
}
