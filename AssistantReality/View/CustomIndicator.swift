//
//  CustomIndicator.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 30/05/23.
//

import SwiftUI

struct CustomIndicator: View {
    var totalPage: Int
    var currentPage: Int
    var activeTint : Color = Color("third")
    var isInActiveTint: Color = Color("fourth")
    var body: some View {
        HStack(spacing: 3){
            ForEach(0..<totalPage, id: \.self){
                Circle()
                    .fill(currentPage == $0 ? activeTint : isInActiveTint)
                    .frame(width: 5, height: 5)
            }
        }
        
    }
}

struct CustomIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
