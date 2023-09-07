//
//  ImmersiveView.swift
//  MV-Project
//
//  Created by Daniel Coria on 29/08/23.
//

import SwiftUI
import RealityKit
import Combine

struct ImmersiveView: View {
    
    var body: some View {
        
        RealityView { content in
            let rootEntity = Entity()
            rootEntity.addBackground()
            content.add(rootEntity)
//            let entity = Entity()
//            var material = UnlitMaterial()
//            let resource = TextureResource.loadAsync(named: "arena")
//                .sink {
//                    switch $0 {
//                    case .finished: break
//                    case .failure(let error):  assertionFailure("\(error)")
//                    }
//                } receiveValue: { texture in
//                    
////                    guard let self = self else { return }
//                    material.color = .init(texture: .init(texture))
//                    entity.components.set(ModelComponent(
//                        mesh: .generateSphere(radius: 1E3),
//                        materials: [material]
//                    ))
//                    entity.scale *= .init(x: -1, y: 1, z: 1)
//                    entity.transform.translation += SIMD3<Float>(0.0, 1.0, 0.0)
//                    let angle = Angle.degrees(190)
//                    let rotation = simd_quatf(angle: Float(angle.radians), axis: SIMD3<Float>(0, 1, 0))
//                    entity.transform.rotation = rotation
//                    content.add(entity)
//                }
        }
    }
}

extension Entity {
    
    func addBackground() {
        var material = UnlitMaterial()
        guard let resource = try? TextureResource.load(named: "arena") else {
            fatalError("Unable to load starfield texture.")
        }
        material.color = .init(texture: .init(resource))
        self.components.set(ModelComponent(
            mesh: .generateSphere(radius: 1E3),
            materials: [material]
        ))
        self.scale *= .init(x: -1, y: 1, z: 1)
        self.transform.translation += SIMD3<Float>(0.0, 1.0, 0.0)
        let angle = Angle.degrees(190)
        let rotation = simd_quatf(angle: Float(angle.radians), axis: SIMD3<Float>(0, 1, 0))
        self.transform.rotation = rotation
    }
//    func addBackground() {
//        let subscription = TextureResource.loadAsync(named: "arena")
//            .sink(
//            receiveCompletion: {
//                switch $0 {
//                case .finished: break
//                case .failure(let error): 
//                    assertionFailure("\(error)")
//                }
//            },
//            receiveValue: { [weak self] texture in
//                guard let self = self else { return }
//                var material = UnlitMaterial()
//                material.color = .init(texture: .init(texture))
//                self.components.set(ModelComponent(
//                    mesh: .generateSphere(radius: 1E3),
//                    materials: [material]
//                ))
//                self.scale *= .init(x: -1, y: 1, z: 1)
//                self.transform.translation += SIMD3<Float>(0.0, 1.0, 0.0)
//            }
//        )
//        components.set(Entity.SubscriptionComponent(subscription: subscription))
//    }
    
    /// A container for the subscription that comes from asynchronous texture loads.
    ///
    /// In order for async loading callbacks to work we need to store
    /// a subscription somewhere. Storing it on a component will keep
    /// the subscription alive for as long as the component is attached.
    struct SubscriptionComponent: Component {
        var subscription: AnyCancellable
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
