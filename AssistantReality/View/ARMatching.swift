//
//  ARMatching.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 06/06/23.
//

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
        
        let faceShape = try! FaceShapeTest.loadScene()
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        arView.session.run(configuration)
        
        
        
        //        arView.scene.anchors.append(faceShape)
        arView.session.delegate = self
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Access the front camera frame
        let camera = frame.camera
        // Use the camera data as needed
    }
}


struct ARMatchingView: View {
    let gradientColors: [Color] = [.clear, Color("#03ADB5")]
    
    @StateObject private var arSettings = ARSettings()
    
    var body: some View {
        
        ARMatchingViewController()
            .ignoresSafeArea().overlay(
                ZStack{
                    AnimatedGradientRoundedRectangle()
                        .padding(50)
                }
            )
        
    }
}

struct AnimatedGradientRoundedRectangle: View {
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20).fill(Color.white).frame(width: 200, height: 200).overlay(
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(#colorLiteral(red: 0.01, green: 0.67, blue: 0.71, alpha: 0)),
                            Color(#colorLiteral(red: 0.01, green: 0.67, blue: 0.71, alpha: 1))
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .mask(
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .offset(y: offsetY)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                )
                .animation(
                    Animation.easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true)
                )
                .onAppear {
                    self.offsetY = -200 // Set the initial offset outside the view bounds to animate from the top
                }).opacity(0.5)
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

