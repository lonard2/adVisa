//
//  DestinationCard.swift
//  adVisa
//
//  Created by Dixon Willow on 19/08/24.
//

import SwiftUI

struct DestinationCard: View {
    
    @State var countryName: String
    @State var countryImage: String
    @State var rank: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack {
                Image(countryImage)
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 132)
                    .clipped()
            }
            
            VStack(alignment:.leading, spacing: 4) {
                Text(countryName)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.primaryBlack))
                
                Text("\(rank) Most Visited")
                    .font(.system(size: 11))
                    .foregroundStyle(Color(.darkerGray))
            }
            .padding(8)
            
        }
        .background(Color(.primaryWhite))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.25), radius: 4, x: 0, y: 1)
        .frame(width: 132, height: 166)
    }
}

#Preview {
    DestinationCard(countryName: "Japan", countryImage: "japan_image", rank: "2nd")
}
