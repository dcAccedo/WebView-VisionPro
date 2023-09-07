//
//  ContentView.swift
//  MV-Project
//
//  Created by Daniel Coria on 01/08/23.
//

import SwiftUI

struct CatalogListScreen: View {
    @EnvironmentObject private var store: Store
    
    @Environment(\.openWindow) private var openWindow
//    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        
        VStack {
            Button(action: {
//                dismissWindow(id: "SecondWindow")
                print("Show Second Window")
            }) {
                Text("Dismiss Second Window")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(.plain)
            
            List(store.products) { product in
                HStack {
                    AsyncImage(
                        url: URL(string: product.image),
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                        }, placeholder:  {
                            ProgressView()
                                .frame(width: 100)
                        })
                    
                    Text(product.title)
                }
                
            }.task {
                await populateProducts()
            }
            
            HStack {
                Button {
                    openWindow(id: "WebView1")
                } label: {
                    Text("First")
                }
                
                Button {
                    
                } label: {
                    Text("Second")
                }
            }
            Spacer()
        }
        .rightModalButton()
    }
}

extension CatalogListScreen {
    private func populateProducts() async {
        do {
            try await store.loadProducts()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CatalogListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CatalogListScreen()
    }
}
