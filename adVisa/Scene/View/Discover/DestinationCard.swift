//
//  DestinationCard.swift
//  adVisa
//
//  Created by Dixon Willow on 19/08/24.
//

import SwiftUI

struct DestinationCard: View {
    
    @State var countryName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack {
                Image("identity_card_guide")
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }
            
            VStack(alignment:.leading, spacing: 4) {
                Text(countryName)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.primaryBlack))
                
                Text("1st Most Visited")
                    .font(.system(size: 11))
                    .foregroundStyle(Color(.darkGray))
            }
            .padding(8)
            
        }
        .background(Color(.primaryWhite))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 4, x: 0, y: 1)
        .frame(width: 132, height: 166)
    }
}

#Preview {
    DestinationCard(countryName: "Japan")
}
