//
//  DataPolicy.swift
//  adVisa
//
//  Created by hendra on 16/08/24.
//

import SwiftUI

struct DataPolicy: View {
    @State private var showingSheet = false
    @ObservedObject var viewModel: DataPolicyViewModel = DataPolicyViewModel()
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        
        .sheet(isPresented: $showingSheet) {
            DataPolicySheet()
                .environmentObject(viewModel)
                .presentationDragIndicator(.visible)
                
        }
        
    }
}

#Preview {
    DataPolicy()
}
