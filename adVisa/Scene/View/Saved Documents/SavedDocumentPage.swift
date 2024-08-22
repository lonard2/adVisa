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
    @State private var selectedDocument: Document = Document(icon: "", imageName: "", documentName: "", explanation: "")
    @State private var selectedDocumentType: DocumentTypeDetailed = .none
    @State var showDocumentSheet = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ForEach(viewModel.cardData) { data in
                    SavedDocumentCard(imageName:"template" , documentName: data.documentName, lastUpdated: "12.30")
                        .onTapGesture {
                            selectedDocument = data
                            
                            switch(selectedDocument.documentName) {
                            case "Passport (Bio Page)":
                                selectedDocumentType = .passport_bio
                            case "Passport (Endorsement Page)":
                                selectedDocumentType = .passport_endorsement
                            case "Identity Card (KTP)":
                                selectedDocumentType = .ktp
                            case "Self Portrait":
                                selectedDocumentType = .self_portrait
                            case "Bank Statement":
                                selectedDocumentType = .generic
                            case "Return Flight Bookings":
                                selectedDocumentType = .generic
                            case "Away Flight Booking":
                                selectedDocumentType = .generic
                            case "Hotel Bookings":
                                selectedDocumentType = .generic
                            case "Family Registered Card":
                                selectedDocumentType = .generic
                            case "none":
                                selectedDocumentType = .passport_bio
                            default:
                                selectedDocumentType = .none
                            }
                            
                            showDocumentSheet = true
                        }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .navigationTitle("Saved Documents")
            .sheet(isPresented: $showDocumentSheet, content: {
                UploadDocumentSheet(document: $selectedDocument, selectedDocumentType: $selectedDocumentType)
            })
            
            Spacer()
        }
    }
}

#Preview {    
    SavedDocumentPage()
}
