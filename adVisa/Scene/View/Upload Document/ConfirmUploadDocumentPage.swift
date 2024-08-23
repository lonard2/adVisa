//
//  ConfirmUploadDocumentPage.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct ConfirmUploadDocumentPage: View {
    
    @ObservedObject var viewModel = SavedDocumentViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State var documentName: String = ""
    @State var uploadedImageName: String = ""
    
    @State var retakePicture: Bool = false
    
    @Binding var captureComplete: Bool
    
    var body: some View {
        VStack {
            
            HStack(spacing: 10) {
                Button {
                    captureComplete.toggle()
                    retakePicture.toggle()
                } label: {
                    Text("Retake")
                        .padding(.vertical, 7)
                        .padding(.horizontal, 14)
                        .font(.system(size: 15))
                        .foregroundStyle(Color(.primaryWhite))
                }
                
                Text(documentName)
                    .padding(.horizontal)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.primaryWhite))
                
                Button {
                    captureComplete.toggle()
                    dismiss()
                } label: {
                    Text("Save")
                        .padding(.vertical, 7)
                        .padding(.horizontal, 14)
                        .font(.system(size: 15))
                        .foregroundStyle(Color(.primaryWhite))
                }
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(Color(.primaryBlue))
            
            VStack {
                
                Spacer()
                
                Text(uploadedImageName)
                    .multilineTextAlignment(.center)
                    .padding(10)
                
                Spacer()
            }
            .background(Color(.primaryWhite))
            
        }
        .fullScreenCover(isPresented: $retakePicture) {
            CameraLayerView(selectedDocument: viewModel.processedDocumentType, showDocumentSheet: .constant(false), captureComplete: $captureComplete)
                .ignoresSafeArea()
        }
        .background(Color.primaryWhite)
        .onAppear {
            switch(viewModel.processedDocumentType) {
            case .ktp:
                documentName = "KTP"
                uploadedImageName = "ktp" + "_" + UUID().uuidString
            case .passport_bio:
                documentName = "Passport Bio"
                uploadedImageName = "pass_bio" + "_" +  UUID().uuidString
            case .passport_endorsement:
                documentName = "Passport Endorsement"
                uploadedImageName = "pass_endorse" + "_" +  UUID().uuidString
            case .self_portrait:
                documentName = "My Self Portrait"
                uploadedImageName = "self" + "_" +  UUID().uuidString
            case .tiket_pesawat:
                documentName = "Flight Ticket"
                uploadedImageName = "ticket" + "_" +  UUID().uuidString
            case .hotel:
                documentName = "Accomodation"
                uploadedImageName = "accomodation" + "_" +  UUID().uuidString
            case .bank_statement:
                documentName = "Bank Statement"
                uploadedImageName = "bank" + "_" +  UUID().uuidString
            case .family_card:
                documentName = "Family Card"
                uploadedImageName = "fc" + "_" +  UUID().uuidString
            case .none:
                documentName = "KTP"
                uploadedImageName = "identity" + "_" +  UUID().uuidString
            }
        }
    }
}

#Preview {
    ConfirmUploadDocumentPage(documentName: "Passport (Bio Page)", uploadedImageName: "passport_bio_guide", captureComplete: .constant(true))
}

