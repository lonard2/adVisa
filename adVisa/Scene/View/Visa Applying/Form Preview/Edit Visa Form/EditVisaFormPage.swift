//
//  EditVisaFormPage.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct EditVisaFormPage: View {
    var body: some View {
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
                        
                        Text("Preview and complete your data")
                            .foregroundStyle(Color(.primaryWhite))
                            .font(.system(size: 15))
                    }
                }
                .offset(y: -36)
            }
            .background(Color(.primaryBlue))
            
            VStack(spacing: 12) {
                
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
                .frame(width: .infinity, height: .infinity)
                
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
                .frame(width: .infinity, height: .infinity)
                
                HStack {
                    Text("Occupancy Details")
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
                .frame(width: .infinity, height: .infinity)
                
                HStack {
                    Text("Guarantor/Inviter Details")
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
                .frame(width: .infinity, height: .infinity)
                
                HStack {
                    Text("Criminal History")
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
                .frame(width: .infinity, height: .infinity)
                
                
                
                Spacer()
                
                Button {
                    
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

#Preview {
    EditVisaFormPage()
}
