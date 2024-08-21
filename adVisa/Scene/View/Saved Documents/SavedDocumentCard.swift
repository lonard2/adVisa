//
//  SavedDocumentCard.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI

struct SavedDocumentCard: View {
    
    @State var imageName: String
    @State var documentName: String
    @State var lastUpdated: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 112)
                .clipped()
            
            VStack(alignment: .leading, spacing: 0) {
                Text(documentName)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.primaryBlack))
                
                Text("Last Updated \(lastUpdated)")
                    .font(.system(size: 11))
                    .foregroundStyle(Color(.defaultGray))
            }
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(.primaryWhite))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.25), radius: 4, x: 0, y: 1)
        .frame(maxWidth: .infinity, maxHeight: 112)
    }
}

#Preview {
    SavedDocumentCard(imageName: "template", documentName: "Passport (Bio Page)", lastUpdated: "12.30")
}
