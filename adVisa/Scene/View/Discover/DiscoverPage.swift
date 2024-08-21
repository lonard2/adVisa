//
//  DiscoverPage.swift
//  adVisa
//
//  Created by Dixon Willow on 19/08/24.
//

import SwiftUI

struct DiscoverPage: View {
    
    let countries = ["Turkey", "Hongkong", "Japan"]
    @State private var searchText = ""
    @State private var hasDocument = false
    
    var searchResults: [String] {
        return countries.filter { $0.contains(searchText) }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                ZStack{
                    Image("discover_header")
                        .resizable()
                        .scaledToFit()
                    Text("Discover what you need to travel.")
                        .foregroundStyle(Color(.white))
                        .font(.system(size: 16))
                        .bold()
                        .offset(y: -48)
                }
                
                VStack {
                    NavigationStack {
//                        List {
//                            ForEach(searchResults, id: \.self) { country in
//                                NavigationLink {
//                                    Text(country)
//                                } label: {
//                                    Text(country)
//                                }
//                            }
//                        }
//                        .listStyle(PlainListStyle())
                        
                        VStack(alignment: .leading) {
                            Text("Popular Destination")
                                .font(.system(size:25))
                                .fontWeight(.semibold)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(countries, id: \.self) { country in
                                        NavigationLink {
                                            Text(country)
                                        } label: {
                                            DestinationCard(countryName: country)
                                                .padding(.horizontal, 16)
                                                .padding(.vertical)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        if !hasDocument {
                            PersonalDocumentGuideCard()
                        } else {
                            EmptyView()
                        }
                        
                        Spacer()
                    }
                    .searchable(text: $searchText, prompt: "Search Country")
                }
                .background(Color(.primaryWhite))
            }
        }
        .background(Color(.primaryBlue))
    }
}

#Preview {
    DiscoverPage()
}
