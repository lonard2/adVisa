//
//  DocumentRow.swift
//  adVisa
//
//  Created by Lonard Steven on 20/08/24.
//

import SwiftUI

struct DocumentRow: View {
    let document: Document
    @Binding var isDone: Bool
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                Image(systemName: document.icon)
                    .foregroundStyle(Color(.primaryBlack))
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                
                Text(document.title)
                    .foregroundStyle(Color(.primaryBlack))
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            Image(systemName: isDone ? "checkmark.circle.fill" : "circle.fill")
                .foregroundStyle(Color(isDone ? .accentGreen : .defaultGray))
                .font(.system(size: 22))
        }
        .padding(16)
        .background(Color(.primaryWhite))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: Color(isDone ? .accentGreen : .black.opacity(0.25)), radius: 4)
    }
}

//#Preview {
//    DocumentRow(document: <#Document#>, isDone: <#Binding<Bool>#>)
//}
