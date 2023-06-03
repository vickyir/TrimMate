//
//  SplashScreen.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 26/05/23.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        GeometryReader{
            geo in
            Image("or-1")
            Image("or-2")
                .position(x: geo.size.width, y: geo.size.height/5)
            Image("logo")
                .position(x: geo.size.width/2, y: geo.size.height/2)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("primary"))
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
