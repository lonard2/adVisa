//
//  RedirectJavesPage.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct RedirectJavesPage: View {
    var body: some View {
        VStack {
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Visa Exemption")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.primaryWhite))
                
                Text("Japan Visa Exemption allows Indonesian citizens with an e-passport to visit Japan visa-free for up to 15 days.")
                    .font(.system(size: 12))
                    .foregroundStyle(Color(.primaryWhite))
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(Color(.primaryBlue))
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Document Requirement")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.primaryBlack))
                
                VStack {
                    HStack(spacing: 5) {
                        Image("e_passport")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 58.3)
                        
                        VStack(alignment:.leading, spacing: 7) {
                            Text("Electronic Passport")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.primaryBlack))
                            
                            Text("E-passport must be valid for at least six months beyond their intended stay in Japan.")
                                .font(.system(size: 12))
                                .foregroundStyle(Color(.darkerGray))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 11)
                .padding(.vertical, 8)
                .background(Color(.blueTint))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack {
                    HStack(spacing: 5) {
                        Image("e_passport")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 58.3)
                        
                        VStack(alignment:.leading, spacing: 7) {
                            Text("Departure and Arrival Date")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.primaryBlack))
                            
                            Text("Japan's visa exemption allows a 15-day stay, confirmed by a valid flight booking.")
                                .font(.system(size: 12))
                                .foregroundStyle(Color(.darkerGray))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 11)
                .padding(.vertical, 8)
                .background(Color(.blueTint))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment:.leading, spacing: 4) {
                    Text("Javes Website Preview")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.primaryBlack))
                    
                    Text("To apply for Japan's visa exemption, you have to apply in the official website of the Japan Visa Application Agency (JVAC)")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(.darkerGray))
                }
                .padding(10)
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.primaryWhite))
            .frame(maxWidth: .infinity)
            
            VStack {
                Spacer()
                
                Image("javes_homepage")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity)
            .background(Color(.blueTint))
            
            VStack {
                Link("Apply via JAVES", destination: URL(string: "https://www.evisa.mofa.go.jp/personal/logintoko")!)
                    .padding(.vertical, 7)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 15))
                    .foregroundStyle(Color(.primaryWhite))
                    .background(Color.primaryBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 16)
            
        }
    }
}

#Preview {
    RedirectJavesPage()
}
