//
//  ClassModalShow.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 02/06/23.
//

import SwiftUI

class ShowModal: ObservableObject{
    @Published var isActive: Bool = false
    
    func toggleBtn(){
        isActive.toggle()
    }
}
