//
//  SuggestionView.swift
//  MV-Project
//
//  Created by Daniel Coria on 22/08/23.
//

import SwiftUI

struct SuggestionView: View {
    @EnvironmentObject private var store: Store
//    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        VStack {
            HStack {
                Button {
//                    dismissWindow(id: "SuggestionsWindow")
                } label: {
                    Text("Back")
                }

                Text("Title")
                    .font(.headline)
            }
            
            ScrollView (.horizontal) {
                HStack {
                    ForEach(store.products) { product in
                        AsyncImage(
                            url: URL(string: product.image),
                            content: { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 80)
                            }, placeholder:  {
                                ProgressView()
                                    .frame(width: 100)
                            })
                    }
                }
                
            }.task {
                await populateProducts()
            }
            .frame(height: 500)
            
        }
    }
}

extension SuggestionView {
    private func populateProducts() async {
        do {
            try await store.loadProducts()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    SuggestionView()
}
