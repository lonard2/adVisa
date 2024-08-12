//
//  ContentView.swift
//  adVisa
//
//  Created by Lonard Steven on 12/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.text.rectangle.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("adVisa!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
