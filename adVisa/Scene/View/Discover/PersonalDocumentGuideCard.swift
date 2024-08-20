//
//  PersonalDocumentGuideCard.swift
//  adVisa
//
//  Created by Dixon Willow on 19/08/24.
//

import SwiftUI

struct PersonalDocumentGuideCard: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .trailing, spacing: 12) {
                VStack(alignment:.leading, spacing: 12) {
                    Text("Input Your Personal Documents")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    
                    Text("Saved Document feature enables you to save your personal data easily through scanning your personal documents to help you efficiently auto-fill and complete your visa application directly within the app.")
                        .font(.system(size: 13))
                        .foregroundStyle(Color(.darkerGray))
                }
                
                NavigationLink {
                    //TODO: Insert Navigation Link
                } label: {
                    Text("Input Documents")
                        .frame(width: .infinity, height: .infinity)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 14)
                        .background(Color(.primaryBlue))
                        .foregroundStyle(Color(.primaryWhite))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
            }
            .padding(12)
            .background(Color(.blueTint))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    PersonalDocumentGuideCard()
}
