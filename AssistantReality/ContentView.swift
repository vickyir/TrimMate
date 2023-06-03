//
//  ContentView.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 26/05/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.light)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
