//
//  SavedDocumentPage.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI
import SwiftData

struct SavedDocumentPage: View {
    
    @StateObject var viewModel = SavedDocumentViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ForEach(viewModel.cardData) { data in
                    SavedDocumentCard(imageName: data.imageName, documentName: data.documentName, lastUpdated: "12.30")
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .navigationTitle("Saved Documents")
            
            Spacer()
        }
    }
}

#Preview {    
    SavedDocumentPage()
}
