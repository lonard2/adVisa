//
//  FormPreviewPage.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct FormPreviewPage: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ZStack{
                    Image("visa_header")
                        .resizable()
                        .scaledToFit()
                    
                    VStack(spacing: 20) {
                        Image("step_4")
                            .resizable()
                            .scaledToFit()
                        
                        VStack(spacing: 8) {
                            Text("FORMS PREVIEW")
                                .foregroundStyle(Color(.primaryWhite))
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                            
                            Text("Preview and confirm your generated forms.")
                                .foregroundStyle(Color(.primaryWhite))
                                .font(.system(size: 15))
                        }
                    }
                    .offset(y: -36)
                }
                .background(Color(.primaryBlue))
                
                VStack(spacing: 12) {
                    
                    NavigationLink {
                        VisaFormConfirmationPage()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text("Visa Application Form")
                                .foregroundStyle(Color(.primaryBlack))
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.primaryBlack))
                                .font(.system(size: 15))
                            
                        }
                        .padding(16)
                        .background(Color(.primaryWhite))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(color: .black.opacity(0.25) ,radius: 4)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        AppointmentPreparationPage()
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
    FormPreviewPage()
}
