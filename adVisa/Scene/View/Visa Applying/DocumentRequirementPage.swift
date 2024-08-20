//
//  DocumentRequirementPage.swift
//  adVisa
//
//  Created by Dixon Willow on 19/08/24.
//

import SwiftUI
import SwiftData

struct DocumentRequirementPage: View {
    
    @State private var isDone: Bool = false
    
    let documents: [Document] = [
        Document(icon: "airplane.departure", title: "Away Flight Booking"),
        Document(icon: "airplane.arrival", title: "Return Flight Booking"),
        Document(icon: "building.2", title: "Hotel Bookings"),
        Document(icon: "creditcard", title: "Bank Statement")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack{
                Image("visa_header")
                
                VStack(spacing: 20) {
                    Image("step_1")
                    
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
                    DocumentRow(document: document, isDone: $isDone)
                }
                
                Spacer()
                
                Button {
                    
                    isDone.toggle()
                    
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
    
}

#Preview {
    DocumentRequirementPage()
        .modelContainer(for: Document.self)
}
