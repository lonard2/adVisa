//
//  ItineraryFormConfirmationPage.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct ItineraryFormConfirmationPage: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack{
                    Text("Visa Application Form")
                        .foregroundStyle(Color(.primaryWhite))
                        .font(.system(size: 22))
                        .bold()
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(Color(.primaryBlue))
                
                VStack {
                    TabView {
                        Image("template")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(12)
                    }
                    .tabViewStyle(.page)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                Spacer()
                
                VStack(spacing: 20) {
                    NavigationLink {
                        
                    } label: {
                        Text("Confirm")
                            .padding(.vertical, 7)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.primaryBlue))
                            .background(Color.primaryWhite)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    NavigationLink {
                        
                    } label: {
                        Text("Edit Form")
                            .padding(.vertical, 7)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.primaryWhite))
                    }
                    
                }
                .padding(12)
                .background(Color(.primaryBlue))
            }
        }
    }
}

#Preview {
    ItineraryFormConfirmationPage()
}
