//
//  DObject.swift
//  MV-Project
//
//  Created by Daniel Coria on 28/08/23.
//

import SwiftUI
import RealityKit

struct DObject: View {
    var orientation: SIMD3<Double> = .zero
    var objectName: String = "Brazil-T-Shirt"
    
    var body: some View {
        TimelineView(.animation) { context in
            Model3D(named: objectName) { model in
                model
                    .resizable()
                    .scaledToFit()
                    .rotation3DEffect(
                        Rotation3D(
                            angle: Angle2D(degrees: 50 * context.date.timeIntervalSinceReferenceDate), axis: .y
                        )
                    )
                
            } placeholder: {
                ProgressView()
            }
            
        }
    }
}

#Preview {
    DObject()
}
