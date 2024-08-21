//
//  DocumentRow.swift
//  adVisa
//
//  Created by Lonard Steven on 20/08/24.
//

import SwiftUI

struct DocumentRow: View {
    let document: Document
    @State var isUploaded: Bool = false
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                Image(systemName: document.icon)
                    .foregroundStyle(Color(.primaryBlack))
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                
                Text(document.documentName)
                    .foregroundStyle(Color(.primaryBlack))
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            Image(systemName: isUploaded ? "checkmark.circle.fill" : "circle.fill")
                .foregroundStyle(Color(isUploaded ? .accentGreen : .defaultGray))
                .font(.system(size: 22))
        }
        .padding(16)
        .background(Color(.primaryWhite))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: Color(isUploaded ? .accentGreen : .black.opacity(0.25)), radius: 4)
    }
}

//#Preview {
//    DocumentRow(document: <#Document#>, isDone: <#Binding<Bool>#>)
//}
