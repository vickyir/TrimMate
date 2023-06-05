import SwiftUI
import SceneKit

struct PreviewView: UIViewRepresentable {
    @Binding var scene: SCNScene?
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.delegate = context.coordinator as? any SCNSceneRendererDelegate
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.scene = scene
        view.backgroundColor = .clear
        
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan(_:)))
        view.addGestureRecognizer(panGesture)
        
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
    
    class Coordinator: NSObject {
        var lastPanTranslation: CGPoint = .zero
        let loopingAreaRect = CGRect(x: -5, y: -5, width: 10, height: 10) // Define the looping area rectangle
        
        @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
               guard let view = gestureRecognizer.view as? SCNView else { return }
               
               if gestureRecognizer.state == .began {
                   lastPanTranslation = gestureRecognizer.translation(in: view)
               } else if gestureRecognizer.state == .changed {
                   let translation = gestureRecognizer.translation(in: view)
                   let rotationScale: Float = 0.03 // Adjust this value to control rotation speed
                   
                   let delta = CGPoint(x: translation.x - lastPanTranslation.x, y: translation.y - lastPanTranslation.y)
                   
                   // Only rotate horizontally if the swipe distance in the X-axis is greater than the Y-axis
                   if abs(delta.x) > abs(delta.y) {
                       let rotation = SCNVector3(0, Float(delta.x) * rotationScale, 0) // Rotate only on the Y-axis
                       
                       view.allowsCameraControl = false
                       view.scene?.rootNode.childNodes.forEach { childNode in
                           // Check if the object is within the looping area
                           let childNodePosition = childNode.presentation.position
                           
                           // Check if the object belongs to the "All" or "Favorite" section
                           let isFavorite = childNode.name?.lowercased() == "favorite" // Assuming the favorite objects have a specific name or identifier
                           let isAll = childNode.name?.lowercased() == "all" // Assuming the objects in the "All" section have a specific name or identifier
                           
                           if loopingAreaRect.contains(CGPoint(x: CGFloat(childNodePosition.x), y: CGFloat(childNodePosition.z))) {
                               if (isFavorite && isAll) || (!isFavorite && !isAll) {
                                   let currentRotation = childNode.eulerAngles
                                   let updatedRotation = SCNVector3(currentRotation.x + rotation.x,
                                                                    currentRotation.y + rotation.y,
                                                                    currentRotation.z + rotation.z)
                                   childNode.eulerAngles = updatedRotation
                               }
                           }
                       }
                       
                       lastPanTranslation = translation
                   }
               } else if gestureRecognizer.state == .ended {
                   view.allowsCameraControl = true
               }
           }
       }
}
