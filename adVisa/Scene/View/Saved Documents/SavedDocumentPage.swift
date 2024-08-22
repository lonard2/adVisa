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
        Document(icon: "", imageName: "template", documentName: "Passport (Bio Page)", explanation: "It’s the 2nd page of your Passport. It should be looked like the picture above. Use a solid background to take the photo."),
        Document(icon: "", imageName: "template", documentName: "Passport (Endorsement Page)", explanation: "It’s the 4rd page of your Passport. It should be looked like the picture above. Use a solid background to take the photo."),
        Document(icon: "", imageName: "template", documentName: "Identity Card (KTP)", explanation: "Front side picture of your ID Card (KTP). We recommends you to use a solid background. See the photo guide as the picture above."),
        Document(icon: "", imageName: "template", documentName: "Self Potrait", explanation: "A full-color clear image with a solid background. If you want to use an existing image, make sure that it’s taken no longer than 6 months ago. See the photo guide as the picture above.")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ForEach(cardData) { data in
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
