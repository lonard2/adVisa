//
//  ItineraryDetailsPage.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI
import SwiftData

struct ItineraryDetailsPage: View {
    
    let itineraries: [Itinerary] = [
        Itinerary(date: Date(), placeToVisit: "Hanaeda", placeToStay: "Hoshinoya")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack{
                Image("visa_header")
                    .resizable()
                    .scaledToFit()
                
                VStack(spacing: 20) {
                    Image("step_3")
                        .resizable()
                        .scaledToFit()
                    
                    VStack(spacing: 8) {
                        Text("ITINERARY DETAILS")
                            .foregroundStyle(Color(.primaryWhite))
                            .font(.system(size: 22))
                            .bold()
                        
                        Text("Tell more about your plans in there")
                            .foregroundStyle(Color(.primaryWhite))
                            .font(.system(size: 15))
                    }
                }
                .offset(y: -36)
            }
            .background(Color(.primaryBlue))
            
            VStack(alignment:.trailing, spacing: 12) {
                
                Button {
                    
                } label: {
                    HStack(spacing: 3) {
                        Image(systemName: "plus.app.fill")
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.primaryBlue))
                        
                        Text("Add more")
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.primaryBlue))
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(Color.primaryBlue.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                }
                
                ScrollView {
                    ForEach(itineraries) { itinerary in
                        ItineraryCard(itinerary: itinerary)
                    }
                }
                
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
    ItineraryDetailsPage()
}
