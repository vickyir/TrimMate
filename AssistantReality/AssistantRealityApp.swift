//
//  AssistantRealityApp.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 26/05/23.
//

import SwiftUI


@main
struct AssistantRealityApp: App {
    @State var splashScreen = true
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                if splashScreen{
                    SplashScreen()
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                                withAnimation{
                                    self.splashScreen = false
                                }
                            }
                        }
                }else{
                    
                    Home()
                        .navigationDestination(for: Destination.self) { destination in
                            ViewFactory.viewForDestination(destination)
                        }
                    
                }
            }
            .environmentObject(router)
            
            
           
        }
    }
}
