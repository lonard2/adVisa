//
//  VisaFormConfirmationPage.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct VisaFormConfirmationPage: View {
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
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            VStack {
                                Image("template")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .padding(12)
                            }
                            .background(Color(.primaryWhite))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.25), radius: 4)
                            
                            VStack {
                                Image("template")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .padding(12)
                            }
                            .background(Color(.primaryWhite))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.25), radius: 4)
                        }
                        .padding(12)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                Spacer()
                
                VStack(spacing: 20) {
                    NavigationLink {
                        
                    } label: {
                        Text("Confirm")
                            .padding(.vertical, 7)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.primaryWhite))
                            .background(Color.primaryBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    NavigationLink {
                        
                    } label: {
                        Text("Edit Form")
                            .padding(.vertical, 7)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.primaryBlue))
                    }

                }
                .padding(12)
            }
        }
    }
}

#Preview {
    VisaFormConfirmationPage()
}
