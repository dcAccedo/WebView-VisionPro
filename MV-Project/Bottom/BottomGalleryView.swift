//
//  BottomGalleryView.swift
//  MV-Project
//
//  Created by Daniel Coria on 18/08/23.
//

import SwiftUI

struct BottomGalleryView: View {
    @EnvironmentObject private var store: Store
    @State var showFirst = false
    
    
    var body: some View {
        NavigationSplitView {
            VStack {
                Button {
                    
                } label: {
                    Text("Text 1")
                }
                
                Button {
                    
                } label: {
                    Text("Text 2")
                }
                
                Button {
                    
                } label: {
                    Text("Text 3")
                }
            }
        } detail: {
            Text("Select one")
            
        }
        
        #if os(visionOS)
        .glassBackgroundEffect()
        #endif
//        .frame(width: 1000, height: 1000)
    }
}

struct BottomGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogListScreen()
    }
}
