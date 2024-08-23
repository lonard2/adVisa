//
//  SavedDocumentViewModel.swift
//  adVisa
//
//  Created by Dixon Willow on 22/08/24.
//

import Foundation
import Combine

class SavedDocumentViewModel: ObservableObject {
    
    @Published var cardData: [Document] = [
        Document(icon: "", imageName: "passport_bio_guide", documentName: "Passport (Bio Page)", explanation: "It’s the 2nd page of your Passport. It should be looked like the picture above. Use a solid background to take the photo."),
        Document(icon: "", imageName: "identity_card_guide", documentName: "Identity Card (KTP)", explanation: "Front side picture of your ID Card (KTP). We recommends you to use a solid background. See the photo guide as the picture above."),
    ]
    
    @Published var alreadyTakenPicture: Bool = false
    @Published var processedDocumentType: DocumentTypeDetailed = .none
    
}
