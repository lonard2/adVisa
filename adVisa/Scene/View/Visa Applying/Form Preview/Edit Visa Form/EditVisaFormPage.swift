//
//  EditVisaFormPage.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct EditVisaFormPage: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 10){
                    Text("VISA FORM")
                        .foregroundStyle(Color(.primaryWhite))
                        .font(.system(size: 22))
                        .bold()
                    
                    Text("Preview and complete your data")
                        .foregroundStyle(Color(.primaryWhite))
                        .font(.system(size: 15))
                    
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(Color(.primaryBlue))
                
                VStack(spacing: 12) {
                    
                    NavigationLink {
                        EditPersonalDataFormPage()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text("Personal Data")
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
                    
                    NavigationLink {
                        EditVisaVisitDetailFormPage()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text("Visit Details")
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
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
                .background(Color(.primaryWhite))
                
                Spacer()
            }
        }
    }
}

#Preview {
    EditVisaFormPage()
}
