//
//  HistoryPage.swift
//  adVisa
//
//  Created by Dixon Willow on 22/08/24.
//

import SwiftUI

struct HistoryPage: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0){
                    
                    TextField("\(Image(systemName: "magnifyingglass")) Search Country", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(7)
                        .background(Color(.tertiarySystemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        Image("history_empty")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 35)
                        
                        Text("You have no history")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.lighterGray)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("History")
        }
    }
}

#Preview {
    HistoryPage()
}
