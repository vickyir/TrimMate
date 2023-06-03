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
    var body: some Scene {
        WindowGroup {
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
                ContentView()
            }
           
        }
    }
}
