//
//  ItineraryCard.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct ItineraryCard: View {
    
    var itinerary: Itinerary
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Date")
                    .foregroundStyle(Color(.primaryBlack))
                    .font(.system(size: 17))
                
                DatePicker("", selection: .constant(itinerary.date), displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Where do yo want to go?")
                    .foregroundStyle(Color(.primaryBlack))
                    .font(.system(size: 17))
                
                TextField("Place to Visit", text: .constant(itinerary.placeToVisit))
                    .padding(.vertical, 2)
                    .padding(.horizontal, 6)
                    .background(Color(.primaryWhite))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .textInputAutocapitalization(.words)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Where will you stay?")
                    .foregroundStyle(Color(.primaryBlack))
                    .font(.system(size: 17))
                
                TextField("Place to Stay", text: .constant(itinerary.placeToStay))
                    .padding(.vertical, 2)
                    .padding(.horizontal, 6)
                    .background(Color(.primaryWhite))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .textInputAutocapitalization(.words)
            }
        }
        .padding(12)
        .background(Color(.blueTint))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black.opacity(0.25) ,radius: 4)
        .frame(width: .infinity, height: .infinity)
    }
}

//#Preview {
//    ItineraryCard(itinerary: Itinerary(date: Date(), placeToVisit: "Hanaeda", placeToStay: "Hoshinoya"))
//}
