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
    var model3D : [HairModel]
    @Binding var showModel: Bool
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Start AR session
        let session = arView.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
        
        // Add coaching overlay
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.activatesAutomatically = true // Automatically hide the overlay
        coachingOverlay.delegate = context.coordinator // Set the delegate
        arView.addSubview(coachingOverlay)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(model3D: model3D)
    }
    
    class Coordinator: NSObject, ARCoachingOverlayViewDelegate {
        
        let model3D: [HairModel] // Add the model3D property
        var increment: Int = 0
        init(model3D: [HairModel]) {
            self.model3D = model3D
        }
        
        func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
            @AppStorage("faceshape") var myFaceShape: String = ""
            guard let arView = coachingOverlayView.superview as? ARView else { return }
            for i in 0..<self.model3D.count {
                let detailData = model3D[i]
                if detailData.faceType == myFaceShape{
                    
                    if let usdzFile = Bundle.main.url(forResource: "\(detailData.iconName)", withExtension: "usdz") {
                        let anchor = try! Entity.load(contentsOf: usdzFile)
                        let anchorEntity = AnchorEntity()
                        let textEntity = AnchorEntity()
                   
                        // Calculate the position of the anchor entity in a zigzag pattern
                        let column = increment % 3 // Number of columns
                        let row = increment / 3 // Number of rows
                        let spacing: Float = 1.0 // Adjust the spacing between objects
                        increment += 1
                        let position = SIMD3<Float>(x: Float(column) * spacing, y: 0, z: -Float(row)-1 * spacing)
                        anchorEntity.transform.matrix = matrix_identity_float4x4
                        anchorEntity.transform.translation = position
                        
                        let textPosition = SIMD3<Float>(x: position.x, y: position.y + 0.3, z: position.z)
                        textEntity.transform.matrix = matrix_identity_float4x4
                        textEntity.transform.translation = textPosition
                        
                        
                        if let usdzTubeShape = Bundle.main.url(forResource: "tubeShape", withExtension: "usdz"){
                            let tubeAnchor = try! Entity.load(contentsOf: usdzTubeShape)
                            let tubeShape = AnchorEntity()
                            
                            let tubeShapePosition = SIMD3<Float>(x: position.x, y: position.y + -0.5, z: position.z-0.1)
                            tubeShape.transform.matrix = matrix_identity_float4x4
                            tubeShape.transform.translation = tubeShapePosition
                            tubeShape.addChild(tubeAnchor)
                            arView.scene.addAnchor(tubeShape)
                        }
                        
                      
                        
                        textEntity.addChild(textGen(textString: "\(detailData.name)"))
                        anchorEntity.addChild(anchor)
                       
                    
                        
                        arView.scene.addAnchor(anchorEntity)
                        arView.scene.addAnchor(textEntity)
                       
                    }
                }
                
            }
        }
        
        func textGen(textString: String) -> ModelEntity {
            
            let materialVar = SimpleMaterial(color: .black, roughness: 0, isMetallic: true)
            
            let depthVar: Float = 0.001
            let fontVar = UIFont.systemFont(ofSize: 0.04)
            let containerFrameVar = CGRect(x: -0.25, y: -0.1, width: 0.5, height: 0.1)
            let alignmentVar: CTTextAlignment = .center
            let lineBreakModeVar : CTLineBreakMode = .byWordWrapping
            
            let textMeshResource : MeshResource = .generateText(textString,
                                                                extrusionDepth: depthVar,
                                                                font: fontVar,
                                                                containerFrame: containerFrameVar,
                                                                alignment: alignmentVar,
                                                                lineBreakMode: lineBreakModeVar)
            
            let textEntity = ModelEntity(mesh: textMeshResource, materials: [materialVar])
            
            return textEntity
        }
        
       
        
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


