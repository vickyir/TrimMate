//
//  ColorEnum.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 02/06/23.
//

import SwiftUI

enum myColor: String, CaseIterable, RawRepresentable{
    case primary
    case secondary
    case third
    case fourth
    
    var rawValue: Color{
        switch self{
        case .primary :
            return Color("primary")
        case .secondary :
            return Color("secondary")
        case .third :
            return Color("third")
        case .fourth :
            return Color("fourth")
        }
    }
}
