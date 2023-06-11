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
        
        
        
        arView.scene.anchors.append(faceShape)
        arView.session.delegate = self
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Access the front camera frame
        let _ = frame.camera
        // Use the camera data as needed
    }
}


struct ARMatchingView: View {
    @AppStorage("faceshape") var myFaceShape: String = ""
    @StateObject private var arSettings = ARSettings()
    @State var index : Int = 0
    
    var body: some View {
        NavigationView{
            ZStack{
                ARMatchingViewController()
                    .ignoresSafeArea()
                    .onTapGesture {
                        if index == 3{
                            index = 0
                        }else{
                            index += 1
                        }
                        
                        if index == 0{
                            myFaceShape = "diamond"
                        }else if index == 1{
                            myFaceShape = "rounded"
                        }else if index == 2{
                            myFaceShape = "oval"
                        }else{
                            myFaceShape = "circle"
                        }
                        
                    }
                
                VStack{
                    AnimatedGradientRoundedRectangle(selectedFaceShape: $index)
                        
                    NavigationLink{
                        ListRecommendatioView()
                            .navigationBarBackButtonHidden(true)
                    }label: {
                      
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: .infinity, height: 47)
                                .foregroundColor(myColor.fourth.rawValue)
                            Text("Select")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(myColor.primary.rawValue)
                                .tracking(0.54)
                            
                        }

                        //                    })
                    }
                   
                }
                .padding(50)
              
            }
            
        }
            
        
        
        
    }
}

struct AnimatedGradientRoundedRectangle: View {
    @State private var offsetY: CGFloat = 0
    @Binding var selectedFaceShape: Int
    var body: some View {
        
        GeometryReader{
            geo in
            
            VStack{
                
                HStack{
                    ForEach(0..<4){
                        index in
                        //                        Button(action: {
                        //                            self.selectedFaceShape = index
                        //                        }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 73, height: 73)
                                .foregroundColor(myColor.primary.rawValue)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(myColor.third.rawValue, lineWidth: selectedFaceShape == index ? 1 : 0)
                                )
                            Image("\(index+1)")
                                .resizable()
                                .frame(maxWidth: 80, maxHeight: 80)
                        }
                        //                        })
                        
                    }
                    
                }
                .position(x: geo.size.width/2, y: geo.size.height/1.2)
                
                

                
                
            }
        }
        
        
        
        
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

