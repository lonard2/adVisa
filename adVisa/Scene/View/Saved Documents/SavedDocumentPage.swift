//
//  SavedDocumentPage.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI
import SwiftData

struct SavedDocumentPage: View {
    
    let cardData: [Document] = [
        Document(icon: "template", title: "Passport (Bio Page)"),
        Document(icon: "template", title: "Passport (Endorsement Page)"),
        Document(icon: "template", title: "Identity Card (KTP)"),
        Document(icon: "template", title: "Family Registry Card")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ForEach(cardData) { data in
                    SavedDocumentCard(imageName: data.icon, documentName: data.title, lastUpdated: "12.30")
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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Document.self, configurations: config)
    
    return SavedDocumentPage()
        .modelContainer(container)
}
