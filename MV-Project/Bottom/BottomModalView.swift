//
//  BottomModalView.swift
//  MV-Project
//
//  Created by Daniel Coria on 22/08/23.
//

import SwiftUI

extension View {
    /// Adds a button in an ornament that opens a settings panel.
    func bottomModalButton() -> some View {
        self.modifier(
            BottomModalViewModifier()
        )
    }
}

// A modifier that adds a button that opens a settings panel.
private struct BottomModalViewModifier: ViewModifier {
    
    @State private var showSettings = false
    @Environment(\.openWindow) private var openWindow
    
    func body(content: Content) -> some View {
        content
#if os(visionOS)
            .ornament(
                visibility: showRightView ? .visible : .hidden,
                attachmentAnchor: .scene(alignment: .bottom)
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
