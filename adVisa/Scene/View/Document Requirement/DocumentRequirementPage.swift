//
//  DocumentRequirementPage.swift
//  adVisa
//
//  Created by Dixon Willow on 19/08/24.
//

import SwiftUI

struct DocumentRequirementPage: View {
    
    @State private var isDone: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack{
                Image("visa_header")
                
                VStack(spacing: 20) {
                    Image("step_1")
                    
                    VStack(spacing: 8) {
                        Text("DOCUMENT REQUIREMENT")
                            .foregroundStyle(Color(.primaryWhite))
                            .font(.system(size: 22))
                            .bold()
                        
                        Text("Prepare and input your document")
                            .foregroundStyle(Color(.primaryWhite))
                            .font(.system(size: 15))
                    }
                }
                .offset(y: -36)
            }
            .background(Color(.primaryBlue))
            
            VStack(spacing: 20) {
                
                HStack {
                    HStack(spacing: 12) {
                        Image(systemName: "airplane.departure")
                            .foregroundStyle(Color(.primaryBlack))
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        
                        Text("Away Flight Booking")
                            .foregroundStyle(Color(.primaryBlack))
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isDone ? "checkmark.circle.fill" : "circle.fill")
                        .foregroundStyle(Color(isDone ? .accentGreen : .defaultGray))
                        .font(.system(size: 22))
                }
                .padding(16)
                .background(Color(.primaryWhite))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color(isDone ? .accentGreen : .gray), radius: 4)
                .frame(width: .infinity, height: .infinity)
                
                HStack {
                    HStack(spacing: 12) {
                        Image(systemName: "airplane.arrival")
                            .foregroundStyle(Color(.primaryBlack))
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        
                        Text("Return Flight Booking")
                            .foregroundStyle(Color(.primaryBlack))
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isDone ? "checkmark.circle.fill" : "circle.fill")
                        .foregroundStyle(Color(isDone ? .accentGreen : .defaultGray))
                        .font(.system(size: 22))
                }
                .padding(16)
                .background(Color(.primaryWhite))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color(isDone ? .accentGreen : .gray), radius: 4)
                .frame(width: .infinity, height: .infinity)
                
                HStack {
                    HStack(spacing: 12) {
                        Image(systemName: "building.2")
                            .foregroundStyle(Color(.primaryBlack))
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        
                        Text("Hotel Bookings")
                            .foregroundStyle(Color(.primaryBlack))
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isDone ? "checkmark.circle.fill" : "circle.fill")
                        .foregroundStyle(Color(isDone ? .accentGreen : .defaultGray))
                        .font(.system(size: 22))
                }
                .padding(16)
                .background(Color(.primaryWhite))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color(isDone ? .accentGreen : .gray), radius: 4)
                .frame(width: .infinity, height: .infinity)
                
                HStack {
                    HStack(spacing: 12) {
                        Image(systemName: "creditcard")
                            .foregroundStyle(Color(.primaryBlack))
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        
                        Text("Bank Statement")
                            .foregroundStyle(Color(.primaryBlack))
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isDone ? "checkmark.circle.fill" : "circle.fill")
                        .foregroundStyle(Color(isDone ? .accentGreen : .defaultGray))
                        .font(.system(size: 22))
                }
                .padding(16)
                .background(Color(.primaryWhite))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color(isDone ? .accentGreen : .gray), radius: 4)
                .frame(width: .infinity, height: .infinity)
                
                Spacer()
                
                Button {
                    
                    isDone.toggle()
                    
                } label: {
                    Text("Continue")
                        .padding(.vertical, 7)
                        .frame(width: 369)
                        .font(.system(size: 15))
                        .foregroundStyle(Color(isDone ? .primaryWhite : .defaultGray))
                        .background(Color(isDone ? .primaryBlue : .lightGray))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .disabled(isDone ? false : true)
                
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
            .background(Color(.primaryWhite))
            
            Spacer()
        }
    }
}

#Preview {
    DocumentRequirementPage()
}
