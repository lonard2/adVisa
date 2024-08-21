//
//  VisaFormPage.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct VisaFormPage: View {
    
    @StateObject var viewModel = VisaFormViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ZStack{
                    Image("visa_header")
                        .resizable()
                        .scaledToFit()
                    
                    VStack(spacing: 20) {
                        Image("step_2")
                            .resizable()
                            .scaledToFit()
                        
                        VStack(spacing: 8) {
                            Text("VISA FORM")
                                .foregroundStyle(Color(.primaryWhite))
                                .font(.system(size: 22))
                                .bold()
                            
                            Text("We want to confirm some things...")
                                .foregroundStyle(Color(.primaryWhite))
                                .font(.system(size: 15))
                        }
                    }
                    .offset(y: -36)
                }
                .background(Color(.primaryBlue))
                
                VStack(spacing: 20) {
                    
                    switch(viewModel.pageStep) {
                        
                    case 1:
                        OtherNameForm(viewModel: viewModel)
                                            
                    case 2:
                        NationalityForm(viewModel: viewModel)
                        
                    case 3:
                        CurrentAddressForm(viewModel: viewModel)
                        
                    case 4:
                        ContactInformationForm(viewModel: viewModel)
                        
                    case 5:
                        CompanyInformationForm(viewModel: viewModel)
                        
                    case 6:
                        PreviousVisitForm(viewModel: viewModel)
                        
                    case 7:
                        GuarantorForm(viewModel: viewModel)
                        
                    case 8:
                        InviterForm(viewModel: viewModel)
                        
                    case 9:
                        CrimeRecordForm(viewModel: viewModel)
                        
                    case 10:
                        CrimeDetailForm(viewModel: viewModel)
                        
                    default:
                        Text("Page Error to Load...")
                            .font(.title)
                    }
                    
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 16)
                .background(Color(.primaryWhite))
                
                Spacer()
            }
        }
    }
}

#Preview {
    VisaFormPage()
}
