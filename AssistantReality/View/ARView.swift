//
//  ARView.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 01/06/23.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewController: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        if let usdzFile = Bundle.main.url(forResource: "Yari", withExtension: "usdz") {
            let anchor = try! Entity.load(contentsOf: usdzFile)
            let anchorEntity = AnchorEntity()
            anchorEntity.addChild(anchor)
            arView.scene.addAnchor(anchorEntity)
        
            // Add rotation gesture recognizer
            let rotationGesture = UIRotationGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleRotation(_:)))
            arView.addGestureRecognizer(rotationGesture)
        }
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject {
        @objc func handleRotation(_ gesture: UIRotationGestureRecognizer) {
            guard let arView = gesture.view as? ARView else { return }
            
            if let entity = arView.scene.anchors.first?.children.first {
                // Convert the rotation gesture's rotation to a desired rotation angle
                let rotationSpeed: Float = 1.0 // Adjust as needed
                let rotationAngle = Float(gesture.rotation) * rotationSpeed
                
                // Apply the rotation to the entity
                entity.transform.rotation *= simd_quatf(angle: rotationAngle, axis: SIMD3(x: 0, y: 1, z: 0))
                
                // Reset the gesture's rotation to prevent cumulative rotation
                gesture.rotation = 0
            }
        }
    }
}