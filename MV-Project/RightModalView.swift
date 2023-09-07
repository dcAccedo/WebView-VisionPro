//
//  RightModalView.swift
//  MV-Project
//
//  Created by Daniel Coria on 18/08/23.
//

import SwiftUI

var showRightView = true

extension View {
    /// Adds a button in an ornament that opens a settings panel.
    func rightModalButton() -> some View {
        self.modifier(
            RightModalViewModifier()
        )
    }
}

// A modifier that adds a button that opens a settings panel.
private struct RightModalViewModifier: ViewModifier {
    
    @State private var showSettings = false
    @Environment(\.openWindow) private var openWindow
    
    func body(content: Content) -> some View {
        content
        #if os(visionOS)
            .ornament(
                visibility: showRightView ? .visible : .hidden,
                attachmentAnchor: .scene(alignment: .trailing)
            ) {
                Button {
                    openWindow(id: "SuggestionsWindow")
                } label: {
                    Text("See Cast")
                }
            }
            .glassBackgroundEffect()
        #endif
    }
}
