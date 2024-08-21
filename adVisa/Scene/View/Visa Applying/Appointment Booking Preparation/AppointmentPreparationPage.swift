//
//  AppointmentPreparationPage.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct AppointmentPreparationPage: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Text("File Compiled!")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                
                Image("preparation_complete")
                    .resizable()
                    .scaledToFit()
            }
            
            VStack(spacing: 16){
                VStack {
                    Text("We’ve compiled your documents and put it in the required order in a single file and saved it to your storage. In order to get your Visa application processed, ")
                    
                    +
                    
                    Text("you still need to bring these documents in person to the nearest VFS Global office. ")
                        .bold()
                    
                    +
                    
                    Text("You can book an appointment with them through VFS Global’s website before go to their office.")
                }
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                
                Text("You need to bring these documents in their original form:")
                    .font(.system(size: 17))
                    .bold()
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 12) {
                    HStack {
                        Text("Passport")
                            .foregroundStyle(Color(.primaryBlack))
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                    }
                    .padding(16)
                    .background(Color(.primaryWhite))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .accentGreen ,radius: 4)
                    
                    HStack {
                        Text("Self Potrait (4,5 x 3,5cm)")
                            .foregroundStyle(Color(.primaryBlack))
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                    }
                    .padding(16)
                    .background(Color(.primaryWhite))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .accentGreen ,radius: 4)
                }

            }
            
            Spacer()
            
            VStack(spacing: 20) {
                NavigationLink {
                    
                } label: {
                    Text("Book Appointment")
                        .padding(.vertical, 7)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 15))
                        .foregroundStyle(Color(.primaryWhite))
                        .background(Color.primaryBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                NavigationLink {
                    
                } label: {
                    Text("Book Later")
                        .padding(.vertical, 7)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 15))
                        .foregroundStyle(Color(.primaryBlue))
                }
                
            }
            .padding(12)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 32)
    }
}

#Preview {
    AppointmentPreparationPage()
}
