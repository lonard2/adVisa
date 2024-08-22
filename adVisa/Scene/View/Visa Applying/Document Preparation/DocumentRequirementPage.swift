//
//  DocumentRequirementPage.swift
//  adVisa
//
//  Created by Dixon Willow on 19/08/24.
//

import SwiftUI
import SwiftData

struct DocumentRequirementPage: View {
    
    @State private var isDone: Bool = true
    @State private var showSheet: Bool = false
    @State private var selectedDocument: Document = Document(icon: "", imageName: "", documentName: "", explanation: "")
    
    @State private var selectedDocumentType: DocumentTypeDetailed = .none
    
    let documents: [Document] = [
        Document(icon: "airplane.departure", imageName: "flight_booking_guide_1", documentName: "Away Flight Booking", explanation: "Kindly provide your away flight booking confirmation or a screenshot of your flight ticket’s details. You can take a picture of a print-out copy or take a screenshot of any OTA you use and choose it from Photos."),
        Document(icon: "airplane.arrival", imageName: "flight_booking_guide_2", documentName: "Return Flight Booking", explanation: "Kindly provide your return flight booking confirmation or a screenshot of your flight ticket’s details. You can take a picture of a print-out copy or take a screenshot of any OTA you use and choose it from Photos."),
        Document(icon: "building.2", imageName: "accomodation_guide", documentName: "Hotel Bookings", explanation: "Kindly provide your hotel booking confirmation or a screenshot of your hotel booking details. You can take a picture of a print-out copy or take a screenshot of any OTA you use and choose it from Photos."),
        Document(icon: "creditcard", imageName: "bank_statement_guide", documentName: "Bank Statement", explanation: "A photo or scan of your bank statements/bank copy from the latest 3 months. Make sure that it mentioned your account’s name, number, and the bank’s name. ")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ZStack{
                    Image("visa_header")
                        .resizable()
                        .scaledToFit()
                    
                    VStack(spacing: 20) {
                        Image("step_1")
                            .resizable()
                            .scaledToFit()
                        
                        VStack(spacing: 8) {
                            Text("DOCUMENT REQUIREMENT")
                                .foregroundStyle(Color(.primaryWhite))
                                .font(.system(size: 22))
                                .bold()
                            
                            Text("Prepare and input your document")
                                .foregroundStyle(Color(.primaryWhite))
                                .font(.system(size: 15))
                        }
                    }
                    .offset(y: -36)
                }
                .background(Color(.primaryBlue))
                
                VStack(spacing: 20) {
                    
                    ForEach(documents) { document in
                        DocumentRow(document: document)
                            .onTapGesture {
                                selectedDocument = document
                                
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
                                case "none":
                                    selectedDocumentType = .passport_bio
                                default:
                                    selectedDocumentType = .none
                                }
                                
                                showSheet = true
                            }
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        
                        VisaFormPage()
                            .navigationBarBackButtonHidden(true)
                        
                    } label: {
                        Text("Continue")
                            .padding(.vertical, 7)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 15))
                            .foregroundStyle(Color(isDone ? .primaryWhite : .defaultGray))
                            .background(Color(isDone ? .primaryBlue : .lighterGray))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .disabled(isDone ? false : true)
                    
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 16)
                .background(Color(.primaryWhite))
                
                Spacer()
            }
        }
        .sheet(isPresented: $showSheet, content: {
            UploadDocumentSheet(document: $selectedDocument, selectedDocumentType: $selectedDocumentType)
        })
    }
}

#Preview {
    DocumentRequirementPage()
}
