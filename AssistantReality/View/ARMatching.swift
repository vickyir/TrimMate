//
//  ARMatching.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 06/06/23.
//

import SwiftUI

import SwiftUI
import ARKit
import RealityKit

struct ARMatchingViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ARViewControllerWrapper {
        let viewController = ARViewControllerWrapper()
        viewController.arView.session = ARSession()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ARViewControllerWrapper, context: Context) {}
}

class ARViewControllerWrapper: UIViewController, ARSessionDelegate {
    let arView = ARView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView.frame = view.bounds
        view.addSubview(arView)
        arView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        arView.session.run(configuration)
        
        arView.session.delegate = self
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Access the front camera frame
        let camera = frame.camera
        // Use the camera data as needed
    }
}


struct ARMatchingView: View {
    @StateObject private var arSettings = ARSettings()
    
    var body: some View {
        ARMatchingViewController()
        
    }
}

class ARSettings: ObservableObject {
    // Add any additional AR settings here if needed
    @Published var useFrontCamera: Bool = false {
        didSet {
            if useFrontCamera {
                let configuration = ARFaceTrackingConfiguration()
                configuration.isLightEstimationEnabled = true
                ARView.appearance().session.run(configuration)
            } else {
                let configuration = ARWorldTrackingConfiguration()
                configuration.isLightEstimationEnabled = true
                ARView.appearance().session.run(configuration)
            }
        }
    }
}

struct ARMatching_Previews: PreviewProvider {
    static var previews: some View {
        ARMatchingView()
    }
}

